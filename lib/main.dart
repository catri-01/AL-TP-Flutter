import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_al/posts/posts_bloc/posts_bloc.dart';
import 'package:tp_al/posts/posts_screen/create_post_screen/create_post_screen.dart';
import 'package:tp_al/posts/posts_screen/post_screen.dart';
import 'package:tp_al/posts/service/posts_data_source/fake_posts_data_source.dart';
import 'package:tp_al/posts/service/posts_repository.dart';
import 'package:tp_al/posts/posts_screen/post_detail_screen/post_detail_screen.dart';
import 'package:tp_al/posts/models/post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(
        postsRepository: PostsRepository(
          postsDataSource: FakePostsDataSource(),
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TP Flutter 5AL',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        onGenerateRoute: (settings) {
          // Route par défaut
          if (settings.name == '/') {
            return MaterialPageRoute(
              builder: (_) => const PostsScreen(),
            );
          }

          // Route pour créer un post
          if (settings.name == CreatePostScreen.routeName) {
            return MaterialPageRoute(
              builder: (_) => CreatePostScreen(),
            );
          }

          // Route pour le détail d'un post
          if (settings.name == PostDetailScreen.routeName) {
            final post = settings.arguments as Post;
            return MaterialPageRoute(
              builder: (_) => PostDetailScreen(post: post),
            );
          }

          // Route par défaut si aucune correspondance
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text('Page non trouvée'),
              ),
            ),
          );
        },
      ),
    );
  }
}