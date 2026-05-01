import 'package:flutter/material.dart';
import 'package:tea_agenda/pages/admin/escolas/gerenciar_escolas_page.dart';
import 'package:tea_agenda/pages/admin/turmas/gerenciar_turmas_page.dart';
import 'package:tea_agenda/pages/admin/usuarios/gerenciar_usuarios_page.dart';
import 'package:tea_agenda/pages/admin/alunos/gerenciar_alunos_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Administração'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Painel Administrativo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildAdminCard(
              title: 'Gerenciar Escolas',
              iconData: Icons.school,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GerenciarEscolasPage()
                    ),
                );
              },
            ),
            const SizedBox(height: 24),
            // TODO: Adicionar funcionalidades administrativas aqui
            _buildAdminCard(
              title: 'Gerenciar Turmas',
              iconData: Icons.people,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GerenciarTurmasPage()
                    ),
                );
              },
            ),
            const SizedBox(height: 24),
            // TODO: Adicionar funcionalidades administrativas aqui
            _buildAdminCard(
              title: 'Gerenciar Alunos',
              iconData: Icons.people,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GerenciarAlunosPage()
                    ),
                );
              },
            ),
            const SizedBox(height: 24),
            // TODO: Adicionar funcionalidades administrativas aqui
            _buildAdminCard(
              title: 'Gerenciar Usuários',
              iconData: Icons.people,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GerenciarUsuariosPage()
                    ),
                );
              },
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
