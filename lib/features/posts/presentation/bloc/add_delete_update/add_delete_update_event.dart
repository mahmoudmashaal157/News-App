part of 'add_delete_update_bloc.dart';

@immutable
abstract class AddDeleteUpdateEvent {}

class AddPostEvent extends AddDeleteUpdateEvent{
  final Post post;

  AddPostEvent({required this.post});
}

class UpdatePostEvent extends AddDeleteUpdateEvent{
  final Post post;

  UpdatePostEvent({required this.post});
}

class DeletePostEvent extends AddDeleteUpdateEvent{
  final int postId;

  DeletePostEvent({required this.postId});
}