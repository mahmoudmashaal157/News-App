part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class GetAllPostsLoadingState extends PostsState{}

class GetAllPostsSuccessfullyState extends PostsState{
  final List<Post>posts;

  GetAllPostsSuccessfullyState({required this.posts});
}

class GetAllPostsErrorState extends PostsState{
  final String message;
  GetAllPostsErrorState({required this.message});
}