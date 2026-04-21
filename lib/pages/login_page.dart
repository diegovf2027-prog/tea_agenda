import 'package:flutter/material.dart';
import 'package:tea_agenda/pages/admin.dart';
import 'package:tea_agenda/pages/student_selection.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();

  void login() {
    String email = emailField.text;
    String senha = passwordField.text;

    if (email == 'admin' && senha == 'admin') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminPage()),
      );
    } else if (email == 'professor' && senha == 'professor') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const StudentSelection()),
      );
    } else if (email == '1' && senha == '1') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const StudentSelection()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou senha incorretos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: 350,
                child: TextField(
                  controller: emailField,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 350,
                child: TextField(
                  controller: passwordField,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(onPressed: login, child: const Text('Entrar')),
            ],
          ),
        ),
      ),
    );
  }
}
