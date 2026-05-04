import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_agenda/pages/professores/student_selection.dart';

class ClassSelection extends StatefulWidget {
  const ClassSelection({super.key});

  @override
  State<ClassSelection> createState() => _ClassSelectionPageState();
}

class _ClassSelectionPageState extends State<ClassSelection> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Minhas Turmas"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: supabase
            .from('turmas_do_professor')
            .stream(primaryKey: ['tur_id'])
            .eq('tur_professor', user!.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          }

          final turmas = snapshot.data ?? [];

          if (turmas.isEmpty) {
            return const Center(
              child: Text("Você não possui turmas vinculadas."),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: turmas.length,
            itemBuilder: (context, index) {
              final turma = turmas[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundColor: const Color(
                      0xFF2196F3,
                    ).withValues(alpha: 0.1),
                    child: const Icon(Icons.groups, color: Color(0xFF2196F3)),
                  ),
                  title: Text(
                    "Turma ${turma['tur_numero']}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      "${turma['ano_numero']}º Ano • ${turma['esc_nome']}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentSelection(
                          turmaId: turma['tur_id'],
                          turmaNome: turma['tur_numero'].toString(),
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
    );
  }
}
