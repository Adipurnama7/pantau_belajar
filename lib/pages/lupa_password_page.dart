import 'package:flutter/material.dart';
import 'package:pantau_belajar/components/my_button.dart';
import 'package:pantau_belajar/components/my_text_field.dart';
import 'package:pantau_belajar/pages/login_page.dart';

class LupaPasswordPage extends StatefulWidget {
  const LupaPasswordPage({super.key});

  @override
  State<LupaPasswordPage> createState() => _LupaPasswordPageState();
}

class _LupaPasswordPageState extends State<LupaPasswordPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

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
                "Lupa Password",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 10),
              MyTextField(
                textEditingController: emailController,
                hintText: "Masukkan Email Anda",
                icon: Icon(Icons.email),
              ),
              SizedBox(height: 30),
              MyButton(
                onTap: () {
                  
                },
                child: Text(
                  'Kirim Permintaan Reset',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                color: Color.fromARGB(255, 57, 42, 171),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Kembali ke login ",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>LoginPage(),
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
