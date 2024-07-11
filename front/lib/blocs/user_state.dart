import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserAuthenticated extends UserState {
  final User user;

  const UserAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class UserUnauthenticated extends UserState {}

class UserError extends UserState {
  final String error;

  const UserError(this.error);

  @override
  List<Object> get props => [error];
}
