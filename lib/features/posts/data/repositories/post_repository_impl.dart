import 'package:dartz/dartz.dart';
import 'package:news_clean_architecture/core/error/exception.dart';
import 'package:news_clean_architecture/core/error/failures.dart';
import 'package:news_clean_architecture/core/network/network_info.dart';
import 'package:news_clean_architecture/features/posts/data/datasources/post_local_data_source.dart';
import 'package:news_clean_architecture/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:news_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:news_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:news_clean_architecture/features/posts/domain/repositories/posts_repository.dart';

typedef Future<Unit> DeleteOrUpdateOrAddPostType();

class PostRepositoryImpl implements PostsRepository{
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;


  PostRepositoryImpl({required this.remoteDataSource, required this.localDataSource,required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts()async {
    if(await networkInfo.isConnected){
      try{
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException{
        return Left(ServerFailure());
      }
    }
    else {
      try{
        final localPosts = await localDataSource.getCachedPost();
        return Right(localPosts);
      }
      on EmptyCacheException{
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post)async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);
    return _getMessage(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id)async {
    return await _getMessage(() => remoteDataSource.deletePost(id));
  }


  @override
  Future<Either<Failure, Unit>> updatePost(Post post)async {
    final PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body);

       return await _getMessage(() => remoteDataSource.updatePost(postModel));
  }


  Future<Either<Failure, Unit>> _getMessage(DeleteOrUpdateOrAddPostType deleteOrUpdateOrAddPost)async{
    if(await networkInfo.isConnected){
      try{
        await deleteOrUpdateOrAddPost();
        return Right(unit);
      } on ServerException{
        return Left(ServerFailure());
      }
    }else {
      return Left(OfflineFailure());
    }

  }
}