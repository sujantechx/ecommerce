

import 'package:ecommerce/bloc/user/user_event.dart';
import 'package:ecommerce/bloc/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/remote/repository/user_repo.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitialState()) {

    on<RegisterUserEvent>((event, emit) async{
      emit(UserLoadingState());
      try {
        dynamic res = await userRepository.registerUser(
          email: event.email,
          name: event.name,
          mobNo: event.mobNo,
          pass: event.pass,
        );
        if(res["status"]){
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });
    // In your UserBloc class

    on<LoginUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        dynamic login = await userRepository.loginUser(email: event.email, pass: event.pass);

        if (login["status"] == true) { // Also, be explicit with '== true' for clarity
          emit(UserSuccessState());
        } else { // <-- CORRECTED LINE
          emit(UserFailureState(errorMsg: login["message"] ?? "Invalid credentials"));
        }
      } catch(e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });
  }
}