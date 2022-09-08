import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:news_clean_architecture/core/error/failures.dart';
import 'package:news_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:news_clean_architecture/features/posts/domain/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPosts getAllPostsUsecase;

  PostsBloc({required this.getAllPostsUsecase}) : super(PostsInitial()){
    on<PostsEvent>((event, emit)async {
      if(event is GetAllPostsEvent || event is RefreshPostsEvent){
        emit(GetAllPostsLoadingState());
        final posts = await getAllPostsUsecase();
        emit(_successOrErrorState(posts));
      }
    });
  }

}

PostsState _successOrErrorState (Either<Failure, List<Post>>operation){
  return operation.fold(
          (failure) {
            print(failure.toString());
            return GetAllPostsErrorState(message: "error");
          } ,
          (posts) => GetAllPostsSuccessfullyState(posts: posts),);
}

