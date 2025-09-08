import 'package:ecommerce/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../bloc/user/user_state.dart';
import '../../widgets/custume_login_buttons.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;


  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 100,
            right: 100,
            top: 40,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: const DecorationImage(
                  image: AssetImage("assets/logo/bglog.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Create Account",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: fullNameController,
                        decoration: const InputDecoration(labelText: "Full Name"),
                        validator: (v) => v!.isEmpty ? "Please enter your full name" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: "Email Address"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => !v!.contains("@") ? "Invalid email" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(labelText: "Phone Number"),
                        keyboardType: TextInputType.phone,
                        validator: (v) => v!.length < 10 ? "Enter valid phone number" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(labelText: "Password"),
                        obscureText: true,
                        validator: (v) => v!.length < 6 ? "Password must be 6+ characters" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: const InputDecoration(labelText: "Confirm Password"),
                        obscureText: true,
                        validator: (v) => v != passwordController.text ? "Passwords do not match" : null,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: BlocConsumer<UserBloc, UserState>(
                          listener: (_, state) {
                            if (state is UserLoadingState) {
                              isLoading = true;
                            }

                            if (state is UserFailureState) {
                              isLoading = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errorMsg), backgroundColor: Colors.red,),
                              );
                            }

                            if (state is UserSuccessState) {
                              isLoading = false;
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("User Registered successfully!!"), backgroundColor: Colors.green,),
                              );
                              Navigator.pushReplacementNamed(context, AppRoutes.login);

                            }
                          },
                          builder: (_, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                if(_formKey.currentState!.validate()){
                                  String name = fullNameController.text;
                                  String email = emailController.text;
                                  String mobNo = phoneController.text;
                                  String pass = passwordController.text;

                                  context.read<UserBloc>().add(
                                    RegisterUserEvent(
                                      name: name,
                                      email: email,
                                      mobNo: mobNo,
                                      pass: pass,
                                    ),
                                  );
                                }
                              },
                              child: isLoading ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: CircularProgressIndicator( color: Colors.white,),
                                  ),
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Text("Registering..")
                                ],
                              ) : Text('Register'),
                            );
                          },
                        ),
                      ),
                      const SocialLoginButtons()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}