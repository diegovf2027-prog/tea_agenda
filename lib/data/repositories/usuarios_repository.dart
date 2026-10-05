import 'package:supabase_flutter/supabase_flutter.dart';

class UsuariosRepository {
  final supabase = Supabase.instance.client;

  // Função para retornar o usuário com o seu cargo
  Future<Map<String, dynamic>?> obterusUarioLogado() async {
    final user = supabase.auth.currentUser;

    if (user == null) return null;

    try {
      return await supabase
          .from('usuarios_com_cargos')
          .select()
          .eq('usu_id', user.id)
          .maybeSingle();
    } catch (e) {
      print('Erro ao buscar perfil: $e');
      return null;
    }
  }

  Future<Map<String, String>> obterNomesPorIds(Iterable<dynamic> ids) async {
    final idsUnicos = ids
        .where((id) => id != null)
        .map((id) => id.toString())
        .toSet()
        .toList();

    if (idsUnicos.isEmpty) return {};

    try {
      final usuarios = await supabase
          .from('usuarios_com_cargos')
          .select('usu_id, usu_nome')
          .inFilter('usu_id', idsUnicos);

      return {
        for (final usuario in usuarios)
          usuario['usu_id'].toString(): usuario['usu_nome']?.toString() ?? '',
      };
    } catch (e) {
      print('Erro ao buscar nomes dos assinantes: $e');
      return {};
    }
  }

  // Função para saber se o usuário é ADMINISTRADOR
  Future<bool> isAdmin() async {
    final perfil = await obterusUarioLogado();
    return perfil?['cargo_nome']?.toString().toUpperCase() == 'ADMINISTRADOR';
  }
}
