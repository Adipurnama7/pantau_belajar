import 'package:flutter/material.dart';
import 'package:pantau_belajar/components/my_button.dart';
import 'package:pantau_belajar/components/my_text_field.dart';
<<<<<<< HEAD
import 'package:pantau_belajar/pages/lupa_password_page.dart';
import 'package:pantau_belajar/pages/register_page.dart';
=======
import 'package:pantau_belajar/pages/home_page.dart';
>>>>>>> fe00cd5a926867499e655ab143a885d34ed35ee4

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("images/login.jpg"),
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LupaPasswordPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Lupa Password? ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 57, 42, 171), // Warna teks
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
              },
              child: MyButton(
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Belum memiliki akun? ",
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
    );
  }
}
