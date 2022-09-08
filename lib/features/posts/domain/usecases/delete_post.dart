import 'package:dartz/dartz.dart';
import 'package:news_clean_architecture/core/error/failures.dart';
import 'package:news_clean_architecture/features/posts/domain/repositories/posts_repository.dart';

class DeletePost{
  final PostsRepository postsRepository;

  DeletePost({required this.postsRepository});

  Future <Either<Failure, Unit>> call (int id)async{
    return await postsRepository.deletePost(id);
  }
}