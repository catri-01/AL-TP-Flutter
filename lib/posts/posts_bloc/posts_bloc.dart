import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:tp_al/posts/service/posts_repository.dart';
import '../app_exception.dart';
import '../models/post.dart';

import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository postsRepository;

  PostsBloc({required this.postsRepository}) : super(const PostsState()) {
    on<GetAllPosts>(_getAllPosts);
    on<CreatePost>(_createPost);
    on<UpdatePost>(_updatePost);
  }

  void _getAllPosts(event, emit) async {

  }

  void _createPost(event, emit) async {

  }

  void _updatePost(event, emit) async {

  }
}
