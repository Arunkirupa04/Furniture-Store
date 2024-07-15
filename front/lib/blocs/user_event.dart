import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLoggedIn extends UserEvent {
  final String email;
  final String password;

  const UserLoggedIn({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class UserLoggedOut extends UserEvent {}

class UserRegister extends UserEvent {
  final String fullname;
  final String email;
  final String password;
  final String confirmPassword;

  const UserRegister({
    required this.fullname,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [fullname, email, password, confirmPassword];
}
