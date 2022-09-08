import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:news_clean_architecture/core/error/failures.dart';
import 'package:news_clean_architecture/core/strings/messages.dart';
import 'package:news_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:news_clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:news_clean_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:news_clean_architecture/features/posts/domain/usecases/update_post.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final AddPost addPostUseCase;
  final DeletePost deletePostUseCase;
  final UpdatePost updatePostUseCase;

  AddDeleteUpdateBloc({required this.addPostUseCase,required this.deletePostUseCase,required this.updatePostUseCase}) : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit)async {
      if(event is AddPostEvent){
        emit(AddDeleteUpdatePostLoadingState());
        final failureOrDoneMessage = await addPostUseCase(event.post);
        emit(_successOrFailure(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));

      }else if(event is UpdatePostEvent){
        emit(AddDeleteUpdatePostLoadingState());

        final failureOrDoneMessage = await updatePostUseCase(event.post);
        emit(_successOrFailure(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));

      }else if(event is DeletePostEvent){
        emit(AddDeleteUpdatePostLoadingState());
        final failureOrDoneMessage = await deletePostUseCase(event.postId);
        emit(_successOrFailure(failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }
}

AddDeleteUpdateState _successOrFailure(Either<Failure,Unit>operation, String message){
  return operation.fold(
          (failure) => AddDeleteUpdatePostErrorState(message: failure.toString()),
          (unit) => AddDeleteUpdatePostSuccessfullyState(message: message)
  );
  
}

