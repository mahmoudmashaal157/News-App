part of 'add_delete_update_bloc.dart';

@immutable
abstract class AddDeleteUpdateState {}

class AddDeleteUpdateInitial extends AddDeleteUpdateState {}

class AddDeleteUpdatePostLoadingState extends AddDeleteUpdateState {}

class AddDeleteUpdatePostSuccessfullyState extends AddDeleteUpdateState {
  final String message;

  AddDeleteUpdatePostSuccessfullyState({required this.message});

}

class AddDeleteUpdatePostErrorState extends AddDeleteUpdateState {
  final String message;

  AddDeleteUpdatePostErrorState({required this.message});
}

