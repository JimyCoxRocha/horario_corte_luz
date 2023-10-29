import 'dart:math';

import 'package:flutter/material.dart';
import 'package:horario_corte_luz/presentation/page/home_page.dart';
import 'package:horario_corte_luz/presentation/page/register_page.dart';
import 'package:horario_corte_luz/presentation/widget/input_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";

  Future<void> _verifyDataClient() async {
    print("${email} ${password}");
    await Future.delayed(const Duration(seconds: 2));
    if (email == "admin@gmail.com" && password == "admin") {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      print("Usuario o contraseña incorrecta");
    }
  }

  void _goToRegister() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(""),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset('assets/login/login.png'),
            ),
            const SizedBox(height: 40),
            InputForm(
                text: 'Email',
                prefixIcon: const Icon(Icons.email),
                inputType: InputType.email,
                maxLength: 30,
                onValueChanged: (value) {
                  setState(() {
                    if (!value.isValidData) {
                      email = "";
                      return;
                    }
                    email = value.text;
                  });
                }),
            InputForm(
                text: 'Contraseña',
                inputType: InputType.password,
                prefixIcon: const Icon(Icons.credit_card),
                maxLength: 30,
                onValueChanged: (value) {
                  setState(() {
                    if (!value.isValidData) {
                      password = "";
                      return;
                    }
                    password = value.text;
                  });
                }),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      _goToRegister();
                    },
                    child: const Text("¿No tienes cuenta?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ))),
                const Spacer(),
                FilledButton(
                    onPressed: () {
                      _verifyDataClient();
                    },
                    child: const Text(
                      'Ingresar',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ))
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ]),
        )));
  }
}
