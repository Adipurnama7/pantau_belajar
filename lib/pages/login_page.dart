import 'package:flutter/material.dart';
import 'package:pantau_belajar/components/my_button.dart';
import 'package:pantau_belajar/components/my_text_field.dart';
import 'package:pantau_belajar/models/app_user.dart';
import 'package:pantau_belajar/pages/auth_page.dart';
import 'package:pantau_belajar/pages/home_page.dart';
import 'package:pantau_belajar/pages/register_page.dart';
import 'package:pantau_belajar/services/user_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("images/login.png"),
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 10),
              MyTextField(
                textEditingController: emailController,
                hintText: "Email",
                icon: Icon(
                  Icons.email,
                ),
              ),
              MyTextField(
                textEditingController: passwordController,
                hintText: "Password",
                icon: Icon(
                  Icons.lock,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Lupa Password? ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
                child: MyButton(
                  onTap: () {
                    login(context, emailController, passwordController);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  color: Color.fromARGB(255, 57, 42, 171),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: 20),
              MyButton(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "images/google.png",
                      height: 20,
                    ),
                    Text(
                      'Login With Google',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
                color: Color.fromARGB(255, 171, 171, 171),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah memiliki akun? ",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 57, 42, 171),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    if (email.isEmpty) {
      Navigator.pop(context);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Masukkan Email Anda'),
          ),
        );
        return;
      }
    }
    if (password.isEmpty) {
      Navigator.pop(context);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Masukkan Password Anda'),
          ),
        );
      }
      return;
    }
    UserService userService = UserService();

    try {
      Navigator.pop(context);
      AppUser? user = await userService.loginWithEmailPassword(email, password);
      if (user != null && context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AuthPage();
            },
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
      Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login error: $e")),
        );
      }
    }
  }
}
