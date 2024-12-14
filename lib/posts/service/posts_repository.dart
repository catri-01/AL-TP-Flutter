import 'package:tp_al/posts/service/posts_data_source/posts_data_source.dart';

import 'package:tp_al/posts/models/post.dart';

class PostsRepository {
  PostsDataSource postsDataSource;

  PostsRepository({
    required this.postsDataSource
  });

  final List<Post> _fakePosts = const [];

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }
  @override
  Future<Post> createPost(Post postToAdd) async {
    await Future.delayed(const Duration(seconds: 1));
    /// Add the post to the list
  }
  @override
  Future<Post> updatePost(Post newPost) async {
    await Future.delayed(const Duration(seconds: 1));
    /// Update the post in the list
  }
}