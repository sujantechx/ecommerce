abstract class UserEvent {}

class RegisterUserEvent extends UserEvent {
  String name, email, mobNo, pass;

  RegisterUserEvent({
    required this.name,
    required this.email,
    required this.mobNo,
    required this.pass,
  });
}

class LoginUserEvent extends UserEvent {
  String email, pass;
  LoginUserEvent({required this.email, required this.pass});
}