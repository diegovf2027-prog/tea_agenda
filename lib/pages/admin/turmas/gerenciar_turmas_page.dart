import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_agenda/data/local/database.dart';
import 'package:tea_agenda/pages/admin/turmas/adicionar_turma_page.dart';
import 'package:tea_agenda/pages/admin/turmas/detalhes_turma_page.dart';

class GerenciarTurmasPage extends StatefulWidget {
  const GerenciarTurmasPage({super.key});

  @override
  State<GerenciarTurmasPage> createState() => _GerenciarTurmasPageState();
}

class _GerenciarTurmasPageState extends State<GerenciarTurmasPage> {
  final TextEditingController _searchController = TextEditingController();
  String _filtro = '';

  @override
  Widget build(BuildContext context) {

    final database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciar Turmas"),
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
                labelText: 'Pesquisar turma',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          // Lista de Turmas
          Expanded(
            child: StreamBuilder<List<Turma>>(
              stream: database.watchTurmas(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Erro: ${snapshot.error}"));
                }

                final listaTurmas = snapshot.data ?? [];

                final turmasFiltradas = listaTurmas.where((turma) {
                  return turma.turNumero
                    .toString()
                    .toLowerCase()
                    .contains(_filtro.toLowerCase());
                }).toList();

                if (turmasFiltradas.isEmpty) {
                  return const Center(
                    child: Text("Nenhuma turma encontrada."),
                  );
                }

                return ListView.builder(
                  itemCount: turmasFiltradas.length,
                  itemBuilder: (context, index) {
                    final turma = turmasFiltradas[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.door_front_door, color: Colors.blue),
                        title: Text(turma.turNumero.toString()),
                        subtitle: FutureBuilder<Escola>(
                          future: database.getEscolaById(turma.turEscola),
                          builder: (context, snapshot) {
                            String anoFormatado = "${turma.turAno.index + 1}º Ano";
                            if (snapshot.hasData) {
                              return Text("$anoFormatado - ${snapshot.data!.escNome}");
                            }
                            return Text("$anoFormatado - Carregando escola...");
                          }
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdicionarTurmaPage(turmaEdicao : turma),
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesTurmaPage(turma: turma),
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
              builder: (context) => AdicionarTurmaPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}