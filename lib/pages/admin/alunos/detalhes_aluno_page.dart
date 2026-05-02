import 'package:flutter/material.dart';

class DetalhesAlunoPage extends StatelessWidget {
  final Map<String, dynamic> aluno;

  const DetalhesAlunoPage({super.key, required this.aluno});

  @override
  Widget build(BuildContext context) {

    String dataFormatada = 'Não informada';
    if (aluno['alu_dt_nascimento'] != null) {
      DateTime dt = DateTime.parse(aluno['alu_dt_nascimento']);
      dataFormatada = "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}";
    }

    // Formatação de CPF
    String formatarCPF(String cpf) {
      String numeros = cpf.replaceAll(RegExp(r'[^0-9]'), '');
      if (numeros.length != 11) return numeros;
      return "${numeros.substring(0, 3)}.${numeros.substring(3, 6)}.${numeros.substring(6, 9)}-${numeros.substring(9)}";
    }

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
              aluno['alu_nome'] ?? 'Sem nome',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 32),
            _buildDetailItem(Icons.badge, "CPF", formatarCPF(aluno['alu_cpf'] ?? 'Não informado')),
            _buildDetailItem(
              Icons.cake, 
              "Data de Nascimento", 
              dataFormatada
            ),
            _buildDetailItem(
              Icons.school, 
              "Escola", 
              aluno['escola_nome'] ?? 'Não vinculada'
            ),
            _buildDetailItem(
              Icons.groups_3, 
              "Turma", 
              aluno['turma_numero'] != null 
                  ? "Turma ${aluno['turma_numero']}" 
                  : 'Sem turma'
            ),
            _buildDetailItem(
              Icons.person, 
              "Responsável (Cuidador)", 
              aluno['cuidador_nome'] ?? 'Não atribuído'
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
      subtitle: Text(
        value, 
        style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500)
      ),
    );
  }
}