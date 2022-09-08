import 'package:dartz/dartz.dart';
import 'package:news_clean_architecture/core/error/failures.dart';
import 'package:news_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:news_clean_architecture/features/posts/domain/repositories/posts_repository.dart';

class GetAllPosts{
  final PostsRepository repository;

  GetAllPosts({required this.repository});

  Future <Either<Failure, List<Post>>> call()async {
    return await repository.getAllPosts();
  }
}