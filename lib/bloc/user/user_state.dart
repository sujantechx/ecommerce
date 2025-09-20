import '../../model/user_model.dart';

abstract class UserState{}

class UserInitialState extends UserState{}
class UserLoadingState extends UserState{}
class UserSuccessState extends UserState{}
class UserFailureState extends UserState{
  String errorMsg;
  UserFailureState({required this.errorMsg});
}
class UserProfileLoadedState extends UserState {
  final UserModel user;
  UserProfileLoadedState({required this.user});
}

