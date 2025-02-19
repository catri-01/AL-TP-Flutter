part of 'posts_bloc.dart';

enum PostsStatus {
  initial,
  loading,
  success,
  error,
  fetchingPosts,
  creatingPosts,
  updatingPost,
  fetchedPosts,
  createdPost,
  updatedPost,
  errorFetchingPosts,
  errorCreatingPost,
  errorUpdatingPost
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
    AppException? exception,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      exception: exception,
    );
  }
}
