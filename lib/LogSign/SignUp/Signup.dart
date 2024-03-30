import 'package:flutter/material.dart';
import 'package:police_app/LogSign/SignUp/Footer.dart';
import 'package:police_app/LogSign/SignUp/Form.dart';
import 'package:police_app/LogSign/SignUp/Header.dart';
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFD9C19D),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: const Column(
              children: [
                FormHeaderWidget(
                  image: 'assets/images/SP.png',
                  title: "Get On Board!",
                  subTitle: "",
                  imageHeight: 0.15,
                ),
                SignUpFormWidget(),
                SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}