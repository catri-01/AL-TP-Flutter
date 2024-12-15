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
    emit(state.copyWith(status: PostsStatus.fetchingPosts));

    try {
      final postsStream = postsRepository.getAllPosts();
      await emit.forEach(postsStream, onData: (posts) {
        return state.copyWith(status: PostsStatus.fetchedPosts, posts: posts);
      });
    } catch (error) {
      emit(state.copyWith(status: PostsStatus.errorFetchingPosts));
    }
  }

  void _createPost(event, emit) async {
    emit(state.copyWith(status: PostsStatus.creatingPosts));

    try {
      await postsRepository.createPost(event.post);
      emit(state.copyWith(status: PostsStatus.createdPost));
    } catch (error) {
      emit(state.copyWith(status: PostsStatus.errorCreatingPost));
    }
  }

  void _updatePost(event, emit) async {
    emit(state.copyWith(status: PostsStatus.updatingPost));

    try {
      await postsRepository.updatePost(event.post);
      emit(state.copyWith(status: PostsStatus.updatedPost));
    } catch (error) {
      emit(state.copyWith(status: PostsStatus.errorUpdatingPost));
    }
  }
}
