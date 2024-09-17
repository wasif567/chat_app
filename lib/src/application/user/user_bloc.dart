import 'package:chat/src/application/user/user_event.dart';
import 'package:chat/src/application/user/user_state.dart';
import 'package:chat/src/infrastructure/auth/auth_repo.dart';
import 'package:chat/src/infrastructure/user/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final AuthRepo authRepo;

  UserBloc({required this.userRepository, required this.authRepo}) : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await userRepository.fetchUsers();
        User currentUser = await authRepo.getCurrentUser();
        users.removeWhere((user) => user.email == currentUser.email);
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
