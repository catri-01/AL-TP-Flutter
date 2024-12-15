import 'package:tp_al/posts/posts_bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tp_al/posts/models/post.dart';
import 'package:tp_al/posts/posts_screen/widget/post_item.dart';
import 'package:tp_al/posts/posts_screen/create_post_screen/create_post_screen.dart';
import 'package:tp_al/posts/posts_screen/post_detail_screen/post_detail_screen.dart';

class PostsScreen extends StatefulWidget {
  static const routeName = '/';

  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchPosts();
  }

  void _fetchPosts() {
    context.read<PostsBloc>().add(GetAllPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          switch (state.status) {
            case PostsStatus.fetchingPosts:
              return const Center(child: CircularProgressIndicator());
            case PostsStatus.errorFetchingPosts:
              return _buildErrorFetchingPosts(context);
            default:
              return _buildPostsList(context, state.posts);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddPostScreen(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPostsList(BuildContext context, List<Post> posts) {
    if (posts.isEmpty) {
      return const Center(child: Text('No posts'));
    }

    return Container(
      color: Colors.grey[50], // Fond légèrement gris
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostItem(
            post: post,
            onTap: () => _onPostTap(context, post),
          );
        },
      ),
    );
  }

  Widget _buildErrorFetchingPosts(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('An error occured'),
          ElevatedButton(
            onPressed: () => _fetchPosts(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _openAddPostScreen(BuildContext context) {
    CreatePostScreen.navigateTo(context);
  }

  void _onPostTap(BuildContext context, Post post) {
    PostDetailScreen.navigateTo(context, post);
  }
}