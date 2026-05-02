import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_agenda/pages/student_selection.dart';

class ClassSelection extends StatefulWidget {
  final int schoolId;
  final Object? esc_id;

  const ClassSelection({super.key, required this.schoolId, this.esc_id});

  @override
  State<ClassSelection> createState() => _ClassSelectionState();
}

class _ClassSelectionState extends State<ClassSelection> {
  final supabase = Supabase.instance.client;

  List turmas = [];
  bool isLoading = true;
  String? erro;

  @override
  void initState() {
    super.initState();
    fetchTurmas();
  }

  Future<void> fetchTurmas() async {
    try {
      final response = await supabase
          .from('turmas')
          .select('*, turnos(trn_nome), anos(ano_numero)')
          .eq('tur_escola', widget.schoolId);

      setState(() {
        turmas = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        erro = e.toString();
        isLoading = false;
      });
    }
  }

  String formatarAno(dynamic ano) {
    if (ano == null) return '';
    return '${ano.toString()}º Ano';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecione a Turma'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : erro != null
            ? Center(
                child: Text(
                  'Erro: $erro',
                  style: const TextStyle(color: Colors.red),
                ),
              )
            : turmas.isEmpty
            ? const Center(child: Text('Nenhuma turma encontrada'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sua turma: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: turmas.length,
                      itemBuilder: (context, index) {
                        final turma = turmas[index];

                        final numero = turma['tur_numero']?.toString();

                        final turno = turma['turnos'] != null
                            ? turma['turnos']['trn_nome']?.toString()
                            : null;

                        final ano = turma['anos'] != null
                            ? turma['anos']['ano_numero']
                            : null;

                        final anoFormatado = formatarAno(ano);

                        final nomeTurma = (numero != null)
                            ? 'Turma: $numero'
                                  '${turno != null ? ' - $turno' : ''}'
                                  '${anoFormatado.isNotEmpty ? ' - $anoFormatado' : ''}'
                            : 'Sem nome';

                        final turmaId = turma['tur_id'];

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
                              nomeTurma,
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
                            onTap: turmaId == null
                                ? null
                                : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StudentSelection(turmaId: turmaId),
                                      ),
                                    );
                                  },
                          ),
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
