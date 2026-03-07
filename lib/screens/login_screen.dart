import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/branded_button.dart';
// Login UI implemented

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool isValid = false;

  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  @override
  void initState() {
    super.initState();
    // Added animations and UI polish

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(animationController);

    animationController.forward();
  }

  void validateForm() {
    final email = emailController.text;
    final password = passwordController.text;

    setState(() {
      isValid = emailRegex.hasMatch(email) && password.length >= 6;
    });

    formKey.currentState?.validate();
  }

  Future<void> login() async {

    if (!formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    debugPrint("Login successful for ${emailController.text}!");

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Login Successful"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [secondaryGreen, neutralWhite],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: FadeTransition(
          opacity: fadeAnimation,

          child: Padding(
            padding: const EdgeInsets.all(24),
            // Added form validation

            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,

              child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
             children: [

                  const SizedBox(height: 60),

                  const Center(
                    child: Text(
                      "Healthetic Lifestyle",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Center(
                    child: Text(
                      "Welcome back!",
                      style: TextStyle(
                        fontSize: 16,
                        color: neutralGrey,
                      ),
                    ),
                  ),
                   

                  const SizedBox(height: 120),

                  CustomTextField(
                    label: "Email",
                    placeholder: "Enter your email",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => validateForm(),
                    validator: (value) {

                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }

                      if (!emailRegex.hasMatch(value)) {
                        return "Enter a valid email";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  CustomTextField(
                    label: "Password",
                    placeholder: "Enter your password",
                    controller: passwordController,
                    isPassword: true,
                    onChanged: (_) => validateForm(),
                    validator: (value) {

                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }

                      if (value.length < 6) {
                        return "Minimum 6 characters";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        debugPrint("Forgot Password tapped");
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: neutralGrey,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                 BrandedButton(
                  label: "Login",
                  onPressed: login,
                  isLoading: isLoading,
                  enabled: isValid,
),

                 const SizedBox(height: 30),

                   Center(
                    child: GestureDetector(
                      onTap: () {
                        debugPrint("Navigating to Sign Up...");
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: neutralGrey),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: primaryGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}