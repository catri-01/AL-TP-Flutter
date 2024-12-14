import 'package:tp_al/posts/models/post.dart';

abstract class PostsDataSource {

  Future<List<Post>> getAllPosts();

  Future<Post> createPost(Post postToAdd);

  Future<Post> updatePost(Post newPost);
}