import 'package:challenge_master/src/components/build_button.dart';
import 'package:challenge_master/src/components/build_text_field.dart';
import 'package:challenge_master/src/core/common_widgets/common_title.dart';
import 'package:challenge_master/src/core/constants/app_color.dart';
import 'package:challenge_master/src/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                Image.asset(
                  'assets/images/logo.png',
                  width: 180,
                  height: 180,
                ),
                const CommonTitle(
                  title: 'Welcome user !',
                  size: 35,
                ),
                const SizedBox(height: 40),
                BuildTextField(
                  controller: emailController,
                  hintText: 'Your email',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                BuildTextField(
                  controller: passwordController,
                  hintText: 'Your password',
                  obscureText: false,
                ),
                const SizedBox(height: 40),
                BuildButton(onTap: signIn, text: 'SIGN IN'),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Not a member? '),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.secondMainColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
