

import 'package:ecommerce/bloc/user/user_event.dart';
import 'package:ecommerce/bloc/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    on<LoginUserEvent>((event, emit) async{
      emit(UserLoadingState());

      try{

        dynamic res = await userRepository.loginUser(email: event.email, pass: event.pass);
        if(res["status"]){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", res["tokan"]);

          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMsg: res["message"]));
        }


      } catch(e){
        emit(UserFailureState(errorMsg: e.toString()));
      }

    });

    // Add this new event handler for fetching the profile
    on<FetchUserProfileEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');

        if (token != null) {
          final user = await userRepository.fetchUserProfile(token);
          if (user != null) {
            emit(UserProfileLoadedState(user: user));
          } else {
            emit(UserFailureState(errorMsg: 'Failed to load profile data.'));
          }
        } else {
          emit(UserFailureState(errorMsg: 'Authentication token not found.'));
        }
      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });


  }
}