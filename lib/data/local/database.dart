import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p; 

// Conexão com o Banco de Dados

part 'database.g.dart'; 

@DriftDatabase(tables: [Alunos, Turmas, Escolas, Usuarios, Registros])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Inserir escola e listar
  Future<int> insertEscola(EscolasCompanion escola) => into(escolas).insert(escola);
  Stream<List<Escola>> watchEscolas() => select(escolas).watch();

  // Listar usuários
  Stream<List<Usuario>> watchUsuarios() => select(usuarios).watch();

  // Listar turmas
  Stream<List<Turma>> watchTurmas() => select(turmas).watch();

  // Listar alunos
  Stream<List<Aluno>> watchAlunos() => select(alunos).watch();

  // Função para retornar apenas os professores, da escola vinculada a turma, quando for vincular o usuário a turma
  Stream<List<Usuario>> watchProfessoresPorEscola(int? escolaId) {
    if (escolaId == null) return const Stream.empty();

    return (select(usuarios)
      ..where((t) => 
          t.usuCargo.equals(Cargos.professor.name) & 
          t.usuEscola.equals(escolaId)
      )
    ).watch();
  }

  // Função para retornar apenas os cuidadores, da escola vinculada ao aluno, quando for vincular o cuidador ao aluno
  Stream<List<Usuario>> watchCuidadoresPorEscola(int? escolaId) {
    if (escolaId == null) return const Stream.empty();

    return (select(usuarios)
      ..where((t) => 
          t.usuCargo.equals(Cargos.cuidador.name) & 
          t.usuEscola.equals(escolaId)
      )
    ).watch();
  }

  // Função para retornar apenas as turmas, da escola vinculada ao aluno, quando for vincular o aluno a turma
  Stream<List<Turma>> watchTurmasPorEscola(int? escolaId) {
    if (escolaId == null) return const Stream.empty();

    return (select(turmas)..where((t) => t.turEscola.equals(escolaId))).watch();
  }

  // Função para retornar o nome da escola invés da ID
  Future<Escola> getEscolaById(int id) => (select(escolas)..where((t) => t.escId.equals(id))).getSingle();

  // Função para retornar o nome do professor ao invés da ID
  Future<Usuario> getUsuarioById(int id) => (select(usuarios)..where((t) => t.usuId.equals(id))).getSingle();

  // Função para retornar o número da turma ao invés da ID
  Future<Turma> getTurmaById(int id) => (select(turmas)..where((t) => t.turId.equals(id))).getSingle();

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'agenda_virtual.db'));
    return NativeDatabase(file);
  });
}

// Tabelas

enum Turno {matutino, vespertino}
enum Ano {primeiro, segundo, terceiro, quarto, quinto}

enum Alimentacao {boa, neutra, ruim}
enum Atividades {concluiu, concluiuParcialmente, naoConcluiu}
enum Comportamento {bom, ruim}

enum Cargos {admin, professor, cuidador, orientador, diretor}

// Tabela Alunos
class Alunos extends Table {
  IntColumn get aluId => integer().autoIncrement()();                         // ID do aluno
  TextColumn get aluNome => text().withLength(min: 1, max: 100)();            // Nome completo do aluno
  TextColumn get aluCFP => text().withLength(min:1, max: 14)();               // CPF do aluno
  DateTimeColumn get aluDtNascimento => dateTime()();                         // Data de nascimento do aluno
  IntColumn get aluEscolaId => integer().references(Escolas, #escId)();       // Id da escola (chave estrangeira)
  IntColumn get aluTurmaId => integer().references(Turmas, #turId)();         // ID da turma (chave estrangeira)
  IntColumn get aluCuidadorId => integer().references(Usuarios, #usuId)();    // ID do cuidador (chave estrangeira)
}

// Tabela Turmas
class Turmas extends Table {
  IntColumn get turId => integer().autoIncrement()();                         // ID da turma
  TextColumn get turTurno => textEnum<Turno>()();                             // Turno da turma
  IntColumn get turAno => intEnum<Ano>()();                                   // Ano de escolaridade da turma
  IntColumn get turNumero => integer()();                                     // Número da turma
  IntColumn get turEscola => integer().references(Escolas, #escId)();         // ID da escola (chave estrangeira)
  IntColumn get turProfessorId => integer().references(Usuarios, #usuId)();   // ID do professor (chave estrangeira)
}

// Tabela Escolas
class Escolas extends Table {
  IntColumn get escId => integer().autoIncrement()();                     // ID da escola
  TextColumn get escNome => text().withLength(min: 1, max: 100)();        // Nome da escola
  TextColumn get escCNPJ => text().withLength(min: 1, max: 18)();         // CNPJ da escola
  TextColumn get escEndereco => text().withLength(min: 1, max: 100)();    // Endereço da escola (rua e número)
  TextColumn get escBairro => text().withLength(min: 1, max: 100)();      // Bairro da Escola
  TextColumn get escCidade => text().withLength(min: 1, max: 100)();      // Cidade da Escola
  TextColumn get escCEP => text().withLength(min: 1, max: 9)();           // CEP da escola
}

// Tabela Usuários
class Usuarios extends Table {
  IntColumn get usuId => integer().autoIncrement()();                   // Id do usuário
  TextColumn get usuNome => text().withLength(min: 1, max: 100)();      // Nome do usuário
  TextColumn get usuCPF => text().withLength(min:1, max: 14)();         // CPF do usuário
  DateTimeColumn get usuDtNascimento => dateTime()();                   // Data de nascimento do usuário
  TextColumn get usuEmail => text().withLength(min: 1, max: 50)();      // E-mail do usuário
  TextColumn get usuCargo => textEnum<Cargos>()();                      // Cargo do usuário
  TextColumn get usuSenha => text().withLength(min: 8, max:10)();       // Senha do usuário
  IntColumn get usuEscola => integer().references(Escolas, #escId)();   // Id da escola (chave estrangeira)
}

// Resgitros
class Registros extends Table {
  IntColumn get regId => integer().autoIncrement()();                       // Id do registro
  DateTimeColumn get regData => dateTime()();                               // Data do registro
  TextColumn get regAlimentacao => textEnum<Alimentacao>()();               // Alimentação do aluno
  TextColumn get regAtividade => textEnum<Atividades>()();                  // Atividades do aluno
  TextColumn get regComportamento => textEnum<Comportamento>()();           // Comportamento do aluno
  TextColumn get regObservacao => text().withLength(min: 1, max: 100)();    // Observações
  IntColumn get regAluno => integer().references(Alunos, #aluId)();         // ID do aluno (chave estrangeira)
  IntColumn get regUsuario => integer().references(Usuarios, #usuId)();     // ID do usuário (chave estrangeira)
}