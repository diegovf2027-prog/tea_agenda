import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_agenda/data/repositories/usuarios_repository.dart';
import 'package:tea_agenda/pages/alterar_senha_page.dart';
import 'package:tea_agenda/pages/admin/escolha_admin_page.dart';
import 'package:tea_agenda/pages/professores/class_selection.dart';

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
  bool _obscurePassword = true;

  Future<void> login() async {
    if (_loading) return;

    setState(() => _loading = true);

    try {
      final supabase = Supabase.instance.client;

      final response = await supabase.auth.signInWithPassword(
        email: emailField.text.trim(),
        password: passwordField.text.trim(),
      );

      if (response.user != null) {
        TextInput.finishAutofillContext(shouldSave: true);

        final perfil = await _usuariosRepo.obterusUarioLogado();

        if (!mounted) return;

        if (perfil != null) {
          final deveTrocarSenha = await _usuariosRepo
              .deveTrocarSenhaNoPrimeiroAcesso();

          if (!mounted) return;

          if (deveTrocarSenha) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AlterarSenhaPage(perfil: perfil),
              ),
            );
            return;
          }

          final String cargo =
              perfil['cargo_nome']?.toString().toUpperCase() ?? '';
          if (cargo == 'ADMINISTRADOR' ||
              cargo == 'DIRETOR' ||
              cargo == 'ORIENTADOR') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminEscolha()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ClassSelection()),
            );
          }
        }
      }
    } on AuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } on PostgrestException catch (e) {
      if (!mounted) return;

      final mensagem = e.code == '42703' || e.code == 'PGRST204'
          ? 'A configuração do primeiro acesso está incompleta no Supabase. '
                'Aplique a migração de troca de senha e tente novamente.'
          : 'Erro ao consultar os dados do usuário no Supabase: ${e.message}';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagem), backgroundColor: Colors.red),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível concluir o login. Tente novamente.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void dispose() {
    emailField.dispose();
    passwordField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Card(
              elevation: 6,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 32,
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    const Icon(Icons.book, size: 60, color: Color(0xFF2196F3)),

                    const SizedBox(height: 16),

                    const Text(
                      'TEAgenda',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Insira suas credenciais para continuar',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),

                    const SizedBox(height: 30),

                    AutofillGroup(
                      child: Column(
                        children: [
                          TextField(
                            controller: emailField,

                            autofillHints: const [
                              AutofillHints.email,
                              AutofillHints.username,
                            ],

                            keyboardType: TextInputType.emailAddress,

                            textInputAction: TextInputAction.next,

                            decoration: InputDecoration(
                              labelText: 'Email',

                              prefixIcon: const Icon(Icons.email_outlined),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          TextField(
                            controller: passwordField,

                            obscureText: _obscurePassword,

                            autofillHints: const [AutofillHints.password],

                            // Mostra "Concluir" no teclado
                            textInputAction: TextInputAction.done,

                            onSubmitted: (_) {
                              login();
                            },

                            decoration: InputDecoration(
                              labelText: 'Senha',

                              prefixIcon: const Icon(Icons.lock_outline),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),

                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    _loading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            height: 50,

                            child: ElevatedButton(
                              onPressed: login,

                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1565C0),

                                elevation: 3,

                                shadowColor: Colors.black26,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),

                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Icon(
                                    Icons.login,
                                    size: 20,
                                    color: Colors.white,
                                  ),

                                  SizedBox(width: 8),

                                  Text(
                                    'Entrar',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
