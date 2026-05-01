import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_agenda/data/local/database.dart';
import 'package:tea_agenda/pages/admin/alunos/adicionar_aluno_page.dart';
import 'package:tea_agenda/pages/admin/alunos/detalhes_aluno_page.dart';

class GerenciarAlunosPage extends StatefulWidget {
  const GerenciarAlunosPage({super.key});

  @override
  State<GerenciarAlunosPage> createState() => _GerenciarAlunosPageState();
}

class _GerenciarAlunosPageState extends State<GerenciarAlunosPage> {
  final TextEditingController _searchController = TextEditingController();
  String _filtro = '';

  @override
  Widget build(BuildContext context) {

    final database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciar Alunos"),
      ),
      body: Column(
        children: [
          // Filtro
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _filtro = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Pesquisar aluno',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          // Lista de Alunos
          Expanded(
            child: StreamBuilder<List<Aluno>>(
              stream: database.watchAlunos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Erro: ${snapshot.error}"));
                }

                final listaAlunos = snapshot.data ?? [];

                final alunosFiltradors = listaAlunos.where((aluno) {
                  return aluno.aluNome
                    .toString()
                    .toLowerCase()
                    .contains(_filtro.toLowerCase());
                }).toList();

                if (alunosFiltradors.isEmpty) {
                  return const Center(
                    child: Text("Nenhum aluno encontrado."),
                  );
                }

                return ListView.builder(
                  itemCount: alunosFiltradors.length,
                  itemBuilder: (context, index) {
                    final aluno = alunosFiltradors[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.child_care, color: Colors.blue),
                        title: Text(aluno.aluNome),
                        subtitle: Text(aluno.aluCFP),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdicionarAlunoPage(alunoEdicao : aluno),
                              ),
                            );
                          }
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesAlunoPage(aluno: aluno),
                            )
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdicionarAlunoPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}