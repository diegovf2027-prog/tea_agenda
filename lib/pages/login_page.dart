import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_agenda/data/repositories/usuarios_repository.dart';
import 'package:tea_agenda/pages/admin/escolha_admin_page.dart';
import 'package:tea_agenda/pages/student_selection.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();
  final _usuariosRepo = UsuariosRepository();
  bool _loading = false;

  Future<void> login() async {
    setState(() => _loading = true);

    try {
      final supabase = Supabase.instance.client;

      final response = await supabase.auth.signInWithPassword(
        email: emailField.text.trim(),
        password: passwordField.text.trim(),
      );

      if (response.user != null) {
        final perfil = await _usuariosRepo.obterusUarioLogado();

        if (!mounted) return;

        if (perfil != null) {
          String cargo = perfil['cargo_nome']?.toString().toUpperCase() ?? '';

          if (cargo == 'ADMINISTRADOR' || cargo == 'DIRETOR' || cargo == 'ORIENTADOR') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminEscolha()
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const StudentSelection()
              ),
            );
          }
        }
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:  Text(e.message), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:  Text('Erro ao conectar ao servidor.'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /*
  void login() {
    String email = emailField.text;
    String senha = passwordField.text;

    if (email == 'admin' && senha == 'admin') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminEscolha()),
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
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
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
                    keyboardType: TextInputType.emailAddress,
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
                _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                    onPressed: login,
                    child: const Text('Entrar'),
                  ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
