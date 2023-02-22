import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kanban_board/data/datasources/auth_service.dart';
import 'package:kanban_board/injector.dart';
import 'package:kanban_board/utils/app_colors.dart';
import 'package:kanban_board/utils/app_illustration.dart';
import 'package:kanban_board/utils/app_styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 24,
              ),
              child: Image(
                height: 250,
                image: AppIllustrations.kanbanIllustration,
              ),
            ),
            const Text(
              "Register",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
              ),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.at,
                    size: 16,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                      ),
                      child: TextField(
                        controller: email,
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.lock,
                    size: 16,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                      ),
                      child: TextField(
                        controller: password,
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),
                        obscureText: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: ElevatedButton(
                onPressed: () => getIt<AuthService>().register(
                  context,
                  email: email.text,
                  password: password.text,
                ),
                style: AppStyles.primaryButton,
                child: const Text(
                  "Register",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
              ),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Already have account ? ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
