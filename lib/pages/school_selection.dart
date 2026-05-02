import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_agenda/pages/class_selection.dart';
import 'package:tea_agenda/pages/login_page.dart';

class SchoolSelection extends StatefulWidget {
  const SchoolSelection({super.key});

  @override
  State<SchoolSelection> createState() => _SchoolSelectionState();
}

class _SchoolSelectionState extends State<SchoolSelection> {
  final supabase = Supabase.instance.client;

  Map<String, dynamic>? escola;
  bool isLoading = true;
  String? erro;

  @override
  void initState() {
    super.initState();
    carregarEscolaUsuario();
  }

  Future<void> carregarEscolaUsuario() async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        throw Exception('Usuário não está logado');
      }

      final usuario = await supabase
          .from('usuarios')
          .select('usu_escola')
          .eq('usu_id', user.id)
          .single();

      final escId = usuario['usu_escola'];

      if (escId == null) {
        throw Exception('Usuário não possui escola vinculada');
      }

      final escolaData = await supabase
          .from('escolas')
          .select()
          .eq('esc_id', escId)
          .single();

      setState(() {
        escola = escolaData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        erro = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> logout() async {
    await supabase.auth.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione a Escola'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: logout,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : erro != null
            ? Center(
                child: Text(
                  'Erro: $erro',
                  style: const TextStyle(color: Colors.red),
                ),
              )
            : escola == null
            ? const Center(child: Text('Nenhuma escola encontrada'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sua escola:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(
                          0xFF2196F3,
                        ).withValues(alpha: 0.1),
                        child: const Icon(
                          Icons.school,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                      title: Text(
                        escola!['esc_nome'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(escola!['esc_cidade'] ?? ''),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ClassSelection(
                              schoolId: escola!['esc_id'],
                              esc_id: null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
