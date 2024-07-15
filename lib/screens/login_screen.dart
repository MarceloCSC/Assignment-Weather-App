import 'package:flutter/material.dart';
import 'package:my_weather_app/constants/images.dart';
import 'package:my_weather_app/models/login_request.dart';
import 'package:my_weather_app/services/login_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Future<void> requestLogin() async {
      final LoginRequest request = LoginRequest(
          username: usernameController.text, password: passwordController.text);

      final isSuccessful = await LoginService.login(request);

      if (isSuccessful && context.mounted) {
        Navigator.pushNamed(context, '/weather');
        return;
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid username or email.'),
        ));
      }
    }

    Future<void> handleLogin() async {
      if (formKey.currentState!.validate()) {
        await requestLogin();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please enter a valid username and password.')),
        );
      }
    }

    String? validateUsername(value) {
      if (value == null || value.isEmpty) {
        return 'This field is required.';
      }
      return null;
    }

    String? validatePassword(value) {
      if (value == null || value.isEmpty) {
        return 'This field is required.';
      } else if (value.length < 7) {
        return 'Your password must be at least 7 characters long.';
      }
      return null;
    }

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 220, maxHeight: 220),
                      child: Image.asset(
                        'assets/images/${Images.banner}',
                        width: screenWidth * 0.4,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: Container(
                      width: screenWidth * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: usernameController,
                        validator: validateUsername,
                        decoration: const InputDecoration(
                            hintText: 'Username',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: Container(
                      width: screenWidth * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          controller: passwordController,
                          validator: validatePassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'Password',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              border: InputBorder.none)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: TextButton(
                        onPressed: () => handleLogin(),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.teal.shade400,
                          fixedSize: Size(screenWidth * 0.8, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Sign In',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white))),
                  ),
                  SizedBox(height: screenHeight * 0.08),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
