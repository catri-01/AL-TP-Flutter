import 'package:tp_al/posts/service/posts_data_source/posts_data_source.dart';

import 'package:tp_al/posts/models/post.dart';

class PostsRepository {
  PostsDataSource postsDataSource;

  PostsRepository({
    required this.postsDataSource
  });

  @override
  Future<List<Post>> getAllPosts() async {
    return await postsDataSource.getAllPosts();
  }
  @override
  Future<Post> createPost(Post postToAdd) async {
    return await postsDataSource.createPost(postToAdd);
  }
  @override
  Future<Post> updatePost(Post newPost) async {
    return await postsDataSource.updatePost(newPost);
  }
}