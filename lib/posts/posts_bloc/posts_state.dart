part of 'posts_bloc.dart';

enum PostsStatus {
  initial,
  loading,
  success,
  error,
}

class PostsState {
  final PostsStatus status;
  final List<Post> posts;
  final AppException? exception;

  const PostsState({
    this.status = PostsStatus.initial,
    this.posts = const <Post>[],
    this.exception,
  });

  PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      exception: exception ?? this.exception,
    );
  }
}
