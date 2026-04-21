import 'package:flutter/material.dart';

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
            // TODO: Adicionar funcionalidades administrativas aqui
            _buildAdminCard(
              title: 'Gerenciar Usuários',
              iconData: Icons.people,
              onTap: () {
                // TODO: Implementar navegação para gerenciamento de usuários
              },
            ),
            const SizedBox(height: 12),
            _buildAdminCard(
              title: 'Gerenciar Horários',
              iconData: Icons.schedule,
              onTap: () {
                // TODO: Implementar navegação para gerenciamento de horários
              },
            ),
            const SizedBox(height: 12),
            _buildAdminCard(
              title: 'Configurações',
              iconData: Icons.settings,
              onTap: () {
                // TODO: Implementar navegação para configurações
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
