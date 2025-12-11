import 'package:equatable/equatable.dart';

sealed class GetPostEvent extends Equatable {
  const GetPostEvent();

  @override
  List<Object?> get props => [];
}

final class GetPostsRequested extends GetPostEvent {
  const GetPostsRequested();
}

final class GetPostCommentsRequested extends GetPostEvent {
  final int postId;

  const GetPostCommentsRequested({required this.postId});

  @override
  List<Object?> get props => [postId];
}

final class CommentsViewClosed extends GetPostEvent {
  const CommentsViewClosed();
}

final class DeletePostRequested extends GetPostEvent {
  final int postId;

  const DeletePostRequested({required this.postId});

  @override
  List<Object?> get props => [postId];
}

final class PostActionMessageCleared extends GetPostEvent {
  const PostActionMessageCleared();
}
