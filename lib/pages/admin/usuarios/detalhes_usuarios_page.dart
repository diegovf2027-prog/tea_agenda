import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_agenda/data/local/database.dart';

class DetalhesUsuarioPage extends StatelessWidget {
  final Usuario usuario;

  const DetalhesUsuarioPage({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {

    final database = Provider.of<AppDatabase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Usuário'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              usuario.usuNome,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 32),
            _buildDetailItem(Icons.badge, "CPF", usuario.usuCPF),
            _buildDetailItem(Icons.cake, "Data de Nascimento", "${usuario.usuDtNascimento.day}/${usuario.usuDtNascimento.month}/${usuario.usuDtNascimento.year}"),
            _buildDetailItem(Icons.alternate_email, "E-mail", usuario.usuEmail),
            _buildDetailItem(Icons.assignment_ind, "Cargo", usuario.usuCargo.name.toUpperCase()),
            _buildDetailItem(Icons.lock_outline, "Senha", usuario.usuSenha),
            FutureBuilder<Escola> (
              future: database.getEscolaById(usuario.usuEscola),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildDetailItem(Icons.school, "Escola", "Carregando...");
                } else if (snapshot.hasError) {
                  return _buildDetailItem(Icons.school, "Escola", "Erro ao buscar escola");
                } else if (snapshot.hasData) {
                  return _buildDetailItem(Icons.school, "Escola", snapshot.data!.escNome);
                } else {
                  return _buildDetailItem(Icons.school, "Escola", "Não encontrada");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, color: Colors.black87)),
    );
  }
}