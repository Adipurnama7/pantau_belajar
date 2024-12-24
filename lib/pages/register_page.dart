import 'package:flutter/material.dart';
import 'package:pantau_belajar/components/my_button.dart';
import 'package:pantau_belajar/components/my_text_field.dart';
import 'package:pantau_belajar/pages/login_page.dart';

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
              Image.asset("images/register.jpg"),
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
}
