import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
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
              onChanged: (value) => setState(() => _filtro = value),
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
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: supabase.from('alunos_com_detalhes').stream(primaryKey: ['alu_id']).order('alu_nome'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Erro: ${snapshot.error}"));
                }

                final listaAlunos = snapshot.data ?? [];

                final alunosFiltrados = listaAlunos.where((aluno) {
                  final nome = aluno['alu_nome']?.toString().toLowerCase() ?? '';
                  return nome.contains(_filtro.toLowerCase());
                }).toList();

                if (alunosFiltrados.isEmpty) {
                  return const Center(child: Text("Nenhum aluno encontrado."));
                }

                return ListView.builder(
                  itemCount: alunosFiltrados.length,
                  itemBuilder: (context, index) {
                    final aluno = alunosFiltrados[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.child_care, color: Colors.blue),
                        title: Text(
                          aluno['alu_nome'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Turma: ${aluno['turma_numero'] ?? 'N/A'} • ${aluno['escola_nome'] ?? 'Sem escola'}",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdicionarAlunoPage()),
          );
        },
        label: const Text("Novo Aluno"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}