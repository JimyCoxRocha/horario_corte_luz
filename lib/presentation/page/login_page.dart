import 'dart:math';

import 'package:flutter/material.dart';
import 'package:horario_corte_luz/architecture/dtos/ErrorResponse.dart';
import 'package:horario_corte_luz/domain/repository/UserPreferenceRepository.dart';
import 'package:horario_corte_luz/domain/usecase/AuthUseCase.dart';
import 'package:horario_corte_luz/presentation/page/home_page.dart';
import 'package:horario_corte_luz/presentation/page/register_page.dart';
import 'package:horario_corte_luz/presentation/widget/input_form.dart';
import 'package:horario_corte_luz/presentation/widget/toast_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  bool _isLoadingData = false;
  final AuthUseCase authUseCase = AuthUseCase();

  Future<void> _verifyDataClient() async {
    print("${email} ${password}");

    //await Future.delayed(const Duration(seconds: 2));
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        setState(() {
          _isLoadingData = true;
        });
        final response =
            await authUseCase.login(email: email, password: password);

        // Implementamos loading
        setState(() {
          _isLoadingData = false;
        });
        if (response) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      } on ErrorResponse catch (data) {
        ToastWidget(context).toast(message: data.message);
      }
      setState(() {
        _isLoadingData = false;
      });
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
                maxLength: 60,
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
                    child: _isLoadingData
                        ? Container(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 20, right: 20),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            'Ingresar',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ))
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ]),
        )));
  }
}
