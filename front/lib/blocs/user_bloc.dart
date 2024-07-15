import 'package:bloc/bloc.dart';
import 'package:food_delivery_app/blocs/user_state.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/repositories/user_repository.dart';
import 'package:food_delivery_app/blocs/user_event.dart';

// abstract class UserEvent extends Equatable {
//   const UserEvent();

//   @override
//   List<Object> get props => [];
// }

// class UserLoggedIn extends UserEvent {
//   final String email;
//   final String password;

//   const UserLoggedIn({
//     required this.email,
//     required this.password,
//   });

//   @override
//   List<Object> get props => [email, password];
// }

// class UserLoggedOut extends UserEvent {}

// class UserRegister extends UserEvent {
//   final String fullname;
//   final String email;
//   final String password;
//   final String confirmPassword;

//   const UserRegister({
//     required this.fullname,
//     required this.email,
//     required this.password,
//     required this.confirmPassword,
//   });

//   @override
//   List<Object> get props => [fullname, email, password, confirmPassword];
// }

// abstract class UserState extends Equatable {
//   const UserState();

//   @override
//   List<Object> get props => [];
// }

// class UserInitial extends UserState {}

// class UserLoading extends UserState {}

// class UserAuthenticated extends UserState {
//   final User user;

//   const UserAuthenticated(this.user);

//   @override
//   List<Object> get props => [user];
// }

// class UserUnauthenticated extends UserState {}

// class UserError extends UserState {
//   final String error;

//   const UserError(this.error);

//   @override
//   List<Object> get props => [error];
// }

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<UserLoggedIn>((event, emit) => _handleAuth(event, emit));
    on<UserLoggedOut>((event, emit) => emit(UserUnauthenticated()));
    on<UserRegister>((event, emit) => _handleAuth(event, emit));
  }

  Future<void> _handleAuth(UserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      User? user;
      if (event is UserLoggedIn) {
        user = await userRepository.loginUser(event.email, event.password);

        print("User from Login ssss Page: $user.fullname");
      } else if (event is UserRegister) {
        user = await userRepository.registerUser(
          event.fullname,
          event.email,
          event.password,
          event.confirmPassword,
        );
      }
      if (user != null) {
        print("user from Iser Bloc: ${user.fullname}");
        emit(UserAuthenticated(user));
      } else {
        // Handle case where user is null (e.g., failed login or registration)
        emit(const UserError("An error occurred during authentication"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onUserRegister(
      UserRegister event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await userRepository.registerUser(
        event.fullname,
        event.email,
        event.password,
        event.confirmPassword,
      );
      print("userrrrrrrr ${user}");
      emit(UserAuthenticated(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onUserLogin(
    UserLoggedIn event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final user = await userRepository.loginUser(
        event.email,
        event.password,
      );
      print("userLoggedIn: ${user}");
      emit(UserAuthenticated(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
