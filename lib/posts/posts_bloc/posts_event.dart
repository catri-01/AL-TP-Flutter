part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

class GetAllPosts extends PostsEvent {}

class CreatePost extends PostsEvent {
  final Post postToAdd;

  CreatePost({required this.postToAdd});
}

class UpdatePost extends PostsEvent {
  final Post newPost;

  UpdatePost({required this.newPost});
}
