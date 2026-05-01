import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_agenda/pages/admin/escolas/adicionar_escola_page.dart';
import 'package:tea_agenda/pages/admin/escolas/detalhes_escola_page.dart';

class GerenciarEscolasPage extends StatefulWidget {
  const GerenciarEscolasPage({super.key});

  @override
  State<GerenciarEscolasPage> createState() => _GerenciarEscolasPageState();
}

class _GerenciarEscolasPageState extends State<GerenciarEscolasPage> {
  final TextEditingController _searchController = TextEditingController();
  String _filtro = '';

  final SupabaseClient supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {

    //final database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Escolas'),
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
                labelText: 'Pesquisar escola',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          // Lista das Escolas
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: supabase.from('escolas').stream(primaryKey: ['esc_id']).order('esc_nome'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Erro: ${snapshot.error}"));
                }

                final listaEscolas = snapshot.data ?? [];

                final escolasFiltradas = listaEscolas.where((escola) {
                  final nome = escola['esc_nome']?.toString().toLowerCase() ?? '';
                  return nome.contains(_filtro.toLowerCase());
                }).toList();

                if (escolasFiltradas.isEmpty) {
                  return const Center(
                    child: Text("Nenhuma escola encontrada."),
                  );
                }

                return ListView.builder(
                  itemCount: escolasFiltradas.length,
                  itemBuilder: (context, index) {
                    final escola = escolasFiltradas[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.business, color: Colors.blue),
                        title: Text(escola['esc_nome'] ?? 'Sem nome'),
                        subtitle: Text("${escola['esc_endereco'] ?? ''}, ${escola['esc_numero']} - ${escola['esc_bairro'] ?? ''}, ${escola['esc_cidade'] ?? ''}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdicionarEscolaPage(escolaEdicao: escola),
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesEscolaPage(escola: escola),
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
              builder: (context) => const AdicionarEscolaPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}