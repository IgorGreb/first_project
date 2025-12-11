import 'package:equatable/equatable.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_11/models/comment_model.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_11/models/post_model.dart';

enum GetPostStatus {
  initial,
  loadingPosts,
  postsLoaded,
  loadingComments,
  commentsLoaded,
  failure,
}

class GetPostState extends Equatable {
  const GetPostState({
    this.status = GetPostStatus.initial,
    this.posts = const [],
    this.comments = const [],
    this.selectedPostId,
    this.errorMessage,
    this.notificationMessage,
    Set<int>? deletingPostIds,
  }) : deletingPostIds = deletingPostIds ?? const <int>{};

  final GetPostStatus status;
  final List<PostModel> posts;
  final List<CommentModel> comments;
  final int? selectedPostId;
  final String? errorMessage;
  final String? notificationMessage;
  final Set<int> deletingPostIds;

  GetPostState copyWith({
    GetPostStatus? status,
    List<PostModel>? posts,
    List<CommentModel>? comments,
    int? selectedPostId,
    bool clearSelectedPost = false,
    String? errorMessage,
    bool clearError = false,
    String? notificationMessage,
    bool clearNotification = false,
    Set<int>? deletingPostIds,
  }) {
    return GetPostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
      selectedPostId:
          clearSelectedPost ? null : (selectedPostId ?? this.selectedPostId),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      notificationMessage: clearNotification
          ? null
          : (notificationMessage ?? this.notificationMessage),
      deletingPostIds: deletingPostIds ?? this.deletingPostIds,
    );
  }

  @override
  List<Object?> get props => [
        status,
        posts,
        comments,
        selectedPostId,
        errorMessage,
        notificationMessage,
        deletingPostIds,
      ];
}
