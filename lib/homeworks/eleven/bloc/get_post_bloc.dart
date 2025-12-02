import 'package:dio/dio.dart';
import 'package:flutter_application_grebenyuk/homeworks/eleven/bloc/get_post_event.dart';
import 'package:flutter_application_grebenyuk/homeworks/eleven/bloc/get_post_state.dart';
import 'package:flutter_application_grebenyuk/homeworks/eleven/constants/eleven_constants.dart';
import 'package:flutter_application_grebenyuk/homeworks/eleven/services/post_remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetPostBloc extends Bloc<GetPostEvent, GetPostState> {
  GetPostBloc({required PostRemoteDataSource postRemoteDataSource})
    : _postRemoteDataSource = postRemoteDataSource,
      super(const GetPostState()) {
    on<GetPostsRequested>(_onGetPostsRequested);
    on<GetPostCommentsRequested>(_onGetPostCommentsRequested);
    on<CommentsViewClosed>(_onCommentsViewClosed);
    on<DeletePostRequested>(_onDeletePostRequested);
    on<PostActionMessageCleared>(_onPostActionMessageCleared);
  }

  final PostRemoteDataSource _postRemoteDataSource;

  Future<void> _onGetPostsRequested(
    GetPostsRequested event,
    Emitter<GetPostState> emit,
  ) async {
    emit(
      state.copyWith(
        status: GetPostStatus.loadingPosts,
        comments: const [],
        clearSelectedPost: true,
        clearError: true,
        clearNotification: true,
      ),
    );
    try {
      final posts = await _postRemoteDataSource.getPosts();
      emit(
        state.copyWith(
          status: GetPostStatus.postsLoaded,
          posts: posts,
          comments: const [],
          clearSelectedPost: true,
          clearError: true,
          clearNotification: true,
        ),
      );
    } on DioException catch (error) {
      emit(
        state.copyWith(
          status: GetPostStatus.failure,
          errorMessage: error.message ?? 'Не вдалося завантажити пости',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: GetPostStatus.failure,
          errorMessage: 'Неочікувана помилка: $error',
        ),
      );
    }
  }

  Future<void> _onGetPostCommentsRequested(
    GetPostCommentsRequested event,
    Emitter<GetPostState> emit,
  ) async {
    emit(
      state.copyWith(
        status: GetPostStatus.loadingComments,
        selectedPostId: event.postId,
        clearError: true,
        clearNotification: true,
      ),
    );
    try {
      final comments = await _postRemoteDataSource.getCommentsByPost(
        event.postId,
      );
      emit(
        state.copyWith(
          status: GetPostStatus.commentsLoaded,
          comments: comments,
          clearNotification: true,
        ),
      );
    } on DioException catch (error) {
      emit(
        state.copyWith(
          status: GetPostStatus.failure,
          errorMessage: error.message ?? 'Не вдалося завантажити коментарі',
          clearNotification: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: GetPostStatus.failure,
          errorMessage: 'Неочікувана помилка: $error',
        ),
      );
    }
  }

  void _onCommentsViewClosed(
    CommentsViewClosed event,
    Emitter<GetPostState> emit,
  ) {
    if (state.posts.isEmpty) return;
    emit(
      state.copyWith(
        status: GetPostStatus.postsLoaded,
        comments: const [],
        clearSelectedPost: true,
        clearError: true,
        clearNotification: true,
      ),
    );
  }

  Future<void> _onDeletePostRequested(
    DeletePostRequested event,
    Emitter<GetPostState> emit,
  ) async {
    if (event.postId == 0) return;
    final deletingIds = <int>{...state.deletingPostIds, event.postId};
    emit(state.copyWith(deletingPostIds: deletingIds, clearNotification: true));
    try {
      await _postRemoteDataSource.deletePost(event.postId);
      final updatedPosts =
          state.posts.where((post) => post.id != event.postId).toList();
      final shouldResetSelection = state.selectedPostId == event.postId;
      final updatedDeleting = <int>{...state.deletingPostIds}
        ..remove(event.postId);
      emit(
        state.copyWith(
          status:
              shouldResetSelection ? GetPostStatus.postsLoaded : state.status,
          posts: updatedPosts,
          comments: shouldResetSelection ? const [] : state.comments,
          clearSelectedPost: shouldResetSelection,
          clearError: true,
          deletingPostIds: updatedDeleting,
          notificationMessage: ElevenTexts.deleteSuccess,
        ),
      );
    } catch (error) {
      final updatedDeleting = <int>{...state.deletingPostIds}
        ..remove(event.postId);
      emit(
        state.copyWith(
          deletingPostIds: updatedDeleting,
          notificationMessage: ElevenTexts.deleteError,
        ),
      );
    }
  }

  void _onPostActionMessageCleared(
    PostActionMessageCleared event,
    Emitter<GetPostState> emit,
  ) {
    if (state.notificationMessage == null) return;
    emit(state.copyWith(clearNotification: true));
  }
}
