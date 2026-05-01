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

  // Função para saber se o usuário é ADMINISTRADOR
  Future<bool> isAdmin() async {
    final perfil = await obterusUarioLogado();
    return perfil?['cargo_nome']?.toString().toUpperCase() == 'ADMINISTRADOR';
  }
}