import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_agenda/data/local/database.dart';

class DetalhesTurmaPage extends StatelessWidget {
  final Turma turma;

  const DetalhesTurmaPage({super.key, required this.turma});

  @override
  Widget build(BuildContext context) {
    
    final database = Provider.of<AppDatabase>(context, listen: false);

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
              turma.turNumero.toString(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 32),
            _buildDetailItem(Icons.schedule, "Turno", turma.turTurno.name.toUpperCase()),
            _buildDetailItem(Icons.event, "Ano", turma.turAno.name.toUpperCase()),
            FutureBuilder<Escola>(
              future: database.getEscolaById(turma.turEscola),
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
            FutureBuilder<Usuario>(
              future: database.getUsuarioById(turma.turProfessorId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildDetailItem(Icons.person, "Professor", "Carregando...");
                } else if (snapshot.hasError) {
                  return _buildDetailItem(Icons.person, "Professor", "Erro ao buscar professor");
                } else if (snapshot.hasData) {
                  return _buildDetailItem(Icons.person, "Professor", snapshot.data!.usuNome);
                } else {
                  return _buildDetailItem(Icons.person, "Professor", "Não encontrado");
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