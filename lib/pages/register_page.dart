import 'package:flutter/material.dart';
import 'package:pantau_belajar/components/my_button.dart';
import 'package:pantau_belajar/components/my_text_field.dart';
import 'package:pantau_belajar/models/app_user.dart';
import 'package:pantau_belajar/pages/auth_page.dart';
import 'package:pantau_belajar/pages/login_page.dart';
import 'package:pantau_belajar/services/user_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Image.asset("images/register.png"),
              Text(
                "Register",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 10),
              MyTextField(
                textEditingController: nameController,
                hintText: "Nama Lengkap",
                icon: Icon(Icons.person),
              ),
              MyTextField(
                textEditingController: emailController,
                hintText: "Email",
                icon: Icon(Icons.email),
              ),
              MyTextField(
                textEditingController: passwordController,
                hintText: "Password",
                icon: Icon(Icons.lock),
              ),
              MyTextField(
                textEditingController: confirmPasswordController,
                hintText: "Konfirmasi Password",
                icon: Icon(Icons.lock),
              ),
              SizedBox(height: 30),
              MyButton(
                onTap: () {
                  register(context, nameController, emailController,
                      passwordController, confirmPasswordController);
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                color: Color.fromARGB(255, 57, 42, 171),
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
                onTap: () {
                  
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "images/google.png",
                      height: 20,
                    ),
                    Text(
                      'Register With Google',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
                color: Color.fromARGB(255, 171, 171, 171),
              ),
              SizedBox(height: 20),
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
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Login",
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

  void register(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
  ) async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    if (name.isEmpty) {
      Navigator.pop(context);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Masukkan Nama Anda'),
          ),
        );
        return;
      }
    }
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
    if (confirmPassword.isEmpty) {
      Navigator.pop(context);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ulangi Password Anda'),
          ),
        );
      }
      return;
    }
    UserService userService = UserService();

    try {
      AppUser? user =
          await userService.registerWithEmailPassword(email, password, name);
      if (user != null && context.mounted) {
        Navigator.pop(context);
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
      Navigator.pop(context);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login error: $e")),
        );
      }
    }
  }
}
