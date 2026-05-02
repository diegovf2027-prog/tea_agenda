import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
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
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: supabase.from('turmas_com_detalhes').stream(primaryKey: ['tur_id']).order('tur_numero'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Erro: ${snapshot.error}"));
                }

                final turmas = snapshot.data ?? [];

                final filtradas = turmas.where((t) {
                  return t['tur_numero'].toString().contains(_filtro);
                }).toList();

                if (filtradas.isEmpty) {
                  return const Center(child: Text("Nenhuma turma encontrada."));
                }

                return ListView.builder(
                  itemCount: filtradas.length,
                  itemBuilder: (context, index) {
                    final turma = filtradas[index];
                    String subtitulo = "${turma['ano_descricao']}º Ano - ${turma['escola_nome']}";
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.door_front_door, color: Colors.blue),
                        title: Text("Turma: ${turma['tur_numero']}"),
                        subtitle: Text(subtitulo),
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