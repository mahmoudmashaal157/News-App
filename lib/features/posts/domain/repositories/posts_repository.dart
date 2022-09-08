import 'package:dartz/dartz.dart';
import 'package:news_clean_architecture/core/error/failures.dart';
import 'package:news_clean_architecture/features/posts/domain/entities/post.dart';

abstract class PostsRepository{
  Future <Either<Failure, List<Post>>> getAllPosts();
  Future <Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost (Post post);
  Future<Either<Failure, Unit>> addPost (Post post);
}