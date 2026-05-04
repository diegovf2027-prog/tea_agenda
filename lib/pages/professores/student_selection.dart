import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_agenda/pages/professores/student_page.dart';

class StudentSelection extends StatelessWidget {
  final int? turmaId;
  final String? turmaNome;
  const StudentSelection({super.key, this.turmaId, this.turmaNome});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return Scaffold(
      appBar: AppBar(title: const Text('Selecione o Aluno'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: supabase.from('alunos').stream(primaryKey: ['alu_id']).eq('alu_turma', turmaId ?? 0).order('alu_nome'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Erro ao carregar alunos: ${snapshot.error}"));
                  }

                  final alunos = snapshot.data ?? [];

                  if (alunos.isEmpty) {
                    return const Center(
                      child: Text("Nenhum aluno encontrado nesta turma."),
                    );
                  }
                  
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: alunos.length,
                    itemBuilder: (context, index) {
                      final aluno = alunos[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
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
                              Icons.person,
                              color: Color(0xFF2196F3),
                            ),
                          ),
                          title: Text(
                            aluno['alu_nome'] ?? 'Sem nome',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentPage(
                                  name: aluno['alu_nome'],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
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