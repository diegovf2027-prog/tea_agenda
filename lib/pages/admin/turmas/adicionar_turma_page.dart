import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as d;   // Não ter conflito com o Material
import 'package:tea_agenda/data/local/database.dart';
import 'package:provider/provider.dart';

class AdicionarTurmaPage extends StatefulWidget {
  final Turma? turmaEdicao;
  const AdicionarTurmaPage({super.key, this.turmaEdicao});

  @override
  State<AdicionarTurmaPage> createState() => _AdicionarTurmaPageState();
}

class _AdicionarTurmaPageState extends State<AdicionarTurmaPage> {
  final _formKey = GlobalKey<FormState>();

  final _numeroController = TextEditingController();

  Turno? _turnoSelecionado;
  Ano? _anoSelecionado;
  int? _escolaIdSelecionada;
  int? _professorIdSelecionado;

  @override
  void initState() {
    super.initState();
    if (widget.turmaEdicao != null) {
      _numeroController.text = widget.turmaEdicao!.turNumero.toString();
      _turnoSelecionado = widget.turmaEdicao!.turTurno;
      _anoSelecionado = widget.turmaEdicao!.turAno;
      _escolaIdSelecionada = widget.turmaEdicao!.turEscola;
      _professorIdSelecionado = widget.turmaEdicao!.turProfessorId;
    }
  }

  void _salvarTurma() async {
    if (_formKey.currentState!.validate() && _turnoSelecionado != null && _anoSelecionado != null && _escolaIdSelecionada != null && _professorIdSelecionado != null) {
      final database = Provider.of<AppDatabase>(context, listen: false);

      final novaTurma = TurmasCompanion(
        turNumero: d.Value(int.parse(_numeroController.text)),
        turTurno: d.Value(_turnoSelecionado!),
        turAno: d.Value(_anoSelecionado!),
        turEscola: d.Value(_escolaIdSelecionada!),
        turProfessorId: d.Value(_professorIdSelecionado!), 
      );

      if (widget.turmaEdicao != null) {
        await database.update(database.turmas).replace(
          novaTurma.copyWith(turId: d.Value(widget.turmaEdicao!.turId)),
        );
      } else {
        await database.into(database.turmas).insert(novaTurma);
      }

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.turmaEdicao != null ? 'Turma atualizada!' : 'Turma cadastrada!'), backgroundColor: Colors.green),
      );
    } else {
      String erro = "Preencha todos os campos corretamente!";

      if (_turnoSelecionado == null) {
        erro = "Selecione o turno da turma!";
      } else if (_anoSelecionado == null) {
        erro = "Selecione o ano da turma!";
      } else if (_escolaIdSelecionada == null) {
        erro = "Selecione a escola da turma!";
      } else if (_professorIdSelecionado == null) {
        erro = "Selecione o professor irá dar aula pra turma!";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(erro),
          backgroundColor: Colors.red
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.turmaEdicao != null ? 'Editar Turma' : 'Nova Turma')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _numeroController,
                decoration: const InputDecoration(labelText: 'Número da Turma', prefixIcon: Icon(Icons.door_front_door)),
                validator: (v) => v!.isEmpty ? 'Informe o número' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Turno>(
                value: _turnoSelecionado,
                decoration: const InputDecoration(labelText: 'Turno da Turma', prefixIcon: Icon(Icons.schedule)),
                items: Turno.values.map((Turno turno) {
                  return DropdownMenuItem(value: turno, child: Text(turno.name.toUpperCase()));
                }).toList(),
                onChanged: (val) => setState(() => _turnoSelecionado = val),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Ano>(
                value: _anoSelecionado,
                decoration: const InputDecoration(labelText: 'Ano da Turma', prefixIcon: Icon(Icons.event)),
                items: Ano.values.map((Ano ano) {
                  return DropdownMenuItem(value: ano, child: Text(ano.name.toUpperCase()));
                }).toList(),
                onChanged: (val) => setState(() => _anoSelecionado = val),
              ),
              const SizedBox(height: 12),
              StreamBuilder<List<Escola>>(
                stream: database.watchEscolas(),
                builder: (context, snapshot) {
                  final escolas = snapshot.data ?? [];
                  return DropdownButtonFormField<int> (
                    value: _escolaIdSelecionada,
                    decoration: const InputDecoration(labelText: 'Escola vinculada', prefixIcon: Icon(Icons.school)),
                    items: escolas.map((e) => DropdownMenuItem(value: e.escId, child: Text(e.escNome))).toList(),
                    onChanged: (val) {
                      setState(() {
                        _escolaIdSelecionada = val;
                        _professorIdSelecionado = null;
                      });
                    },
                    validator: (v) => v == null ? 'Selecione uma escola' : null,
                  );
                }
              ),
              const SizedBox(height: 12),
              StreamBuilder<List<Usuario>>(
                stream: _escolaIdSelecionada != null
                  ? database.watchProfessoresPorEscola(_escolaIdSelecionada!)
                  : const Stream.empty(),
                builder: (context, snapshot) {
                  final professores = snapshot.data ?? [];
                  return DropdownButtonFormField<int> (
                    value: _professorIdSelecionado,
                    decoration: const InputDecoration(labelText: 'Professor responsável', prefixIcon: Icon(Icons.person_pin)),
                    items: professores.map((e) => DropdownMenuItem(value: e.usuId, child: Text(e.usuNome))).toList(),
                    onChanged: (val) => setState(() => _professorIdSelecionado = val),
                    validator: (v) => v == null ? 'Selecione um professor' : null,
                  );
                }
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _salvarTurma,
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                child: Text(widget.turmaEdicao != null ? 'Salvar Alterações' : 'Cadastrar Turma'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}