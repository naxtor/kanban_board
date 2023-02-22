import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kanban_board/data/datasources/auth_service.dart';
import 'package:kanban_board/injector.dart';
import 'package:kanban_board/utils/app_colors.dart';
import 'package:kanban_board/utils/app_illustration.dart';
import 'package:kanban_board/utils/app_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();

    getIt<AuthService>().listener(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Login",
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
                onPressed: () => getIt<AuthService>().login(
                  context,
                  email: email.text,
                  password: password.text,
                ),
                style: AppStyles.primaryButton,
                child: const Text(
                  "Login",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
              ),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed("/register"),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Don't have an account ? ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "Register",
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
