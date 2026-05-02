import 'package:flutter/material.dart';

class DetalhesTurmaPage extends StatelessWidget {
  final Map<String, dynamic> turma;

  const DetalhesTurmaPage({super.key, required this.turma});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Turma'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Icon(Icons.door_front_door, size: 40, color: Colors.white),
            ),

            const SizedBox(height: 16),
            Text(
              "Turma: ${turma['tur_numero']}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const Divider(height: 32),
            _buildDetailItem(Icons.schedule, "Turno", turma['turno_nome'] ?? 'Não informado'),
            _buildDetailItem(Icons.event, "Ano", "${turma['ano_descricao']}º Ano"),
            _buildDetailItem(Icons.school, "Escola", turma['escola_nome'] ?? 'Não informada'),
            _buildDetailItem(Icons.person, "Professor Responsável", turma['professor_nome'] ?? 'Não atribuído'),
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