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
      appBar: AppBar(
        title: const Text("Minhas Turmas"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: supabase.from('turmas_do_professor').stream(primaryKey: ['tur_id']).eq('tur_professor', user!.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar turmas: ${snapshot.error}"));
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
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF2196F3),
                    child: Icon(Icons.groups, color: Colors.white),
                  ),
                  title: Text(
                    "Turma ${turma['tur_numero']}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${turma['ano_numero']}º Ano - ${turma['esc_nome']}"),
                  trailing: const Icon(Icons.arrow_forward_ios),
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