import 'package:flutter/material.dart';
import 'package:horario_corte_luz/presentation/page/home_page.dart';
import 'package:horario_corte_luz/presentation/page/login_page.dart';
import 'package:horario_corte_luz/presentation/widget/input_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String userName = "";
  String email = "";
  String password = "";

  Future<void> _registerDataClient() async {
    print(
        "IsValid: password${!password.isEmpty}, userName${!userName.isEmpty}, email${!email.isEmpty} ${!userName.isEmpty && !password.isEmpty && !email.isEmpty}");
    await Future.delayed(const Duration(seconds: 2));
    return;
    if (userName == "admin" && password == "admin") {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      print("Usuario o contraseña incorrecta");
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
                  child: const Text(
                    'Registrar',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ))
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ]),
      )),
    );
  }
}
