import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import 'package:meta/meta.dart';

import '../models/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
