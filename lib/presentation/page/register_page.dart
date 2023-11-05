import 'package:flutter/material.dart';
import 'package:horario_corte_luz/architecture/dtos/ErrorResponse.dart';
import 'package:horario_corte_luz/domain/usecase/AuthUseCase.dart';
import 'package:horario_corte_luz/presentation/page/home_page.dart';
import 'package:horario_corte_luz/presentation/page/login_page.dart';
import 'package:horario_corte_luz/presentation/widget/input_form.dart';
import 'package:horario_corte_luz/presentation/widget/toast_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String userName = "";
  String email = "";
  String password = "";
  bool _isLoadingData = false;
  final AuthUseCase authUseCase = AuthUseCase();

  Future<void> _registerDataClient() async {
    print(
        "IsValid: password${!password.isEmpty}, userName${!userName.isEmpty}, email${!email.isEmpty} ${!userName.isEmpty && !password.isEmpty && !email.isEmpty}");

    if (email.isNotEmpty && password.isNotEmpty && userName.isNotEmpty) {
      try {
        setState(() {
          _isLoadingData = true;
        });
        final response = await authUseCase.registerUser(
            email: email, password: password, userName: userName);

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
    }
  }

  void _goToLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
            child: Image.asset('assets/register/register.png',
                width: MediaQuery.of(context).size.width * 0.5),
          ),
          const SizedBox(height: 20),
          InputForm(
              text: 'Usuario',
              inputType: InputType.onlyTextWithoutSpace,
              prefixIcon: const Icon(Icons.person),
              onValueChanged: (value) {
                setState(() {
                  if (!value.isValidData) {
                    userName = "";
                    return;
                  }
                  userName = value.text;
                });
              },
              maxLength: 15),
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    _goToLogin();
                  },
                  child: const Text("¿Ya tienes cuenta?",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ))),
              const Spacer(),
              FilledButton(
                  onPressed: () {
                    _registerDataClient();
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
                          'Registrar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ))
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ]),
      )),
    );
  }
}
