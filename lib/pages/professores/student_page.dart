import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_agenda/pages/functions/calendar_page.dart';
import 'package:tea_agenda/pages/functions/reports.dart';
import 'package:tea_agenda/widgets/bottom_nav_bar.dart';
import 'package:tea_agenda/pages/functions/add_page.dart';
import 'package:tea_agenda/data/repositories/usuarios_repository.dart';

class StudentPage extends StatefulWidget {
  final String name;
  final int alunoId;

  const StudentPage({super.key, required this.name, required this.alunoId});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  int _selectedIndex = -1; // -1 mostra o feed inicial
  late Future<List<Map<String, dynamic>>> _feedFuture;

  // Seções sem o Feed na navegação inferior
  final List<String> pageTitles = ['Relatórios', 'Calendário', 'Adicionar'];

  @override
  void initState() {
    super.initState();
    _feedFuture = _fetchFeedRecords();
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goBack() {
    if (_selectedIndex == -1) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _selectedIndex = -1;
      });
    }
  }

  Widget _getBodyContent() {
    if (_selectedIndex == -1) {
      return _buildFeedSection();
    }

    switch (_selectedIndex) {
      case 0:
        return ReportsPage(alunoId: widget.alunoId);
      case 1:
        return CalendarPage(alunoId: widget.alunoId);
      case 2:
        return _buildAdicaoSection(widget.alunoId);
      default:
        return _buildFeedSection();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFeed = _selectedIndex == -1;
    return Scaffold(
      appBar: AppBar(
        title: Text(isFeed ? widget.name : pageTitles[_selectedIndex]),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
      ),
      body: _getBodyContent(),
      bottomNavigationBar: SizedBox(
        height: 120,
        child: BottomNavBar(
          selectedIndex: _selectedIndex,
          onTap: _onNavItemTapped,
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchFeedRecords() async {
    final supabase = Supabase.instance.client;
    final usuariosRepo = UsuariosRepository();

    final dados = await supabase
        .from('registros')
        .select('''
          *,
          alimentacao:reg_alimentacao(ali_status),
          atividades:reg_atividade(ati_status)
        ''')
        .eq('reg_aluno', widget.alunoId)
        .order('reg_created_at', ascending: false);

    final nomesAssinantes = await usuariosRepo.obterNomesPorIds(
      dados.map((registro) => registro['reg_usuario']),
    );

    final comportamentosPorRegistro =
        await _carregarComportamentosPorRegistro();

    for (final registro in dados) {
      final usuarioId = registro['reg_usuario']?.toString();
      registro['assinante_nome'] = usuarioId == null
          ? null
          : nomesAssinantes[usuarioId];
      final regId = registro['reg_id'] as int;
      final lista = comportamentosPorRegistro[regId] ?? [];
      registro['comportamentos'] = lista;
      if (lista.isNotEmpty) {
        registro['comportamento'] = {'com_status': lista.join(', ')};
      }
    }

    return List<Map<String, dynamic>>.from(dados);
  }

  Future<Map<int, List<String>>> _carregarComportamentosPorRegistro() async {
    final supabase = Supabase.instance.client;
    final tabelas = [
      'registro_comportamento',
      'reg_comportamento',
      'registros_comportamentos',
      'registro_comportamentos',
    ];

    final resultado = <int, List<String>>{};

    for (final tabela in tabelas) {
      try {
        final associados = await supabase
            .from(tabela)
            .select('reg_id, comportamento:com_id(com_status)');

        for (final item in associados) {
          final regId = item['reg_id'] as int;
          final nome = item['comportamento']?['com_status'];
          if (nome == null) continue;

          resultado.putIfAbsent(regId, () => []);
          final lista = resultado[regId]!;
          final texto = nome.toString();
          if (!lista.contains(texto)) {
            lista.add(texto);
          }
        }

        if (resultado.isNotEmpty) {
          return resultado;
        }
      } catch (_) {}
    }

    return resultado;
  }

  Widget _buildFeedSection() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _feedFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Erro ao carregar os registros: ${snapshot.error}'),
            ),
          );
        }

        final registros = snapshot.data ?? [];

        if (registros.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.feed_outlined, size: 48, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'Ainda não há registros para mostrar.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: registros.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final registro = registros[index];
            return _buildPostCard(registro);
          },
        );
      },
    );
  }

  Widget _buildPostCard(Map<String, dynamic> registro) {
    final data =
        DateTime.tryParse(registro['reg_created_at'] ?? '') ?? DateTime.now();
    final dataFormatada =
        '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
    final humor = _textoHumor(registro['reg_humor']);
    final alimentacao =
        registro['alimentacao']?['ali_status'] ?? 'Não informado';
    final rotina = registro['atividades']?['ati_status'] ?? 'Não informado';
    final comportamento = _formatComportamento(
      registro['comportamentos'] ?? registro['comportamento'],
    );
    final observacao = (registro['reg_observacao'] ?? '').toString().trim();
    final faltou = registro['reg_falta'] == true;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dataFormatada,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _corHumor(
                    registro['reg_humor'] ?? 3,
                  ).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  humor,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _corHumor(registro['reg_humor'] ?? 3),
                  ),
                ),
              ),
            ],
          ),
          if ((registro['assinante_nome'] ?? '').toString().isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.draw, size: 15, color: Colors.blueGrey),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Assinado por ${registro['assinante_nome']}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildPostTag('Alimentação', alimentacao),
              _buildPostTag('Comportamento', comportamento),
              _buildPostTag('Rotina', rotina),
            ],
          ),
          const SizedBox(height: 12),
          if (faltou)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Aluno faltou',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            )
          else if (observacao.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                observacao,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            )
          else
            const Text(
              'Sem observação registrada.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
        ],
      ),
    );
  }

  Widget _buildPostTag(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          fontSize: 11,
          color: const Color.fromARGB(255, 5, 5, 5),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatComportamento(dynamic comportamento) {
    if (comportamento == null) return 'Não informado';

    if (comportamento is List) {
      if (comportamento.isEmpty) return 'Não informado';
      return comportamento
          .map(
            (item) => item is Map
                ? (item['com_status'] ?? item.toString())
                : item.toString(),
          )
          .join(', ');
    }

    if (comportamento is Map) {
      return comportamento['com_status'] ?? 'Não informado';
    }

    return comportamento.toString();
  }

  Color _corHumor(int humorId) {
    switch (humorId) {
      case 1:
        return const Color(0xFFE00000);
      case 2:
        return const Color(0xFFE87500);
      case 3:
        return const Color(0xFFE5D500);
      case 4:
        return const Color(0xFF82D900);
      case 5:
        return const Color(0xFF00C82B);
      default:
        return Colors.grey;
    }
  }

  String _textoHumor(dynamic humorId) {
    switch (humorId) {
      case 1:
        return 'Precisa de apoio';
      case 2:
        return 'Em adaptação';
      case 3:
        return 'Regular';
      case 4:
        return 'Bem';
      case 5:
        return 'Muito bem';
      default:
        return 'Não Informado';
    }
  }

  Widget _buildAdicaoSection(int idDoAluno) {
    return AddPage(alunoId: idDoAluno);
  }
}
