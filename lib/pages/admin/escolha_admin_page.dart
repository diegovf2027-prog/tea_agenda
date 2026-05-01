import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_agenda/pages/login_page.dart';
import 'package:tea_agenda/pages/admin/admin.dart';
import 'package:tea_agenda/pages/student_selection.dart';

class AdminEscolha extends StatefulWidget {
  const AdminEscolha({super.key});

  @override
  State<AdminEscolha> createState() => _AdminEscolhaPageState();
}

class _AdminEscolhaPageState extends State<AdminEscolha> {

  // Função para deslogar
  Future<void> _deslogar() async {
    final supabase = Supabase.instance.client;

    await supabase.auth.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _buildAdminCard(
              title: 'Painel Administrativo',
              iconData: Icons.admin_panel_settings,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminPage()
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            _buildAdminCard(
              title: 'Registros',
              iconData: Icons.view_agenda,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentSelection()
                  ),
                );
              },
            ),
            ElevatedButton.icon(
              onPressed: _deslogar,
              icon: const Icon(Icons.logout),
              label: const Text('Sair do Sistema'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[50], // Um tom leve de vermelho
                foregroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminCard({
    required String title,
    required IconData iconData,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(iconData),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}