import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_agenda/data/local/database.dart';

class DetalhesAlunoPage extends StatelessWidget {
  final Aluno aluno;

  const DetalhesAlunoPage({super.key, required this.aluno});

  @override
  Widget build(BuildContext context) {

    final database = Provider.of<AppDatabase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Aluno'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Icon(Icons.child_care, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              aluno.aluNome,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 32),
            _buildDetailItem(Icons.badge, "CPF", aluno.aluCFP),
            _buildDetailItem(Icons.cake, "Data de Nascimento", "${aluno.aluDtNascimento.day}/${aluno.aluDtNascimento.month}/${aluno.aluDtNascimento.year}"),
            FutureBuilder<Escola>(
              future: database.getEscolaById(aluno.aluEscolaId),
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
            FutureBuilder<Turma>(
              future: database.getTurmaById(aluno.aluTurmaId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildDetailItem(Icons.groups_3, "Turma", "Carregando...");
                } else if (snapshot.hasError) {
                  return _buildDetailItem(Icons.groups_3, "Turma", "Erro ao buscar escola");
                } else if (snapshot.hasData) {
                  return _buildDetailItem(Icons.groups_3, "Turma", snapshot.data!.turNumero.toString());
                } else {
                  return _buildDetailItem(Icons.groups_3, "Turma", "Não encontrada");
                }
              },
            ),
            FutureBuilder<Usuario>(
              future: database.getUsuarioById(aluno.aluCuidadorId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildDetailItem(Icons.person, "Cuidador", "Carregando...");
                } else if (snapshot.hasError) {
                  return _buildDetailItem(Icons.person, "Cuidador", "Erro ao buscar cuidador");
                } else if (snapshot.hasData) {
                  return _buildDetailItem(Icons.person, "Cuidador", snapshot.data!.usuNome);
                } else {
                  return _buildDetailItem(Icons.person, "Cuidador", "Não encontrado");
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