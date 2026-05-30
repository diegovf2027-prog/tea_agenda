import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_agenda/pages/professores/student_selection.dart';
import 'package:tea_agenda/pages/login_page.dart';

class ClassSelection extends StatefulWidget {
  const ClassSelection({super.key});

  @override
  State<ClassSelection> createState() => _ClassSelectionPageState();
}

class _ClassSelectionPageState extends State<ClassSelection> {
  final supabase = Supabase.instance.client;

  bool _verificandoCargo = true;
  bool _isAdmin = false;
  bool _isCuidador = false;
  List<int> _idsTurmasCuidador = [];

  @override
  void initState() {
    super.initState();
    _verificarCargo();
  }

  // Função para verificar o cargo do usuário
  Future<void> _verificarCargo() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;
      final dadosUsuario = await supabase.from('usuarios').select('usu_cargo').eq('usu_id', user.id).maybeSingle();

      if (dadosUsuario != null) {
        final int cargoId = dadosUsuario['usu_cargo'] ?? 0;

        // Administrador
        if (cargoId == 4) {
          setState(() {
            _isAdmin = true;
            _verificandoCargo = false;
          });
        // Cuidador
        } else if (cargoId == 1) {
          _isCuidador = true;
          await _turmasDosAlunosCuidador(user.id);
        // Professor
        } else {
          setState(() => _verificandoCargo = false);
        }
      } else {
        setState(() => _verificandoCargo = false);
      }
    } catch (e) {
      debugPrint("Erro ao verificar cargo: $e");
      setState(() => _verificandoCargo = false);
    }
  }

  // Buscar as turmas com os alunos vinculados ao cuidador
  Future<void> _turmasDosAlunosCuidador(String cuidadorId) async {
    try {
      final List<Map<String, dynamic>> alunosVinculados = await supabase.from('alunos').select('alu_turma').eq('alu_cuidador', cuidadorId);

      final ids = alunosVinculados.map((aluno) => aluno['alu_turma'] as int?).whereType<int>().toSet().toList();

      setState(() {
        _idsTurmasCuidador = ids;
        _verificandoCargo = false;
      });
    } catch (e) {
      debugPrint("Erro ao buscar turmas do cuidador: $e");
      setState(() => _verificandoCargo = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;

    if (_verificandoCargo) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas Turmas"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: () {
          if (_isAdmin) {
            return supabase.from('turmas_do_professor').stream(primaryKey: ['tur_id']).order('tur_numero', ascending: true);
          } else if (_isCuidador) {
            return supabase.from('turmas_do_professor').stream(primaryKey: ['tur_id']).inFilter('tur_id', _idsTurmasCuidador.isNotEmpty ? _idsTurmasCuidador : [-1]);
          } else {
            return supabase.from('turmas_do_professor').stream(primaryKey: ['tur_id']).eq('tur_professor', user!.id);
          }
        }(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar turmas: ${snapshot.error}"));
          }

          final turmas = snapshot.data ?? [];

          if (turmas.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Você não possui turmas vinculadas."),
                  const SizedBox(height: 16),
                  _buildBotaoDeslogar(),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: turmas.length,
                  itemBuilder: (context, index) {
                    final turma = turmas[index];
                    final String numeroTurma = turma['tur_numero']?.toString() ?? 'S/N';
                    final String numeroAno = turma['ano_numero']?.toString() ?? turma['tur_ano']?.toString() ?? '-';
                    final String nomeEscola = turma['esc_nome'] ?? 'Escola Geral';
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF2196F3),
                          child: Icon(Icons.groups, color: Colors.white),
                        ),
                        title: Text(
                          "Turma $numeroTurma",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("$numeroAnoº Ano - $nomeEscola"),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentSelection(
                                turmaId: turma['tur_id'],
                                turmaNome: numeroTurma,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                _buildBotaoDeslogar(),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBotaoDeslogar() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () async {
          try {
            await supabase.auth.signOut();
            if (mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            }
          } catch (e) {
            debugPrint("Erro ao deslogar: $e");
          }
        },
        icon: const Icon(Icons.logout),
        label: const Text('Sair do Sistema'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[50],
          foregroundColor: Colors.red,
        ),
      ),
    );
  }
}

