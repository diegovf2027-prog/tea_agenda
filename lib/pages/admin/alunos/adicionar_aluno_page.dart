import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as d; // Não ter conflito com o Material
import 'package:tea_agenda/data/local/database.dart';
import 'package:provider/provider.dart';

class AdicionarAlunoPage extends StatefulWidget {
  final Map<String, dynamic>? alunoEdicao;
  const AdicionarAlunoPage({super.key, this.alunoEdicao});

  @override
  State<AdicionarAlunoPage> createState() => _AdicionarAlunoPageState();
}

class _AdicionarAlunoPageState extends State<AdicionarAlunoPage> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();

  DateTime? _dataNascimento;
  int? _turmaIdSelecionada;
  int? _escolaIdSelecionada;
  String? _cuidadorIdSelecionado;

  List<Map<String, dynamic>> _escolas = [];
  List<Map<String, dynamic>> _turmas = [];
  List<Map<String, dynamic>> _cuidadores = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _inicializarDados();
  }

  Future<void> _inicializarDados() async {
    try {
      final escolasData = await supabase
          .from('escolas')
          .select()
          .order('esc_nome');

      setState(() {
        _escolas = List<Map<String, dynamic>>.from(escolasData);
        _carregando = false;
      });

      if (widget.alunoEdicao != null) {
        final a = widget.alunoEdicao!;
        _nomeController.text = a['alu_nome'] ?? '';
        _cpfController.text = a['alu_cpf'] ?? '';
        _dataNascimento = a['alu_dt_nascimento'] != null
            ? DateTime.parse(a['alu_dt_nascimento'])
            : null;
        _escolaIdSelecionada = a['alu_escola'];

        if (_escolaIdSelecionada != null) {
          await _carregarListasDependente(_escolaIdSelecionada!);
          setState(() {
            _turmaIdSelecionada = a['alu_turma'];
            _cuidadorIdSelecionado = a['alu_cuidador'];
          });
        }
      }
    } catch (e) {
      debugPrint("Erro ao inicializar: $e");
    }
  }

  Future<void> _carregarListasDependente(int escolaId) async {
    final resultados = await Future.wait([
      supabase
          .from('turmas')
          .select()
          .eq('tur_escola', escolaId)
          .order('tur_numero'),
      supabase
          .from('usuarios_com_cargos')
          .select()
          .eq('usu_escola', escolaId)
          .ilike('cargo_nome', 'CUIDADOR%'),
    ]);

    setState(() {
      _turmas = List<Map<String, dynamic>>.from(resultados[0]);
      _cuidadores = List<Map<String, dynamic>>.from(resultados[1]);
    });
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: _dataNascimento ?? DateTime(2015),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );
    if (dataSelecionada != null) {
      setState(() => _dataNascimento = dataSelecionada);
    }
  }

  void _salvarAluno() async {
    if (_formKey.currentState!.validate() &&
        _dataNascimento != null &&
        _turmaAluno != null &&
        _cuidadorIdSelecionada != null) {
      final database = Provider.of<AppDatabase>(context, listen: false);

      final dados = {
        'alu_nome': _nomeController.text.trim(),
        'alu_cpf': cpfLimpo,
        'alu_dt_nascimento': _dataNascimento!.toIso8601String().split('T')[0],
        'alu_escola': _escolaIdSelecionada,
        'alu_turma': _turmaIdSelecionada,
        'alu_cuidador': _cuidadorIdSelecionado,
      };

      if (widget.alunoEdicao != null) {
        await database
            .update(database.alunos)
            .replace(
              novoAluno.copyWith(aluId: d.Value(widget.alunoEdicao!.aluId)),
            );
      } else {
        await database.into(database.alunos).insert(novoAluno);
      }

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.alunoEdicao != null
                ? 'Aluno atualizado!'
                : 'Aluno cadastrado!',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      String erro = "Preencha todos os campos corretamente!";

      if (_dataNascimento == null) {
        erro = "Insira a data de nascimento do aluno!";
      } else if (_turmaAluno == null) {
        erro = "Selecione a turma do aluno!";
      } else if (_cuidadorIdSelecionada == null) {
        erro = "Selecione o cuidador responsável pelo aluno!";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(erro), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.alunoEdicao != null ? 'Editar Aluno' : 'Novo Aluno'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Aluno',
                  prefixIcon: Icon(Icons.child_care),
                ),
                validator: (v) => v!.isEmpty ? 'informe o nome do aluno' : null,
              ),

              const SizedBox(height: 12),
              TextFormField(
                controller: _cpfController,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  prefixIcon: Icon(Icons.badge),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o CPF';
                  if (!CPFValidator.isValid(value)) return 'CPF inválido';
                  return null;
                },
              ),

              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today),
                title: Text(
                  _dataNascimento == null
                      ? "Selecionar Data de Nascimento"
                      : "Nascimento: ${_dataNascimento!.day}/${_dataNascimento!.month}/${_dataNascimento!.year}",
                ),
                onTap: () => _selecionarData(context),
              ),

              const SizedBox(height: 12),
              StreamBuilder<List<Escola>>(
                stream: database.watchEscolas(),
                builder: (context, snapshot) {
                  final escolas = snapshot.data ?? [];
                  return DropdownButtonFormField<int>(
                    value: _escolaIdSelecionada,
                    decoration: const InputDecoration(
                      labelText: 'Escola vinculada',
                      prefixIcon: Icon(Icons.school),
                    ),
                    items: escolas
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.escId,
                            child: Text(e.escNome),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _escolaIdSelecionada = val;
                        _turmaAluno = null;
                        _cuidadorIdSelecionada = null;
                      });
                    },
                    validator: (v) => v == null ? 'Selecione uma escola' : null,
                  );
                },
              ),
              StreamBuilder<List<Turma>>(
                stream: _escolaIdSelecionada != null
                    ? database.watchTurmasPorEscola(_escolaIdSelecionada)
                    : const Stream.empty(),
                builder: (context, snapshot) {
                  final turmas = snapshot.data ?? [];
                  return DropdownButtonFormField<int>(
                    value: _turmaAluno,
                    decoration: const InputDecoration(
                      labelText: 'Turma',
                      prefixIcon: Icon(Icons.groups_3),
                    ),
                    items: turmas.map((t) {
                      return DropdownMenuItem(
                        value: t.turId,
                        child: Text(t.turNumero.toString()),
                      );
                    }).toList(),
                    onChanged: _escolaIdSelecionada == null
                        ? null
                        : (val) {
                            setState(() => _turmaAluno = val);
                          },
                    validator: (v) => v == null ? 'Selecione a turma' : null,
                  );
                },
              ),

              const SizedBox(height: 12),
              StreamBuilder<List<Usuario>>(
                stream: _escolaIdSelecionada != null
                    ? database.watchCuidadoresPorEscola(_escolaIdSelecionada!)
                    : const Stream.empty(),
                builder: (context, snapshot) {
                  final cuidadores = snapshot.data ?? [];
                  return DropdownButtonFormField<int>(
                    value: _cuidadorIdSelecionada,
                    decoration: const InputDecoration(
                      labelText: 'Cuidador responsável',
                      prefixIcon: Icon(Icons.person_pin),
                    ),
                    items: cuidadores
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.usuId,
                            child: Text(e.usuNome),
                          ),
                        )
                        .toList(),
                    onChanged: (val) =>
                        setState(() => _cuidadorIdSelecionada = val),
                    validator: (v) =>
                        v == null ? 'Selecione um cuidador' : null,
                  );
                },
              ),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _salvarAluno,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  widget.alunoEdicao != null
                      ? 'Salvar Alterações'
                      : 'Cadastrar Aluno',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
