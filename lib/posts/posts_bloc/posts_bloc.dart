import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../app_exception.dart';
import '../models/post.dart';
import '../service/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository postsRepository;

  PostsBloc({required this.postsRepository}) : super(const PostsState()) {
    on<GetAllPosts>(_onGetAllPosts);
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
  }

  void _onGetAllPosts(GetAllPosts event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.fetchingPosts));

    try {
      await Future.delayed(const Duration(seconds: 1));
      final posts = await postsRepository.getAllPosts();

      emit(state.copyWith(
        status: PostsStatus.fetchedPosts,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostsStatus.errorFetchingPosts,
        exception: AppException.from(error),
      ));
    }
  }

  void _onCreatePost(CreatePost event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.creatingPosts));

    try {
      await Future.delayed(const Duration(seconds: 1));

      // Vérifier si le titre ou la description est vide
      if (event.postToAdd.title.isEmpty || event.postToAdd.description.isEmpty) {
        emit(state.copyWith(
          status: PostsStatus.errorCreatingPost,
          exception: EmptyPostException(),
        ));
        return;
      }

      final newPost = await postsRepository.createPost(event.postToAdd);

      // Mettre à jour la liste des posts
      final updatedPosts = [...state.posts, newPost];

      emit(state.copyWith(
        posts: updatedPosts,
        status: PostsStatus.createdPost,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostsStatus.errorCreatingPost,
        exception: AppException.from(error),
      ));
    }
  }

  void _onUpdatePost(UpdatePost event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.updatingPost));

    try {
      await Future.delayed(const Duration(seconds: 1));

      // Vérifier si le titre ou la description est vide
      if (event.newPost.title.isEmpty || event.newPost.description.isEmpty) {
        emit(state.copyWith(
          status: PostsStatus.errorUpdatingPost,
          exception: EmptyPostException(),
        ));
        return;
      }

      final updatedPost = await postsRepository.updatePost(event.newPost);

      // Mettre à jour la liste des posts
      final updatedPosts = state.posts.map((post) =>
      post.id == updatedPost.id ? updatedPost : post
      ).toList();

      emit(state.copyWith(
        posts: updatedPosts,
        status: PostsStatus.updatedPost,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostsStatus.errorUpdatingPost,
        exception: AppException.from(error),
      ));
    }
  }
}