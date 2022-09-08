import 'package:dartz/dartz.dart';
import 'package:news_clean_architecture/core/error/failures.dart';
import 'package:news_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:news_clean_architecture/features/posts/domain/repositories/posts_repository.dart';

class UpdatePost {
  final PostsRepository postsRepository;
  UpdatePost({required this.postsRepository});

  Future <Either<Failure, Unit>> call (Post post)async{
    return await postsRepository.updatePost(post);
  }
}