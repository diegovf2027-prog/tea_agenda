// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $EscolasTable extends Escolas with TableInfo<$EscolasTable, Escola> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EscolasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _escIdMeta = const VerificationMeta('escId');
  @override
  late final GeneratedColumn<int> escId = GeneratedColumn<int>(
    'esc_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _escNomeMeta = const VerificationMeta(
    'escNome',
  );
  @override
  late final GeneratedColumn<String> escNome = GeneratedColumn<String>(
    'esc_nome',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _escCNPJMeta = const VerificationMeta(
    'escCNPJ',
  );
  @override
  late final GeneratedColumn<String> escCNPJ = GeneratedColumn<String>(
    'esc_c_n_p_j',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 18,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _escEnderecoMeta = const VerificationMeta(
    'escEndereco',
  );
  @override
  late final GeneratedColumn<String> escEndereco = GeneratedColumn<String>(
    'esc_endereco',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _escBairroMeta = const VerificationMeta(
    'escBairro',
  );
  @override
  late final GeneratedColumn<String> escBairro = GeneratedColumn<String>(
    'esc_bairro',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _escCidadeMeta = const VerificationMeta(
    'escCidade',
  );
  @override
  late final GeneratedColumn<String> escCidade = GeneratedColumn<String>(
    'esc_cidade',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _escCEPMeta = const VerificationMeta('escCEP');
  @override
  late final GeneratedColumn<String> escCEP = GeneratedColumn<String>(
    'esc_c_e_p',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 9,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    escId,
    escNome,
    escCNPJ,
    escEndereco,
    escBairro,
    escCidade,
    escCEP,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'escolas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Escola> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('esc_id')) {
      context.handle(
        _escIdMeta,
        escId.isAcceptableOrUnknown(data['esc_id']!, _escIdMeta),
      );
    }
    if (data.containsKey('esc_nome')) {
      context.handle(
        _escNomeMeta,
        escNome.isAcceptableOrUnknown(data['esc_nome']!, _escNomeMeta),
      );
    } else if (isInserting) {
      context.missing(_escNomeMeta);
    }
    if (data.containsKey('esc_c_n_p_j')) {
      context.handle(
        _escCNPJMeta,
        escCNPJ.isAcceptableOrUnknown(data['esc_c_n_p_j']!, _escCNPJMeta),
      );
    } else if (isInserting) {
      context.missing(_escCNPJMeta);
    }
    if (data.containsKey('esc_endereco')) {
      context.handle(
        _escEnderecoMeta,
        escEndereco.isAcceptableOrUnknown(
          data['esc_endereco']!,
          _escEnderecoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_escEnderecoMeta);
    }
    if (data.containsKey('esc_bairro')) {
      context.handle(
        _escBairroMeta,
        escBairro.isAcceptableOrUnknown(data['esc_bairro']!, _escBairroMeta),
      );
    } else if (isInserting) {
      context.missing(_escBairroMeta);
    }
    if (data.containsKey('esc_cidade')) {
      context.handle(
        _escCidadeMeta,
        escCidade.isAcceptableOrUnknown(data['esc_cidade']!, _escCidadeMeta),
      );
    } else if (isInserting) {
      context.missing(_escCidadeMeta);
    }
    if (data.containsKey('esc_c_e_p')) {
      context.handle(
        _escCEPMeta,
        escCEP.isAcceptableOrUnknown(data['esc_c_e_p']!, _escCEPMeta),
      );
    } else if (isInserting) {
      context.missing(_escCEPMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {escId};
  @override
  Escola map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Escola(
      escId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}esc_id'],
      )!,
      escNome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}esc_nome'],
      )!,
      escCNPJ: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}esc_c_n_p_j'],
      )!,
      escEndereco: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}esc_endereco'],
      )!,
      escBairro: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}esc_bairro'],
      )!,
      escCidade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}esc_cidade'],
      )!,
      escCEP: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}esc_c_e_p'],
      )!,
    );
  }

  @override
  $EscolasTable createAlias(String alias) {
    return $EscolasTable(attachedDatabase, alias);
  }
}

class Escola extends DataClass implements Insertable<Escola> {
  final int escId;
  final String escNome;
  final String escCNPJ;
  final String escEndereco;
  final String escBairro;
  final String escCidade;
  final String escCEP;
  const Escola({
    required this.escId,
    required this.escNome,
    required this.escCNPJ,
    required this.escEndereco,
    required this.escBairro,
    required this.escCidade,
    required this.escCEP,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['esc_id'] = Variable<int>(escId);
    map['esc_nome'] = Variable<String>(escNome);
    map['esc_c_n_p_j'] = Variable<String>(escCNPJ);
    map['esc_endereco'] = Variable<String>(escEndereco);
    map['esc_bairro'] = Variable<String>(escBairro);
    map['esc_cidade'] = Variable<String>(escCidade);
    map['esc_c_e_p'] = Variable<String>(escCEP);
    return map;
  }

  EscolasCompanion toCompanion(bool nullToAbsent) {
    return EscolasCompanion(
      escId: Value(escId),
      escNome: Value(escNome),
      escCNPJ: Value(escCNPJ),
      escEndereco: Value(escEndereco),
      escBairro: Value(escBairro),
      escCidade: Value(escCidade),
      escCEP: Value(escCEP),
    );
  }

  factory Escola.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Escola(
      escId: serializer.fromJson<int>(json['escId']),
      escNome: serializer.fromJson<String>(json['escNome']),
      escCNPJ: serializer.fromJson<String>(json['escCNPJ']),
      escEndereco: serializer.fromJson<String>(json['escEndereco']),
      escBairro: serializer.fromJson<String>(json['escBairro']),
      escCidade: serializer.fromJson<String>(json['escCidade']),
      escCEP: serializer.fromJson<String>(json['escCEP']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'escId': serializer.toJson<int>(escId),
      'escNome': serializer.toJson<String>(escNome),
      'escCNPJ': serializer.toJson<String>(escCNPJ),
      'escEndereco': serializer.toJson<String>(escEndereco),
      'escBairro': serializer.toJson<String>(escBairro),
      'escCidade': serializer.toJson<String>(escCidade),
      'escCEP': serializer.toJson<String>(escCEP),
    };
  }

  Escola copyWith({
    int? escId,
    String? escNome,
    String? escCNPJ,
    String? escEndereco,
    String? escBairro,
    String? escCidade,
    String? escCEP,
  }) => Escola(
    escId: escId ?? this.escId,
    escNome: escNome ?? this.escNome,
    escCNPJ: escCNPJ ?? this.escCNPJ,
    escEndereco: escEndereco ?? this.escEndereco,
    escBairro: escBairro ?? this.escBairro,
    escCidade: escCidade ?? this.escCidade,
    escCEP: escCEP ?? this.escCEP,
  );
  Escola copyWithCompanion(EscolasCompanion data) {
    return Escola(
      escId: data.escId.present ? data.escId.value : this.escId,
      escNome: data.escNome.present ? data.escNome.value : this.escNome,
      escCNPJ: data.escCNPJ.present ? data.escCNPJ.value : this.escCNPJ,
      escEndereco: data.escEndereco.present
          ? data.escEndereco.value
          : this.escEndereco,
      escBairro: data.escBairro.present ? data.escBairro.value : this.escBairro,
      escCidade: data.escCidade.present ? data.escCidade.value : this.escCidade,
      escCEP: data.escCEP.present ? data.escCEP.value : this.escCEP,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Escola(')
          ..write('escId: $escId, ')
          ..write('escNome: $escNome, ')
          ..write('escCNPJ: $escCNPJ, ')
          ..write('escEndereco: $escEndereco, ')
          ..write('escBairro: $escBairro, ')
          ..write('escCidade: $escCidade, ')
          ..write('escCEP: $escCEP')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    escId,
    escNome,
    escCNPJ,
    escEndereco,
    escBairro,
    escCidade,
    escCEP,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Escola &&
          other.escId == this.escId &&
          other.escNome == this.escNome &&
          other.escCNPJ == this.escCNPJ &&
          other.escEndereco == this.escEndereco &&
          other.escBairro == this.escBairro &&
          other.escCidade == this.escCidade &&
          other.escCEP == this.escCEP);
}

class EscolasCompanion extends UpdateCompanion<Escola> {
  final Value<int> escId;
  final Value<String> escNome;
  final Value<String> escCNPJ;
  final Value<String> escEndereco;
  final Value<String> escBairro;
  final Value<String> escCidade;
  final Value<String> escCEP;
  const EscolasCompanion({
    this.escId = const Value.absent(),
    this.escNome = const Value.absent(),
    this.escCNPJ = const Value.absent(),
    this.escEndereco = const Value.absent(),
    this.escBairro = const Value.absent(),
    this.escCidade = const Value.absent(),
    this.escCEP = const Value.absent(),
  });
  EscolasCompanion.insert({
    this.escId = const Value.absent(),
    required String escNome,
    required String escCNPJ,
    required String escEndereco,
    required String escBairro,
    required String escCidade,
    required String escCEP,
  }) : escNome = Value(escNome),
       escCNPJ = Value(escCNPJ),
       escEndereco = Value(escEndereco),
       escBairro = Value(escBairro),
       escCidade = Value(escCidade),
       escCEP = Value(escCEP);
  static Insertable<Escola> custom({
    Expression<int>? escId,
    Expression<String>? escNome,
    Expression<String>? escCNPJ,
    Expression<String>? escEndereco,
    Expression<String>? escBairro,
    Expression<String>? escCidade,
    Expression<String>? escCEP,
  }) {
    return RawValuesInsertable({
      if (escId != null) 'esc_id': escId,
      if (escNome != null) 'esc_nome': escNome,
      if (escCNPJ != null) 'esc_c_n_p_j': escCNPJ,
      if (escEndereco != null) 'esc_endereco': escEndereco,
      if (escBairro != null) 'esc_bairro': escBairro,
      if (escCidade != null) 'esc_cidade': escCidade,
      if (escCEP != null) 'esc_c_e_p': escCEP,
    });
  }

  EscolasCompanion copyWith({
    Value<int>? escId,
    Value<String>? escNome,
    Value<String>? escCNPJ,
    Value<String>? escEndereco,
    Value<String>? escBairro,
    Value<String>? escCidade,
    Value<String>? escCEP,
  }) {
    return EscolasCompanion(
      escId: escId ?? this.escId,
      escNome: escNome ?? this.escNome,
      escCNPJ: escCNPJ ?? this.escCNPJ,
      escEndereco: escEndereco ?? this.escEndereco,
      escBairro: escBairro ?? this.escBairro,
      escCidade: escCidade ?? this.escCidade,
      escCEP: escCEP ?? this.escCEP,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (escId.present) {
      map['esc_id'] = Variable<int>(escId.value);
    }
    if (escNome.present) {
      map['esc_nome'] = Variable<String>(escNome.value);
    }
    if (escCNPJ.present) {
      map['esc_c_n_p_j'] = Variable<String>(escCNPJ.value);
    }
    if (escEndereco.present) {
      map['esc_endereco'] = Variable<String>(escEndereco.value);
    }
    if (escBairro.present) {
      map['esc_bairro'] = Variable<String>(escBairro.value);
    }
    if (escCidade.present) {
      map['esc_cidade'] = Variable<String>(escCidade.value);
    }
    if (escCEP.present) {
      map['esc_c_e_p'] = Variable<String>(escCEP.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EscolasCompanion(')
          ..write('escId: $escId, ')
          ..write('escNome: $escNome, ')
          ..write('escCNPJ: $escCNPJ, ')
          ..write('escEndereco: $escEndereco, ')
          ..write('escBairro: $escBairro, ')
          ..write('escCidade: $escCidade, ')
          ..write('escCEP: $escCEP')
          ..write(')'))
        .toString();
  }
}

class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _usuIdMeta = const VerificationMeta('usuId');
  @override
  late final GeneratedColumn<int> usuId = GeneratedColumn<int>(
    'usu_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usuNomeMeta = const VerificationMeta(
    'usuNome',
  );
  @override
  late final GeneratedColumn<String> usuNome = GeneratedColumn<String>(
    'usu_nome',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usuCPFMeta = const VerificationMeta('usuCPF');
  @override
  late final GeneratedColumn<String> usuCPF = GeneratedColumn<String>(
    'usu_c_p_f',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 14,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usuDtNascimentoMeta = const VerificationMeta(
    'usuDtNascimento',
  );
  @override
  late final GeneratedColumn<DateTime> usuDtNascimento =
      GeneratedColumn<DateTime>(
        'usu_dt_nascimento',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _usuEmailMeta = const VerificationMeta(
    'usuEmail',
  );
  @override
  late final GeneratedColumn<String> usuEmail = GeneratedColumn<String>(
    'usu_email',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Cargos, String> usuCargo =
      GeneratedColumn<String>(
        'usu_cargo',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Cargos>($UsuariosTable.$converterusuCargo);
  static const VerificationMeta _usuSenhaMeta = const VerificationMeta(
    'usuSenha',
  );
  @override
  late final GeneratedColumn<String> usuSenha = GeneratedColumn<String>(
    'usu_senha',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 8,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usuEscolaMeta = const VerificationMeta(
    'usuEscola',
  );
  @override
  late final GeneratedColumn<int> usuEscola = GeneratedColumn<int>(
    'usu_escola',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES escolas (esc_id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    usuId,
    usuNome,
    usuCPF,
    usuDtNascimento,
    usuEmail,
    usuCargo,
    usuSenha,
    usuEscola,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Usuario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('usu_id')) {
      context.handle(
        _usuIdMeta,
        usuId.isAcceptableOrUnknown(data['usu_id']!, _usuIdMeta),
      );
    }
    if (data.containsKey('usu_nome')) {
      context.handle(
        _usuNomeMeta,
        usuNome.isAcceptableOrUnknown(data['usu_nome']!, _usuNomeMeta),
      );
    } else if (isInserting) {
      context.missing(_usuNomeMeta);
    }
    if (data.containsKey('usu_c_p_f')) {
      context.handle(
        _usuCPFMeta,
        usuCPF.isAcceptableOrUnknown(data['usu_c_p_f']!, _usuCPFMeta),
      );
    } else if (isInserting) {
      context.missing(_usuCPFMeta);
    }
    if (data.containsKey('usu_dt_nascimento')) {
      context.handle(
        _usuDtNascimentoMeta,
        usuDtNascimento.isAcceptableOrUnknown(
          data['usu_dt_nascimento']!,
          _usuDtNascimentoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_usuDtNascimentoMeta);
    }
    if (data.containsKey('usu_email')) {
      context.handle(
        _usuEmailMeta,
        usuEmail.isAcceptableOrUnknown(data['usu_email']!, _usuEmailMeta),
      );
    } else if (isInserting) {
      context.missing(_usuEmailMeta);
    }
    if (data.containsKey('usu_senha')) {
      context.handle(
        _usuSenhaMeta,
        usuSenha.isAcceptableOrUnknown(data['usu_senha']!, _usuSenhaMeta),
      );
    } else if (isInserting) {
      context.missing(_usuSenhaMeta);
    }
    if (data.containsKey('usu_escola')) {
      context.handle(
        _usuEscolaMeta,
        usuEscola.isAcceptableOrUnknown(data['usu_escola']!, _usuEscolaMeta),
      );
    } else if (isInserting) {
      context.missing(_usuEscolaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {usuId};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      usuId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usu_id'],
      )!,
      usuNome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usu_nome'],
      )!,
      usuCPF: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usu_c_p_f'],
      )!,
      usuDtNascimento: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}usu_dt_nascimento'],
      )!,
      usuEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usu_email'],
      )!,
      usuCargo: $UsuariosTable.$converterusuCargo.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}usu_cargo'],
        )!,
      ),
      usuSenha: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usu_senha'],
      )!,
      usuEscola: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usu_escola'],
      )!,
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Cargos, String, String> $converterusuCargo =
      const EnumNameConverter<Cargos>(Cargos.values);
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final int usuId;
  final String usuNome;
  final String usuCPF;
  final DateTime usuDtNascimento;
  final String usuEmail;
  final Cargos usuCargo;
  final String usuSenha;
  final int usuEscola;
  const Usuario({
    required this.usuId,
    required this.usuNome,
    required this.usuCPF,
    required this.usuDtNascimento,
    required this.usuEmail,
    required this.usuCargo,
    required this.usuSenha,
    required this.usuEscola,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['usu_id'] = Variable<int>(usuId);
    map['usu_nome'] = Variable<String>(usuNome);
    map['usu_c_p_f'] = Variable<String>(usuCPF);
    map['usu_dt_nascimento'] = Variable<DateTime>(usuDtNascimento);
    map['usu_email'] = Variable<String>(usuEmail);
    {
      map['usu_cargo'] = Variable<String>(
        $UsuariosTable.$converterusuCargo.toSql(usuCargo),
      );
    }
    map['usu_senha'] = Variable<String>(usuSenha);
    map['usu_escola'] = Variable<int>(usuEscola);
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      usuId: Value(usuId),
      usuNome: Value(usuNome),
      usuCPF: Value(usuCPF),
      usuDtNascimento: Value(usuDtNascimento),
      usuEmail: Value(usuEmail),
      usuCargo: Value(usuCargo),
      usuSenha: Value(usuSenha),
      usuEscola: Value(usuEscola),
    );
  }

  factory Usuario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      usuId: serializer.fromJson<int>(json['usuId']),
      usuNome: serializer.fromJson<String>(json['usuNome']),
      usuCPF: serializer.fromJson<String>(json['usuCPF']),
      usuDtNascimento: serializer.fromJson<DateTime>(json['usuDtNascimento']),
      usuEmail: serializer.fromJson<String>(json['usuEmail']),
      usuCargo: $UsuariosTable.$converterusuCargo.fromJson(
        serializer.fromJson<String>(json['usuCargo']),
      ),
      usuSenha: serializer.fromJson<String>(json['usuSenha']),
      usuEscola: serializer.fromJson<int>(json['usuEscola']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'usuId': serializer.toJson<int>(usuId),
      'usuNome': serializer.toJson<String>(usuNome),
      'usuCPF': serializer.toJson<String>(usuCPF),
      'usuDtNascimento': serializer.toJson<DateTime>(usuDtNascimento),
      'usuEmail': serializer.toJson<String>(usuEmail),
      'usuCargo': serializer.toJson<String>(
        $UsuariosTable.$converterusuCargo.toJson(usuCargo),
      ),
      'usuSenha': serializer.toJson<String>(usuSenha),
      'usuEscola': serializer.toJson<int>(usuEscola),
    };
  }

  Usuario copyWith({
    int? usuId,
    String? usuNome,
    String? usuCPF,
    DateTime? usuDtNascimento,
    String? usuEmail,
    Cargos? usuCargo,
    String? usuSenha,
    int? usuEscola,
  }) => Usuario(
    usuId: usuId ?? this.usuId,
    usuNome: usuNome ?? this.usuNome,
    usuCPF: usuCPF ?? this.usuCPF,
    usuDtNascimento: usuDtNascimento ?? this.usuDtNascimento,
    usuEmail: usuEmail ?? this.usuEmail,
    usuCargo: usuCargo ?? this.usuCargo,
    usuSenha: usuSenha ?? this.usuSenha,
    usuEscola: usuEscola ?? this.usuEscola,
  );
  Usuario copyWithCompanion(UsuariosCompanion data) {
    return Usuario(
      usuId: data.usuId.present ? data.usuId.value : this.usuId,
      usuNome: data.usuNome.present ? data.usuNome.value : this.usuNome,
      usuCPF: data.usuCPF.present ? data.usuCPF.value : this.usuCPF,
      usuDtNascimento: data.usuDtNascimento.present
          ? data.usuDtNascimento.value
          : this.usuDtNascimento,
      usuEmail: data.usuEmail.present ? data.usuEmail.value : this.usuEmail,
      usuCargo: data.usuCargo.present ? data.usuCargo.value : this.usuCargo,
      usuSenha: data.usuSenha.present ? data.usuSenha.value : this.usuSenha,
      usuEscola: data.usuEscola.present ? data.usuEscola.value : this.usuEscola,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('usuId: $usuId, ')
          ..write('usuNome: $usuNome, ')
          ..write('usuCPF: $usuCPF, ')
          ..write('usuDtNascimento: $usuDtNascimento, ')
          ..write('usuEmail: $usuEmail, ')
          ..write('usuCargo: $usuCargo, ')
          ..write('usuSenha: $usuSenha, ')
          ..write('usuEscola: $usuEscola')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    usuId,
    usuNome,
    usuCPF,
    usuDtNascimento,
    usuEmail,
    usuCargo,
    usuSenha,
    usuEscola,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.usuId == this.usuId &&
          other.usuNome == this.usuNome &&
          other.usuCPF == this.usuCPF &&
          other.usuDtNascimento == this.usuDtNascimento &&
          other.usuEmail == this.usuEmail &&
          other.usuCargo == this.usuCargo &&
          other.usuSenha == this.usuSenha &&
          other.usuEscola == this.usuEscola);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<int> usuId;
  final Value<String> usuNome;
  final Value<String> usuCPF;
  final Value<DateTime> usuDtNascimento;
  final Value<String> usuEmail;
  final Value<Cargos> usuCargo;
  final Value<String> usuSenha;
  final Value<int> usuEscola;
  const UsuariosCompanion({
    this.usuId = const Value.absent(),
    this.usuNome = const Value.absent(),
    this.usuCPF = const Value.absent(),
    this.usuDtNascimento = const Value.absent(),
    this.usuEmail = const Value.absent(),
    this.usuCargo = const Value.absent(),
    this.usuSenha = const Value.absent(),
    this.usuEscola = const Value.absent(),
  });
  UsuariosCompanion.insert({
    this.usuId = const Value.absent(),
    required String usuNome,
    required String usuCPF,
    required DateTime usuDtNascimento,
    required String usuEmail,
    required Cargos usuCargo,
    required String usuSenha,
    required int usuEscola,
  }) : usuNome = Value(usuNome),
       usuCPF = Value(usuCPF),
       usuDtNascimento = Value(usuDtNascimento),
       usuEmail = Value(usuEmail),
       usuCargo = Value(usuCargo),
       usuSenha = Value(usuSenha),
       usuEscola = Value(usuEscola);
  static Insertable<Usuario> custom({
    Expression<int>? usuId,
    Expression<String>? usuNome,
    Expression<String>? usuCPF,
    Expression<DateTime>? usuDtNascimento,
    Expression<String>? usuEmail,
    Expression<String>? usuCargo,
    Expression<String>? usuSenha,
    Expression<int>? usuEscola,
  }) {
    return RawValuesInsertable({
      if (usuId != null) 'usu_id': usuId,
      if (usuNome != null) 'usu_nome': usuNome,
      if (usuCPF != null) 'usu_c_p_f': usuCPF,
      if (usuDtNascimento != null) 'usu_dt_nascimento': usuDtNascimento,
      if (usuEmail != null) 'usu_email': usuEmail,
      if (usuCargo != null) 'usu_cargo': usuCargo,
      if (usuSenha != null) 'usu_senha': usuSenha,
      if (usuEscola != null) 'usu_escola': usuEscola,
    });
  }

  UsuariosCompanion copyWith({
    Value<int>? usuId,
    Value<String>? usuNome,
    Value<String>? usuCPF,
    Value<DateTime>? usuDtNascimento,
    Value<String>? usuEmail,
    Value<Cargos>? usuCargo,
    Value<String>? usuSenha,
    Value<int>? usuEscola,
  }) {
    return UsuariosCompanion(
      usuId: usuId ?? this.usuId,
      usuNome: usuNome ?? this.usuNome,
      usuCPF: usuCPF ?? this.usuCPF,
      usuDtNascimento: usuDtNascimento ?? this.usuDtNascimento,
      usuEmail: usuEmail ?? this.usuEmail,
      usuCargo: usuCargo ?? this.usuCargo,
      usuSenha: usuSenha ?? this.usuSenha,
      usuEscola: usuEscola ?? this.usuEscola,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (usuId.present) {
      map['usu_id'] = Variable<int>(usuId.value);
    }
    if (usuNome.present) {
      map['usu_nome'] = Variable<String>(usuNome.value);
    }
    if (usuCPF.present) {
      map['usu_c_p_f'] = Variable<String>(usuCPF.value);
    }
    if (usuDtNascimento.present) {
      map['usu_dt_nascimento'] = Variable<DateTime>(usuDtNascimento.value);
    }
    if (usuEmail.present) {
      map['usu_email'] = Variable<String>(usuEmail.value);
    }
    if (usuCargo.present) {
      map['usu_cargo'] = Variable<String>(
        $UsuariosTable.$converterusuCargo.toSql(usuCargo.value),
      );
    }
    if (usuSenha.present) {
      map['usu_senha'] = Variable<String>(usuSenha.value);
    }
    if (usuEscola.present) {
      map['usu_escola'] = Variable<int>(usuEscola.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('usuId: $usuId, ')
          ..write('usuNome: $usuNome, ')
          ..write('usuCPF: $usuCPF, ')
          ..write('usuDtNascimento: $usuDtNascimento, ')
          ..write('usuEmail: $usuEmail, ')
          ..write('usuCargo: $usuCargo, ')
          ..write('usuSenha: $usuSenha, ')
          ..write('usuEscola: $usuEscola')
          ..write(')'))
        .toString();
  }
}

class $TurmasTable extends Turmas with TableInfo<$TurmasTable, Turma> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TurmasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _turIdMeta = const VerificationMeta('turId');
  @override
  late final GeneratedColumn<int> turId = GeneratedColumn<int>(
    'tur_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Turno, String> turTurno =
      GeneratedColumn<String>(
        'tur_turno',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Turno>($TurmasTable.$converterturTurno);
  @override
  late final GeneratedColumnWithTypeConverter<Ano, int> turAno =
      GeneratedColumn<int>(
        'tur_ano',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Ano>($TurmasTable.$converterturAno);
  static const VerificationMeta _turNumeroMeta = const VerificationMeta(
    'turNumero',
  );
  @override
  late final GeneratedColumn<int> turNumero = GeneratedColumn<int>(
    'tur_numero',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _turEscolaMeta = const VerificationMeta(
    'turEscola',
  );
  @override
  late final GeneratedColumn<int> turEscola = GeneratedColumn<int>(
    'tur_escola',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES escolas (esc_id)',
    ),
  );
  static const VerificationMeta _turProfessorIdMeta = const VerificationMeta(
    'turProfessorId',
  );
  @override
  late final GeneratedColumn<int> turProfessorId = GeneratedColumn<int>(
    'tur_professor_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (usu_id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    turId,
    turTurno,
    turAno,
    turNumero,
    turEscola,
    turProfessorId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'turmas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Turma> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tur_id')) {
      context.handle(
        _turIdMeta,
        turId.isAcceptableOrUnknown(data['tur_id']!, _turIdMeta),
      );
    }
    if (data.containsKey('tur_numero')) {
      context.handle(
        _turNumeroMeta,
        turNumero.isAcceptableOrUnknown(data['tur_numero']!, _turNumeroMeta),
      );
    } else if (isInserting) {
      context.missing(_turNumeroMeta);
    }
    if (data.containsKey('tur_escola')) {
      context.handle(
        _turEscolaMeta,
        turEscola.isAcceptableOrUnknown(data['tur_escola']!, _turEscolaMeta),
      );
    } else if (isInserting) {
      context.missing(_turEscolaMeta);
    }
    if (data.containsKey('tur_professor_id')) {
      context.handle(
        _turProfessorIdMeta,
        turProfessorId.isAcceptableOrUnknown(
          data['tur_professor_id']!,
          _turProfessorIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_turProfessorIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {turId};
  @override
  Turma map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Turma(
      turId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tur_id'],
      )!,
      turTurno: $TurmasTable.$converterturTurno.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tur_turno'],
        )!,
      ),
      turAno: $TurmasTable.$converterturAno.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}tur_ano'],
        )!,
      ),
      turNumero: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tur_numero'],
      )!,
      turEscola: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tur_escola'],
      )!,
      turProfessorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tur_professor_id'],
      )!,
    );
  }

  @override
  $TurmasTable createAlias(String alias) {
    return $TurmasTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Turno, String, String> $converterturTurno =
      const EnumNameConverter<Turno>(Turno.values);
  static JsonTypeConverter2<Ano, int, int> $converterturAno =
      const EnumIndexConverter<Ano>(Ano.values);
}

class Turma extends DataClass implements Insertable<Turma> {
  final int turId;
  final Turno turTurno;
  final Ano turAno;
  final int turNumero;
  final int turEscola;
  final int turProfessorId;
  const Turma({
    required this.turId,
    required this.turTurno,
    required this.turAno,
    required this.turNumero,
    required this.turEscola,
    required this.turProfessorId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tur_id'] = Variable<int>(turId);
    {
      map['tur_turno'] = Variable<String>(
        $TurmasTable.$converterturTurno.toSql(turTurno),
      );
    }
    {
      map['tur_ano'] = Variable<int>(
        $TurmasTable.$converterturAno.toSql(turAno),
      );
    }
    map['tur_numero'] = Variable<int>(turNumero);
    map['tur_escola'] = Variable<int>(turEscola);
    map['tur_professor_id'] = Variable<int>(turProfessorId);
    return map;
  }

  TurmasCompanion toCompanion(bool nullToAbsent) {
    return TurmasCompanion(
      turId: Value(turId),
      turTurno: Value(turTurno),
      turAno: Value(turAno),
      turNumero: Value(turNumero),
      turEscola: Value(turEscola),
      turProfessorId: Value(turProfessorId),
    );
  }

  factory Turma.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Turma(
      turId: serializer.fromJson<int>(json['turId']),
      turTurno: $TurmasTable.$converterturTurno.fromJson(
        serializer.fromJson<String>(json['turTurno']),
      ),
      turAno: $TurmasTable.$converterturAno.fromJson(
        serializer.fromJson<int>(json['turAno']),
      ),
      turNumero: serializer.fromJson<int>(json['turNumero']),
      turEscola: serializer.fromJson<int>(json['turEscola']),
      turProfessorId: serializer.fromJson<int>(json['turProfessorId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'turId': serializer.toJson<int>(turId),
      'turTurno': serializer.toJson<String>(
        $TurmasTable.$converterturTurno.toJson(turTurno),
      ),
      'turAno': serializer.toJson<int>(
        $TurmasTable.$converterturAno.toJson(turAno),
      ),
      'turNumero': serializer.toJson<int>(turNumero),
      'turEscola': serializer.toJson<int>(turEscola),
      'turProfessorId': serializer.toJson<int>(turProfessorId),
    };
  }

  Turma copyWith({
    int? turId,
    Turno? turTurno,
    Ano? turAno,
    int? turNumero,
    int? turEscola,
    int? turProfessorId,
  }) => Turma(
    turId: turId ?? this.turId,
    turTurno: turTurno ?? this.turTurno,
    turAno: turAno ?? this.turAno,
    turNumero: turNumero ?? this.turNumero,
    turEscola: turEscola ?? this.turEscola,
    turProfessorId: turProfessorId ?? this.turProfessorId,
  );
  Turma copyWithCompanion(TurmasCompanion data) {
    return Turma(
      turId: data.turId.present ? data.turId.value : this.turId,
      turTurno: data.turTurno.present ? data.turTurno.value : this.turTurno,
      turAno: data.turAno.present ? data.turAno.value : this.turAno,
      turNumero: data.turNumero.present ? data.turNumero.value : this.turNumero,
      turEscola: data.turEscola.present ? data.turEscola.value : this.turEscola,
      turProfessorId: data.turProfessorId.present
          ? data.turProfessorId.value
          : this.turProfessorId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Turma(')
          ..write('turId: $turId, ')
          ..write('turTurno: $turTurno, ')
          ..write('turAno: $turAno, ')
          ..write('turNumero: $turNumero, ')
          ..write('turEscola: $turEscola, ')
          ..write('turProfessorId: $turProfessorId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    turId,
    turTurno,
    turAno,
    turNumero,
    turEscola,
    turProfessorId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Turma &&
          other.turId == this.turId &&
          other.turTurno == this.turTurno &&
          other.turAno == this.turAno &&
          other.turNumero == this.turNumero &&
          other.turEscola == this.turEscola &&
          other.turProfessorId == this.turProfessorId);
}

class TurmasCompanion extends UpdateCompanion<Turma> {
  final Value<int> turId;
  final Value<Turno> turTurno;
  final Value<Ano> turAno;
  final Value<int> turNumero;
  final Value<int> turEscola;
  final Value<int> turProfessorId;
  const TurmasCompanion({
    this.turId = const Value.absent(),
    this.turTurno = const Value.absent(),
    this.turAno = const Value.absent(),
    this.turNumero = const Value.absent(),
    this.turEscola = const Value.absent(),
    this.turProfessorId = const Value.absent(),
  });
  TurmasCompanion.insert({
    this.turId = const Value.absent(),
    required Turno turTurno,
    required Ano turAno,
    required int turNumero,
    required int turEscola,
    required int turProfessorId,
  }) : turTurno = Value(turTurno),
       turAno = Value(turAno),
       turNumero = Value(turNumero),
       turEscola = Value(turEscola),
       turProfessorId = Value(turProfessorId);
  static Insertable<Turma> custom({
    Expression<int>? turId,
    Expression<String>? turTurno,
    Expression<int>? turAno,
    Expression<int>? turNumero,
    Expression<int>? turEscola,
    Expression<int>? turProfessorId,
  }) {
    return RawValuesInsertable({
      if (turId != null) 'tur_id': turId,
      if (turTurno != null) 'tur_turno': turTurno,
      if (turAno != null) 'tur_ano': turAno,
      if (turNumero != null) 'tur_numero': turNumero,
      if (turEscola != null) 'tur_escola': turEscola,
      if (turProfessorId != null) 'tur_professor_id': turProfessorId,
    });
  }

  TurmasCompanion copyWith({
    Value<int>? turId,
    Value<Turno>? turTurno,
    Value<Ano>? turAno,
    Value<int>? turNumero,
    Value<int>? turEscola,
    Value<int>? turProfessorId,
  }) {
    return TurmasCompanion(
      turId: turId ?? this.turId,
      turTurno: turTurno ?? this.turTurno,
      turAno: turAno ?? this.turAno,
      turNumero: turNumero ?? this.turNumero,
      turEscola: turEscola ?? this.turEscola,
      turProfessorId: turProfessorId ?? this.turProfessorId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (turId.present) {
      map['tur_id'] = Variable<int>(turId.value);
    }
    if (turTurno.present) {
      map['tur_turno'] = Variable<String>(
        $TurmasTable.$converterturTurno.toSql(turTurno.value),
      );
    }
    if (turAno.present) {
      map['tur_ano'] = Variable<int>(
        $TurmasTable.$converterturAno.toSql(turAno.value),
      );
    }
    if (turNumero.present) {
      map['tur_numero'] = Variable<int>(turNumero.value);
    }
    if (turEscola.present) {
      map['tur_escola'] = Variable<int>(turEscola.value);
    }
    if (turProfessorId.present) {
      map['tur_professor_id'] = Variable<int>(turProfessorId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TurmasCompanion(')
          ..write('turId: $turId, ')
          ..write('turTurno: $turTurno, ')
          ..write('turAno: $turAno, ')
          ..write('turNumero: $turNumero, ')
          ..write('turEscola: $turEscola, ')
          ..write('turProfessorId: $turProfessorId')
          ..write(')'))
        .toString();
  }
}

class $AlunosTable extends Alunos with TableInfo<$AlunosTable, Aluno> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlunosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _aluIdMeta = const VerificationMeta('aluId');
  @override
  late final GeneratedColumn<int> aluId = GeneratedColumn<int>(
    'alu_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _aluNomeMeta = const VerificationMeta(
    'aluNome',
  );
  @override
  late final GeneratedColumn<String> aluNome = GeneratedColumn<String>(
    'alu_nome',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aluCFPMeta = const VerificationMeta('aluCFP');
  @override
  late final GeneratedColumn<String> aluCFP = GeneratedColumn<String>(
    'alu_c_f_p',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 14,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aluDtNascimentoMeta = const VerificationMeta(
    'aluDtNascimento',
  );
  @override
  late final GeneratedColumn<DateTime> aluDtNascimento =
      GeneratedColumn<DateTime>(
        'alu_dt_nascimento',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _aluEscolaIdMeta = const VerificationMeta(
    'aluEscolaId',
  );
  @override
  late final GeneratedColumn<int> aluEscolaId = GeneratedColumn<int>(
    'alu_escola_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES escolas (esc_id)',
    ),
  );
  static const VerificationMeta _aluTurmaIdMeta = const VerificationMeta(
    'aluTurmaId',
  );
  @override
  late final GeneratedColumn<int> aluTurmaId = GeneratedColumn<int>(
    'alu_turma_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES turmas (tur_id)',
    ),
  );
  static const VerificationMeta _aluCuidadorIdMeta = const VerificationMeta(
    'aluCuidadorId',
  );
  @override
  late final GeneratedColumn<int> aluCuidadorId = GeneratedColumn<int>(
    'alu_cuidador_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (usu_id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    aluId,
    aluNome,
    aluCFP,
    aluDtNascimento,
    aluEscolaId,
    aluTurmaId,
    aluCuidadorId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alunos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Aluno> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('alu_id')) {
      context.handle(
        _aluIdMeta,
        aluId.isAcceptableOrUnknown(data['alu_id']!, _aluIdMeta),
      );
    }
    if (data.containsKey('alu_nome')) {
      context.handle(
        _aluNomeMeta,
        aluNome.isAcceptableOrUnknown(data['alu_nome']!, _aluNomeMeta),
      );
    } else if (isInserting) {
      context.missing(_aluNomeMeta);
    }
    if (data.containsKey('alu_c_f_p')) {
      context.handle(
        _aluCFPMeta,
        aluCFP.isAcceptableOrUnknown(data['alu_c_f_p']!, _aluCFPMeta),
      );
    } else if (isInserting) {
      context.missing(_aluCFPMeta);
    }
    if (data.containsKey('alu_dt_nascimento')) {
      context.handle(
        _aluDtNascimentoMeta,
        aluDtNascimento.isAcceptableOrUnknown(
          data['alu_dt_nascimento']!,
          _aluDtNascimentoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_aluDtNascimentoMeta);
    }
    if (data.containsKey('alu_escola_id')) {
      context.handle(
        _aluEscolaIdMeta,
        aluEscolaId.isAcceptableOrUnknown(
          data['alu_escola_id']!,
          _aluEscolaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_aluEscolaIdMeta);
    }
    if (data.containsKey('alu_turma_id')) {
      context.handle(
        _aluTurmaIdMeta,
        aluTurmaId.isAcceptableOrUnknown(
          data['alu_turma_id']!,
          _aluTurmaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_aluTurmaIdMeta);
    }
    if (data.containsKey('alu_cuidador_id')) {
      context.handle(
        _aluCuidadorIdMeta,
        aluCuidadorId.isAcceptableOrUnknown(
          data['alu_cuidador_id']!,
          _aluCuidadorIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_aluCuidadorIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {aluId};
  @override
  Aluno map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Aluno(
      aluId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alu_id'],
      )!,
      aluNome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alu_nome'],
      )!,
      aluCFP: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alu_c_f_p'],
      )!,
      aluDtNascimento: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}alu_dt_nascimento'],
      )!,
      aluEscolaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alu_escola_id'],
      )!,
      aluTurmaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alu_turma_id'],
      )!,
      aluCuidadorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alu_cuidador_id'],
      )!,
    );
  }

  @override
  $AlunosTable createAlias(String alias) {
    return $AlunosTable(attachedDatabase, alias);
  }
}

class Aluno extends DataClass implements Insertable<Aluno> {
  final int aluId;
  final String aluNome;
  final String aluCFP;
  final DateTime aluDtNascimento;
  final int aluEscolaId;
  final int aluTurmaId;
  final int aluCuidadorId;
  const Aluno({
    required this.aluId,
    required this.aluNome,
    required this.aluCFP,
    required this.aluDtNascimento,
    required this.aluEscolaId,
    required this.aluTurmaId,
    required this.aluCuidadorId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['alu_id'] = Variable<int>(aluId);
    map['alu_nome'] = Variable<String>(aluNome);
    map['alu_c_f_p'] = Variable<String>(aluCFP);
    map['alu_dt_nascimento'] = Variable<DateTime>(aluDtNascimento);
    map['alu_escola_id'] = Variable<int>(aluEscolaId);
    map['alu_turma_id'] = Variable<int>(aluTurmaId);
    map['alu_cuidador_id'] = Variable<int>(aluCuidadorId);
    return map;
  }

  AlunosCompanion toCompanion(bool nullToAbsent) {
    return AlunosCompanion(
      aluId: Value(aluId),
      aluNome: Value(aluNome),
      aluCFP: Value(aluCFP),
      aluDtNascimento: Value(aluDtNascimento),
      aluEscolaId: Value(aluEscolaId),
      aluTurmaId: Value(aluTurmaId),
      aluCuidadorId: Value(aluCuidadorId),
    );
  }

  factory Aluno.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Aluno(
      aluId: serializer.fromJson<int>(json['aluId']),
      aluNome: serializer.fromJson<String>(json['aluNome']),
      aluCFP: serializer.fromJson<String>(json['aluCFP']),
      aluDtNascimento: serializer.fromJson<DateTime>(json['aluDtNascimento']),
      aluEscolaId: serializer.fromJson<int>(json['aluEscolaId']),
      aluTurmaId: serializer.fromJson<int>(json['aluTurmaId']),
      aluCuidadorId: serializer.fromJson<int>(json['aluCuidadorId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'aluId': serializer.toJson<int>(aluId),
      'aluNome': serializer.toJson<String>(aluNome),
      'aluCFP': serializer.toJson<String>(aluCFP),
      'aluDtNascimento': serializer.toJson<DateTime>(aluDtNascimento),
      'aluEscolaId': serializer.toJson<int>(aluEscolaId),
      'aluTurmaId': serializer.toJson<int>(aluTurmaId),
      'aluCuidadorId': serializer.toJson<int>(aluCuidadorId),
    };
  }

  Aluno copyWith({
    int? aluId,
    String? aluNome,
    String? aluCFP,
    DateTime? aluDtNascimento,
    int? aluEscolaId,
    int? aluTurmaId,
    int? aluCuidadorId,
  }) => Aluno(
    aluId: aluId ?? this.aluId,
    aluNome: aluNome ?? this.aluNome,
    aluCFP: aluCFP ?? this.aluCFP,
    aluDtNascimento: aluDtNascimento ?? this.aluDtNascimento,
    aluEscolaId: aluEscolaId ?? this.aluEscolaId,
    aluTurmaId: aluTurmaId ?? this.aluTurmaId,
    aluCuidadorId: aluCuidadorId ?? this.aluCuidadorId,
  );
  Aluno copyWithCompanion(AlunosCompanion data) {
    return Aluno(
      aluId: data.aluId.present ? data.aluId.value : this.aluId,
      aluNome: data.aluNome.present ? data.aluNome.value : this.aluNome,
      aluCFP: data.aluCFP.present ? data.aluCFP.value : this.aluCFP,
      aluDtNascimento: data.aluDtNascimento.present
          ? data.aluDtNascimento.value
          : this.aluDtNascimento,
      aluEscolaId: data.aluEscolaId.present
          ? data.aluEscolaId.value
          : this.aluEscolaId,
      aluTurmaId: data.aluTurmaId.present
          ? data.aluTurmaId.value
          : this.aluTurmaId,
      aluCuidadorId: data.aluCuidadorId.present
          ? data.aluCuidadorId.value
          : this.aluCuidadorId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Aluno(')
          ..write('aluId: $aluId, ')
          ..write('aluNome: $aluNome, ')
          ..write('aluCFP: $aluCFP, ')
          ..write('aluDtNascimento: $aluDtNascimento, ')
          ..write('aluEscolaId: $aluEscolaId, ')
          ..write('aluTurmaId: $aluTurmaId, ')
          ..write('aluCuidadorId: $aluCuidadorId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    aluId,
    aluNome,
    aluCFP,
    aluDtNascimento,
    aluEscolaId,
    aluTurmaId,
    aluCuidadorId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Aluno &&
          other.aluId == this.aluId &&
          other.aluNome == this.aluNome &&
          other.aluCFP == this.aluCFP &&
          other.aluDtNascimento == this.aluDtNascimento &&
          other.aluEscolaId == this.aluEscolaId &&
          other.aluTurmaId == this.aluTurmaId &&
          other.aluCuidadorId == this.aluCuidadorId);
}

class AlunosCompanion extends UpdateCompanion<Aluno> {
  final Value<int> aluId;
  final Value<String> aluNome;
  final Value<String> aluCFP;
  final Value<DateTime> aluDtNascimento;
  final Value<int> aluEscolaId;
  final Value<int> aluTurmaId;
  final Value<int> aluCuidadorId;
  const AlunosCompanion({
    this.aluId = const Value.absent(),
    this.aluNome = const Value.absent(),
    this.aluCFP = const Value.absent(),
    this.aluDtNascimento = const Value.absent(),
    this.aluEscolaId = const Value.absent(),
    this.aluTurmaId = const Value.absent(),
    this.aluCuidadorId = const Value.absent(),
  });
  AlunosCompanion.insert({
    this.aluId = const Value.absent(),
    required String aluNome,
    required String aluCFP,
    required DateTime aluDtNascimento,
    required int aluEscolaId,
    required int aluTurmaId,
    required int aluCuidadorId,
  }) : aluNome = Value(aluNome),
       aluCFP = Value(aluCFP),
       aluDtNascimento = Value(aluDtNascimento),
       aluEscolaId = Value(aluEscolaId),
       aluTurmaId = Value(aluTurmaId),
       aluCuidadorId = Value(aluCuidadorId);
  static Insertable<Aluno> custom({
    Expression<int>? aluId,
    Expression<String>? aluNome,
    Expression<String>? aluCFP,
    Expression<DateTime>? aluDtNascimento,
    Expression<int>? aluEscolaId,
    Expression<int>? aluTurmaId,
    Expression<int>? aluCuidadorId,
  }) {
    return RawValuesInsertable({
      if (aluId != null) 'alu_id': aluId,
      if (aluNome != null) 'alu_nome': aluNome,
      if (aluCFP != null) 'alu_c_f_p': aluCFP,
      if (aluDtNascimento != null) 'alu_dt_nascimento': aluDtNascimento,
      if (aluEscolaId != null) 'alu_escola_id': aluEscolaId,
      if (aluTurmaId != null) 'alu_turma_id': aluTurmaId,
      if (aluCuidadorId != null) 'alu_cuidador_id': aluCuidadorId,
    });
  }

  AlunosCompanion copyWith({
    Value<int>? aluId,
    Value<String>? aluNome,
    Value<String>? aluCFP,
    Value<DateTime>? aluDtNascimento,
    Value<int>? aluEscolaId,
    Value<int>? aluTurmaId,
    Value<int>? aluCuidadorId,
  }) {
    return AlunosCompanion(
      aluId: aluId ?? this.aluId,
      aluNome: aluNome ?? this.aluNome,
      aluCFP: aluCFP ?? this.aluCFP,
      aluDtNascimento: aluDtNascimento ?? this.aluDtNascimento,
      aluEscolaId: aluEscolaId ?? this.aluEscolaId,
      aluTurmaId: aluTurmaId ?? this.aluTurmaId,
      aluCuidadorId: aluCuidadorId ?? this.aluCuidadorId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (aluId.present) {
      map['alu_id'] = Variable<int>(aluId.value);
    }
    if (aluNome.present) {
      map['alu_nome'] = Variable<String>(aluNome.value);
    }
    if (aluCFP.present) {
      map['alu_c_f_p'] = Variable<String>(aluCFP.value);
    }
    if (aluDtNascimento.present) {
      map['alu_dt_nascimento'] = Variable<DateTime>(aluDtNascimento.value);
    }
    if (aluEscolaId.present) {
      map['alu_escola_id'] = Variable<int>(aluEscolaId.value);
    }
    if (aluTurmaId.present) {
      map['alu_turma_id'] = Variable<int>(aluTurmaId.value);
    }
    if (aluCuidadorId.present) {
      map['alu_cuidador_id'] = Variable<int>(aluCuidadorId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlunosCompanion(')
          ..write('aluId: $aluId, ')
          ..write('aluNome: $aluNome, ')
          ..write('aluCFP: $aluCFP, ')
          ..write('aluDtNascimento: $aluDtNascimento, ')
          ..write('aluEscolaId: $aluEscolaId, ')
          ..write('aluTurmaId: $aluTurmaId, ')
          ..write('aluCuidadorId: $aluCuidadorId')
          ..write(')'))
        .toString();
  }
}

class $RegistrosTable extends Registros
    with TableInfo<$RegistrosTable, Registro> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegistrosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _regIdMeta = const VerificationMeta('regId');
  @override
  late final GeneratedColumn<int> regId = GeneratedColumn<int>(
    'reg_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _regDataMeta = const VerificationMeta(
    'regData',
  );
  @override
  late final GeneratedColumn<DateTime> regData = GeneratedColumn<DateTime>(
    'reg_data',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Alimentacao, String>
  regAlimentacao = GeneratedColumn<String>(
    'reg_alimentacao',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Alimentacao>($RegistrosTable.$converterregAlimentacao);
  @override
  late final GeneratedColumnWithTypeConverter<Atividades, String> regAtividade =
      GeneratedColumn<String>(
        'reg_atividade',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Atividades>($RegistrosTable.$converterregAtividade);
  @override
  late final GeneratedColumnWithTypeConverter<Comportamento, String>
  regComportamento = GeneratedColumn<String>(
    'reg_comportamento',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Comportamento>($RegistrosTable.$converterregComportamento);
  static const VerificationMeta _regObservacaoMeta = const VerificationMeta(
    'regObservacao',
  );
  @override
  late final GeneratedColumn<String> regObservacao = GeneratedColumn<String>(
    'reg_observacao',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regAlunoMeta = const VerificationMeta(
    'regAluno',
  );
  @override
  late final GeneratedColumn<int> regAluno = GeneratedColumn<int>(
    'reg_aluno',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES alunos (alu_id)',
    ),
  );
  static const VerificationMeta _regUsuarioMeta = const VerificationMeta(
    'regUsuario',
  );
  @override
  late final GeneratedColumn<int> regUsuario = GeneratedColumn<int>(
    'reg_usuario',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (usu_id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    regId,
    regData,
    regAlimentacao,
    regAtividade,
    regComportamento,
    regObservacao,
    regAluno,
    regUsuario,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'registros';
  @override
  VerificationContext validateIntegrity(
    Insertable<Registro> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('reg_id')) {
      context.handle(
        _regIdMeta,
        regId.isAcceptableOrUnknown(data['reg_id']!, _regIdMeta),
      );
    }
    if (data.containsKey('reg_data')) {
      context.handle(
        _regDataMeta,
        regData.isAcceptableOrUnknown(data['reg_data']!, _regDataMeta),
      );
    } else if (isInserting) {
      context.missing(_regDataMeta);
    }
    if (data.containsKey('reg_observacao')) {
      context.handle(
        _regObservacaoMeta,
        regObservacao.isAcceptableOrUnknown(
          data['reg_observacao']!,
          _regObservacaoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_regObservacaoMeta);
    }
    if (data.containsKey('reg_aluno')) {
      context.handle(
        _regAlunoMeta,
        regAluno.isAcceptableOrUnknown(data['reg_aluno']!, _regAlunoMeta),
      );
    } else if (isInserting) {
      context.missing(_regAlunoMeta);
    }
    if (data.containsKey('reg_usuario')) {
      context.handle(
        _regUsuarioMeta,
        regUsuario.isAcceptableOrUnknown(data['reg_usuario']!, _regUsuarioMeta),
      );
    } else if (isInserting) {
      context.missing(_regUsuarioMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {regId};
  @override
  Registro map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Registro(
      regId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reg_id'],
      )!,
      regData: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reg_data'],
      )!,
      regAlimentacao: $RegistrosTable.$converterregAlimentacao.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}reg_alimentacao'],
        )!,
      ),
      regAtividade: $RegistrosTable.$converterregAtividade.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}reg_atividade'],
        )!,
      ),
      regComportamento: $RegistrosTable.$converterregComportamento.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}reg_comportamento'],
        )!,
      ),
      regObservacao: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reg_observacao'],
      )!,
      regAluno: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reg_aluno'],
      )!,
      regUsuario: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reg_usuario'],
      )!,
    );
  }

  @override
  $RegistrosTable createAlias(String alias) {
    return $RegistrosTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Alimentacao, String, String>
  $converterregAlimentacao = const EnumNameConverter<Alimentacao>(
    Alimentacao.values,
  );
  static JsonTypeConverter2<Atividades, String, String> $converterregAtividade =
      const EnumNameConverter<Atividades>(Atividades.values);
  static JsonTypeConverter2<Comportamento, String, String>
  $converterregComportamento = const EnumNameConverter<Comportamento>(
    Comportamento.values,
  );
}

class Registro extends DataClass implements Insertable<Registro> {
  final int regId;
  final DateTime regData;
  final Alimentacao regAlimentacao;
  final Atividades regAtividade;
  final Comportamento regComportamento;
  final String regObservacao;
  final int regAluno;
  final int regUsuario;
  const Registro({
    required this.regId,
    required this.regData,
    required this.regAlimentacao,
    required this.regAtividade,
    required this.regComportamento,
    required this.regObservacao,
    required this.regAluno,
    required this.regUsuario,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['reg_id'] = Variable<int>(regId);
    map['reg_data'] = Variable<DateTime>(regData);
    {
      map['reg_alimentacao'] = Variable<String>(
        $RegistrosTable.$converterregAlimentacao.toSql(regAlimentacao),
      );
    }
    {
      map['reg_atividade'] = Variable<String>(
        $RegistrosTable.$converterregAtividade.toSql(regAtividade),
      );
    }
    {
      map['reg_comportamento'] = Variable<String>(
        $RegistrosTable.$converterregComportamento.toSql(regComportamento),
      );
    }
    map['reg_observacao'] = Variable<String>(regObservacao);
    map['reg_aluno'] = Variable<int>(regAluno);
    map['reg_usuario'] = Variable<int>(regUsuario);
    return map;
  }

  RegistrosCompanion toCompanion(bool nullToAbsent) {
    return RegistrosCompanion(
      regId: Value(regId),
      regData: Value(regData),
      regAlimentacao: Value(regAlimentacao),
      regAtividade: Value(regAtividade),
      regComportamento: Value(regComportamento),
      regObservacao: Value(regObservacao),
      regAluno: Value(regAluno),
      regUsuario: Value(regUsuario),
    );
  }

  factory Registro.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Registro(
      regId: serializer.fromJson<int>(json['regId']),
      regData: serializer.fromJson<DateTime>(json['regData']),
      regAlimentacao: $RegistrosTable.$converterregAlimentacao.fromJson(
        serializer.fromJson<String>(json['regAlimentacao']),
      ),
      regAtividade: $RegistrosTable.$converterregAtividade.fromJson(
        serializer.fromJson<String>(json['regAtividade']),
      ),
      regComportamento: $RegistrosTable.$converterregComportamento.fromJson(
        serializer.fromJson<String>(json['regComportamento']),
      ),
      regObservacao: serializer.fromJson<String>(json['regObservacao']),
      regAluno: serializer.fromJson<int>(json['regAluno']),
      regUsuario: serializer.fromJson<int>(json['regUsuario']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'regId': serializer.toJson<int>(regId),
      'regData': serializer.toJson<DateTime>(regData),
      'regAlimentacao': serializer.toJson<String>(
        $RegistrosTable.$converterregAlimentacao.toJson(regAlimentacao),
      ),
      'regAtividade': serializer.toJson<String>(
        $RegistrosTable.$converterregAtividade.toJson(regAtividade),
      ),
      'regComportamento': serializer.toJson<String>(
        $RegistrosTable.$converterregComportamento.toJson(regComportamento),
      ),
      'regObservacao': serializer.toJson<String>(regObservacao),
      'regAluno': serializer.toJson<int>(regAluno),
      'regUsuario': serializer.toJson<int>(regUsuario),
    };
  }

  Registro copyWith({
    int? regId,
    DateTime? regData,
    Alimentacao? regAlimentacao,
    Atividades? regAtividade,
    Comportamento? regComportamento,
    String? regObservacao,
    int? regAluno,
    int? regUsuario,
  }) => Registro(
    regId: regId ?? this.regId,
    regData: regData ?? this.regData,
    regAlimentacao: regAlimentacao ?? this.regAlimentacao,
    regAtividade: regAtividade ?? this.regAtividade,
    regComportamento: regComportamento ?? this.regComportamento,
    regObservacao: regObservacao ?? this.regObservacao,
    regAluno: regAluno ?? this.regAluno,
    regUsuario: regUsuario ?? this.regUsuario,
  );
  Registro copyWithCompanion(RegistrosCompanion data) {
    return Registro(
      regId: data.regId.present ? data.regId.value : this.regId,
      regData: data.regData.present ? data.regData.value : this.regData,
      regAlimentacao: data.regAlimentacao.present
          ? data.regAlimentacao.value
          : this.regAlimentacao,
      regAtividade: data.regAtividade.present
          ? data.regAtividade.value
          : this.regAtividade,
      regComportamento: data.regComportamento.present
          ? data.regComportamento.value
          : this.regComportamento,
      regObservacao: data.regObservacao.present
          ? data.regObservacao.value
          : this.regObservacao,
      regAluno: data.regAluno.present ? data.regAluno.value : this.regAluno,
      regUsuario: data.regUsuario.present
          ? data.regUsuario.value
          : this.regUsuario,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Registro(')
          ..write('regId: $regId, ')
          ..write('regData: $regData, ')
          ..write('regAlimentacao: $regAlimentacao, ')
          ..write('regAtividade: $regAtividade, ')
          ..write('regComportamento: $regComportamento, ')
          ..write('regObservacao: $regObservacao, ')
          ..write('regAluno: $regAluno, ')
          ..write('regUsuario: $regUsuario')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    regId,
    regData,
    regAlimentacao,
    regAtividade,
    regComportamento,
    regObservacao,
    regAluno,
    regUsuario,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Registro &&
          other.regId == this.regId &&
          other.regData == this.regData &&
          other.regAlimentacao == this.regAlimentacao &&
          other.regAtividade == this.regAtividade &&
          other.regComportamento == this.regComportamento &&
          other.regObservacao == this.regObservacao &&
          other.regAluno == this.regAluno &&
          other.regUsuario == this.regUsuario);
}

class RegistrosCompanion extends UpdateCompanion<Registro> {
  final Value<int> regId;
  final Value<DateTime> regData;
  final Value<Alimentacao> regAlimentacao;
  final Value<Atividades> regAtividade;
  final Value<Comportamento> regComportamento;
  final Value<String> regObservacao;
  final Value<int> regAluno;
  final Value<int> regUsuario;
  const RegistrosCompanion({
    this.regId = const Value.absent(),
    this.regData = const Value.absent(),
    this.regAlimentacao = const Value.absent(),
    this.regAtividade = const Value.absent(),
    this.regComportamento = const Value.absent(),
    this.regObservacao = const Value.absent(),
    this.regAluno = const Value.absent(),
    this.regUsuario = const Value.absent(),
  });
  RegistrosCompanion.insert({
    this.regId = const Value.absent(),
    required DateTime regData,
    required Alimentacao regAlimentacao,
    required Atividades regAtividade,
    required Comportamento regComportamento,
    required String regObservacao,
    required int regAluno,
    required int regUsuario,
  }) : regData = Value(regData),
       regAlimentacao = Value(regAlimentacao),
       regAtividade = Value(regAtividade),
       regComportamento = Value(regComportamento),
       regObservacao = Value(regObservacao),
       regAluno = Value(regAluno),
       regUsuario = Value(regUsuario);
  static Insertable<Registro> custom({
    Expression<int>? regId,
    Expression<DateTime>? regData,
    Expression<String>? regAlimentacao,
    Expression<String>? regAtividade,
    Expression<String>? regComportamento,
    Expression<String>? regObservacao,
    Expression<int>? regAluno,
    Expression<int>? regUsuario,
  }) {
    return RawValuesInsertable({
      if (regId != null) 'reg_id': regId,
      if (regData != null) 'reg_data': regData,
      if (regAlimentacao != null) 'reg_alimentacao': regAlimentacao,
      if (regAtividade != null) 'reg_atividade': regAtividade,
      if (regComportamento != null) 'reg_comportamento': regComportamento,
      if (regObservacao != null) 'reg_observacao': regObservacao,
      if (regAluno != null) 'reg_aluno': regAluno,
      if (regUsuario != null) 'reg_usuario': regUsuario,
    });
  }

  RegistrosCompanion copyWith({
    Value<int>? regId,
    Value<DateTime>? regData,
    Value<Alimentacao>? regAlimentacao,
    Value<Atividades>? regAtividade,
    Value<Comportamento>? regComportamento,
    Value<String>? regObservacao,
    Value<int>? regAluno,
    Value<int>? regUsuario,
  }) {
    return RegistrosCompanion(
      regId: regId ?? this.regId,
      regData: regData ?? this.regData,
      regAlimentacao: regAlimentacao ?? this.regAlimentacao,
      regAtividade: regAtividade ?? this.regAtividade,
      regComportamento: regComportamento ?? this.regComportamento,
      regObservacao: regObservacao ?? this.regObservacao,
      regAluno: regAluno ?? this.regAluno,
      regUsuario: regUsuario ?? this.regUsuario,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (regId.present) {
      map['reg_id'] = Variable<int>(regId.value);
    }
    if (regData.present) {
      map['reg_data'] = Variable<DateTime>(regData.value);
    }
    if (regAlimentacao.present) {
      map['reg_alimentacao'] = Variable<String>(
        $RegistrosTable.$converterregAlimentacao.toSql(regAlimentacao.value),
      );
    }
    if (regAtividade.present) {
      map['reg_atividade'] = Variable<String>(
        $RegistrosTable.$converterregAtividade.toSql(regAtividade.value),
      );
    }
    if (regComportamento.present) {
      map['reg_comportamento'] = Variable<String>(
        $RegistrosTable.$converterregComportamento.toSql(
          regComportamento.value,
        ),
      );
    }
    if (regObservacao.present) {
      map['reg_observacao'] = Variable<String>(regObservacao.value);
    }
    if (regAluno.present) {
      map['reg_aluno'] = Variable<int>(regAluno.value);
    }
    if (regUsuario.present) {
      map['reg_usuario'] = Variable<int>(regUsuario.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegistrosCompanion(')
          ..write('regId: $regId, ')
          ..write('regData: $regData, ')
          ..write('regAlimentacao: $regAlimentacao, ')
          ..write('regAtividade: $regAtividade, ')
          ..write('regComportamento: $regComportamento, ')
          ..write('regObservacao: $regObservacao, ')
          ..write('regAluno: $regAluno, ')
          ..write('regUsuario: $regUsuario')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EscolasTable escolas = $EscolasTable(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $TurmasTable turmas = $TurmasTable(this);
  late final $AlunosTable alunos = $AlunosTable(this);
  late final $RegistrosTable registros = $RegistrosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    escolas,
    usuarios,
    turmas,
    alunos,
    registros,
  ];
}

typedef $$EscolasTableCreateCompanionBuilder =
    EscolasCompanion Function({
      Value<int> escId,
      required String escNome,
      required String escCNPJ,
      required String escEndereco,
      required String escBairro,
      required String escCidade,
      required String escCEP,
    });
typedef $$EscolasTableUpdateCompanionBuilder =
    EscolasCompanion Function({
      Value<int> escId,
      Value<String> escNome,
      Value<String> escCNPJ,
      Value<String> escEndereco,
      Value<String> escBairro,
      Value<String> escCidade,
      Value<String> escCEP,
    });

final class $$EscolasTableReferences
    extends BaseReferences<_$AppDatabase, $EscolasTable, Escola> {
  $$EscolasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UsuariosTable, List<Usuario>> _usuariosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.usuarios,
    aliasName: $_aliasNameGenerator(db.escolas.escId, db.usuarios.usuEscola),
  );

  $$UsuariosTableProcessedTableManager get usuariosRefs {
    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.usuEscola.escId.sqlEquals($_itemColumn<int>('esc_id')!));

    final cache = $_typedResult.readTableOrNull(_usuariosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TurmasTable, List<Turma>> _turmasRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.turmas,
    aliasName: $_aliasNameGenerator(db.escolas.escId, db.turmas.turEscola),
  );

  $$TurmasTableProcessedTableManager get turmasRefs {
    final manager = $$TurmasTableTableManager(
      $_db,
      $_db.turmas,
    ).filter((f) => f.turEscola.escId.sqlEquals($_itemColumn<int>('esc_id')!));

    final cache = $_typedResult.readTableOrNull(_turmasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AlunosTable, List<Aluno>> _alunosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.alunos,
    aliasName: $_aliasNameGenerator(db.escolas.escId, db.alunos.aluEscolaId),
  );

  $$AlunosTableProcessedTableManager get alunosRefs {
    final manager = $$AlunosTableTableManager($_db, $_db.alunos).filter(
      (f) => f.aluEscolaId.escId.sqlEquals($_itemColumn<int>('esc_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_alunosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EscolasTableFilterComposer
    extends Composer<_$AppDatabase, $EscolasTable> {
  $$EscolasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get escId => $composableBuilder(
    column: $table.escId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get escNome => $composableBuilder(
    column: $table.escNome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get escCNPJ => $composableBuilder(
    column: $table.escCNPJ,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get escEndereco => $composableBuilder(
    column: $table.escEndereco,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get escBairro => $composableBuilder(
    column: $table.escBairro,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get escCidade => $composableBuilder(
    column: $table.escCidade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get escCEP => $composableBuilder(
    column: $table.escCEP,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> usuariosRefs(
    Expression<bool> Function($$UsuariosTableFilterComposer f) f,
  ) {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.escId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.usuEscola,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> turmasRefs(
    Expression<bool> Function($$TurmasTableFilterComposer f) f,
  ) {
    final $$TurmasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.escId,
      referencedTable: $db.turmas,
      getReferencedColumn: (t) => t.turEscola,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TurmasTableFilterComposer(
            $db: $db,
            $table: $db.turmas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> alunosRefs(
    Expression<bool> Function($$AlunosTableFilterComposer f) f,
  ) {
    final $$AlunosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.escId,
      referencedTable: $db.alunos,
      getReferencedColumn: (t) => t.aluEscolaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlunosTableFilterComposer(
            $db: $db,
            $table: $db.alunos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EscolasTableOrderingComposer
    extends Composer<_$AppDatabase, $EscolasTable> {
  $$EscolasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get escId => $composableBuilder(
    column: $table.escId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get escNome => $composableBuilder(
    column: $table.escNome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get escCNPJ => $composableBuilder(
    column: $table.escCNPJ,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get escEndereco => $composableBuilder(
    column: $table.escEndereco,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get escBairro => $composableBuilder(
    column: $table.escBairro,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get escCidade => $composableBuilder(
    column: $table.escCidade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get escCEP => $composableBuilder(
    column: $table.escCEP,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EscolasTableAnnotationComposer
    extends Composer<_$AppDatabase, $EscolasTable> {
  $$EscolasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get escId =>
      $composableBuilder(column: $table.escId, builder: (column) => column);

  GeneratedColumn<String> get escNome =>
      $composableBuilder(column: $table.escNome, builder: (column) => column);

  GeneratedColumn<String> get escCNPJ =>
      $composableBuilder(column: $table.escCNPJ, builder: (column) => column);

  GeneratedColumn<String> get escEndereco => $composableBuilder(
    column: $table.escEndereco,
    builder: (column) => column,
  );

  GeneratedColumn<String> get escBairro =>
      $composableBuilder(column: $table.escBairro, builder: (column) => column);

  GeneratedColumn<String> get escCidade =>
      $composableBuilder(column: $table.escCidade, builder: (column) => column);

  GeneratedColumn<String> get escCEP =>
      $composableBuilder(column: $table.escCEP, builder: (column) => column);

  Expression<T> usuariosRefs<T extends Object>(
    Expression<T> Function($$UsuariosTableAnnotationComposer a) f,
  ) {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.escId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.usuEscola,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> turmasRefs<T extends Object>(
    Expression<T> Function($$TurmasTableAnnotationComposer a) f,
  ) {
    final $$TurmasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.escId,
      referencedTable: $db.turmas,
      getReferencedColumn: (t) => t.turEscola,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TurmasTableAnnotationComposer(
            $db: $db,
            $table: $db.turmas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> alunosRefs<T extends Object>(
    Expression<T> Function($$AlunosTableAnnotationComposer a) f,
  ) {
    final $$AlunosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.escId,
      referencedTable: $db.alunos,
      getReferencedColumn: (t) => t.aluEscolaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlunosTableAnnotationComposer(
            $db: $db,
            $table: $db.alunos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EscolasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EscolasTable,
          Escola,
          $$EscolasTableFilterComposer,
          $$EscolasTableOrderingComposer,
          $$EscolasTableAnnotationComposer,
          $$EscolasTableCreateCompanionBuilder,
          $$EscolasTableUpdateCompanionBuilder,
          (Escola, $$EscolasTableReferences),
          Escola,
          PrefetchHooks Function({
            bool usuariosRefs,
            bool turmasRefs,
            bool alunosRefs,
          })
        > {
  $$EscolasTableTableManager(_$AppDatabase db, $EscolasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EscolasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EscolasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EscolasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> escId = const Value.absent(),
                Value<String> escNome = const Value.absent(),
                Value<String> escCNPJ = const Value.absent(),
                Value<String> escEndereco = const Value.absent(),
                Value<String> escBairro = const Value.absent(),
                Value<String> escCidade = const Value.absent(),
                Value<String> escCEP = const Value.absent(),
              }) => EscolasCompanion(
                escId: escId,
                escNome: escNome,
                escCNPJ: escCNPJ,
                escEndereco: escEndereco,
                escBairro: escBairro,
                escCidade: escCidade,
                escCEP: escCEP,
              ),
          createCompanionCallback:
              ({
                Value<int> escId = const Value.absent(),
                required String escNome,
                required String escCNPJ,
                required String escEndereco,
                required String escBairro,
                required String escCidade,
                required String escCEP,
              }) => EscolasCompanion.insert(
                escId: escId,
                escNome: escNome,
                escCNPJ: escCNPJ,
                escEndereco: escEndereco,
                escBairro: escBairro,
                escCidade: escCidade,
                escCEP: escCEP,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EscolasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({usuariosRefs = false, turmasRefs = false, alunosRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (usuariosRefs) db.usuarios,
                    if (turmasRefs) db.turmas,
                    if (alunosRefs) db.alunos,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (usuariosRefs)
                        await $_getPrefetchedData<
                          Escola,
                          $EscolasTable,
                          Usuario
                        >(
                          currentTable: table,
                          referencedTable: $$EscolasTableReferences
                              ._usuariosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EscolasTableReferences(
                                db,
                                table,
                                p0,
                              ).usuariosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.usuEscola == item.escId,
                              ),
                          typedResults: items,
                        ),
                      if (turmasRefs)
                        await $_getPrefetchedData<Escola, $EscolasTable, Turma>(
                          currentTable: table,
                          referencedTable: $$EscolasTableReferences
                              ._turmasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EscolasTableReferences(
                                db,
                                table,
                                p0,
                              ).turmasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.turEscola == item.escId,
                              ),
                          typedResults: items,
                        ),
                      if (alunosRefs)
                        await $_getPrefetchedData<Escola, $EscolasTable, Aluno>(
                          currentTable: table,
                          referencedTable: $$EscolasTableReferences
                              ._alunosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EscolasTableReferences(
                                db,
                                table,
                                p0,
                              ).alunosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.aluEscolaId == item.escId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EscolasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EscolasTable,
      Escola,
      $$EscolasTableFilterComposer,
      $$EscolasTableOrderingComposer,
      $$EscolasTableAnnotationComposer,
      $$EscolasTableCreateCompanionBuilder,
      $$EscolasTableUpdateCompanionBuilder,
      (Escola, $$EscolasTableReferences),
      Escola,
      PrefetchHooks Function({
        bool usuariosRefs,
        bool turmasRefs,
        bool alunosRefs,
      })
    >;
typedef $$UsuariosTableCreateCompanionBuilder =
    UsuariosCompanion Function({
      Value<int> usuId,
      required String usuNome,
      required String usuCPF,
      required DateTime usuDtNascimento,
      required String usuEmail,
      required Cargos usuCargo,
      required String usuSenha,
      required int usuEscola,
    });
typedef $$UsuariosTableUpdateCompanionBuilder =
    UsuariosCompanion Function({
      Value<int> usuId,
      Value<String> usuNome,
      Value<String> usuCPF,
      Value<DateTime> usuDtNascimento,
      Value<String> usuEmail,
      Value<Cargos> usuCargo,
      Value<String> usuSenha,
      Value<int> usuEscola,
    });

final class $$UsuariosTableReferences
    extends BaseReferences<_$AppDatabase, $UsuariosTable, Usuario> {
  $$UsuariosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EscolasTable _usuEscolaTable(_$AppDatabase db) =>
      db.escolas.createAlias(
        $_aliasNameGenerator(db.usuarios.usuEscola, db.escolas.escId),
      );

  $$EscolasTableProcessedTableManager get usuEscola {
    final $_column = $_itemColumn<int>('usu_escola')!;

    final manager = $$EscolasTableTableManager(
      $_db,
      $_db.escolas,
    ).filter((f) => f.escId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuEscolaTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TurmasTable, List<Turma>> _turmasRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.turmas,
    aliasName: $_aliasNameGenerator(
      db.usuarios.usuId,
      db.turmas.turProfessorId,
    ),
  );

  $$TurmasTableProcessedTableManager get turmasRefs {
    final manager = $$TurmasTableTableManager($_db, $_db.turmas).filter(
      (f) => f.turProfessorId.usuId.sqlEquals($_itemColumn<int>('usu_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_turmasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AlunosTable, List<Aluno>> _alunosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.alunos,
    aliasName: $_aliasNameGenerator(db.usuarios.usuId, db.alunos.aluCuidadorId),
  );

  $$AlunosTableProcessedTableManager get alunosRefs {
    final manager = $$AlunosTableTableManager($_db, $_db.alunos).filter(
      (f) => f.aluCuidadorId.usuId.sqlEquals($_itemColumn<int>('usu_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_alunosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RegistrosTable, List<Registro>>
  _registrosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.registros,
    aliasName: $_aliasNameGenerator(db.usuarios.usuId, db.registros.regUsuario),
  );

  $$RegistrosTableProcessedTableManager get registrosRefs {
    final manager = $$RegistrosTableTableManager(
      $_db,
      $_db.registros,
    ).filter((f) => f.regUsuario.usuId.sqlEquals($_itemColumn<int>('usu_id')!));

    final cache = $_typedResult.readTableOrNull(_registrosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get usuId => $composableBuilder(
    column: $table.usuId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usuNome => $composableBuilder(
    column: $table.usuNome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usuCPF => $composableBuilder(
    column: $table.usuCPF,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get usuDtNascimento => $composableBuilder(
    column: $table.usuDtNascimento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usuEmail => $composableBuilder(
    column: $table.usuEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Cargos, Cargos, String> get usuCargo =>
      $composableBuilder(
        column: $table.usuCargo,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get usuSenha => $composableBuilder(
    column: $table.usuSenha,
    builder: (column) => ColumnFilters(column),
  );

  $$EscolasTableFilterComposer get usuEscola {
    final $$EscolasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuEscola,
      referencedTable: $db.escolas,
      getReferencedColumn: (t) => t.escId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EscolasTableFilterComposer(
            $db: $db,
            $table: $db.escolas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> turmasRefs(
    Expression<bool> Function($$TurmasTableFilterComposer f) f,
  ) {
    final $$TurmasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuId,
      referencedTable: $db.turmas,
      getReferencedColumn: (t) => t.turProfessorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TurmasTableFilterComposer(
            $db: $db,
            $table: $db.turmas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> alunosRefs(
    Expression<bool> Function($$AlunosTableFilterComposer f) f,
  ) {
    final $$AlunosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuId,
      referencedTable: $db.alunos,
      getReferencedColumn: (t) => t.aluCuidadorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlunosTableFilterComposer(
            $db: $db,
            $table: $db.alunos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> registrosRefs(
    Expression<bool> Function($$RegistrosTableFilterComposer f) f,
  ) {
    final $$RegistrosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuId,
      referencedTable: $db.registros,
      getReferencedColumn: (t) => t.regUsuario,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrosTableFilterComposer(
            $db: $db,
            $table: $db.registros,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get usuId => $composableBuilder(
    column: $table.usuId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usuNome => $composableBuilder(
    column: $table.usuNome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usuCPF => $composableBuilder(
    column: $table.usuCPF,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get usuDtNascimento => $composableBuilder(
    column: $table.usuDtNascimento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usuEmail => $composableBuilder(
    column: $table.usuEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usuCargo => $composableBuilder(
    column: $table.usuCargo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usuSenha => $composableBuilder(
    column: $table.usuSenha,
    builder: (column) => ColumnOrderings(column),
  );

  $$EscolasTableOrderingComposer get usuEscola {
    final $$EscolasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuEscola,
      referencedTable: $db.escolas,
      getReferencedColumn: (t) => t.escId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EscolasTableOrderingComposer(
            $db: $db,
            $table: $db.escolas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get usuId =>
      $composableBuilder(column: $table.usuId, builder: (column) => column);

  GeneratedColumn<String> get usuNome =>
      $composableBuilder(column: $table.usuNome, builder: (column) => column);

  GeneratedColumn<String> get usuCPF =>
      $composableBuilder(column: $table.usuCPF, builder: (column) => column);

  GeneratedColumn<DateTime> get usuDtNascimento => $composableBuilder(
    column: $table.usuDtNascimento,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usuEmail =>
      $composableBuilder(column: $table.usuEmail, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Cargos, String> get usuCargo =>
      $composableBuilder(column: $table.usuCargo, builder: (column) => column);

  GeneratedColumn<String> get usuSenha =>
      $composableBuilder(column: $table.usuSenha, builder: (column) => column);

  $$EscolasTableAnnotationComposer get usuEscola {
    final $$EscolasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuEscola,
      referencedTable: $db.escolas,
      getReferencedColumn: (t) => t.escId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EscolasTableAnnotationComposer(
            $db: $db,
            $table: $db.escolas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> turmasRefs<T extends Object>(
    Expression<T> Function($$TurmasTableAnnotationComposer a) f,
  ) {
    final $$TurmasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuId,
      referencedTable: $db.turmas,
      getReferencedColumn: (t) => t.turProfessorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TurmasTableAnnotationComposer(
            $db: $db,
            $table: $db.turmas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> alunosRefs<T extends Object>(
    Expression<T> Function($$AlunosTableAnnotationComposer a) f,
  ) {
    final $$AlunosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuId,
      referencedTable: $db.alunos,
      getReferencedColumn: (t) => t.aluCuidadorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlunosTableAnnotationComposer(
            $db: $db,
            $table: $db.alunos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> registrosRefs<T extends Object>(
    Expression<T> Function($$RegistrosTableAnnotationComposer a) f,
  ) {
    final $$RegistrosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuId,
      referencedTable: $db.registros,
      getReferencedColumn: (t) => t.regUsuario,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrosTableAnnotationComposer(
            $db: $db,
            $table: $db.registros,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosTable,
          Usuario,
          $$UsuariosTableFilterComposer,
          $$UsuariosTableOrderingComposer,
          $$UsuariosTableAnnotationComposer,
          $$UsuariosTableCreateCompanionBuilder,
          $$UsuariosTableUpdateCompanionBuilder,
          (Usuario, $$UsuariosTableReferences),
          Usuario,
          PrefetchHooks Function({
            bool usuEscola,
            bool turmasRefs,
            bool alunosRefs,
            bool registrosRefs,
          })
        > {
  $$UsuariosTableTableManager(_$AppDatabase db, $UsuariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> usuId = const Value.absent(),
                Value<String> usuNome = const Value.absent(),
                Value<String> usuCPF = const Value.absent(),
                Value<DateTime> usuDtNascimento = const Value.absent(),
                Value<String> usuEmail = const Value.absent(),
                Value<Cargos> usuCargo = const Value.absent(),
                Value<String> usuSenha = const Value.absent(),
                Value<int> usuEscola = const Value.absent(),
              }) => UsuariosCompanion(
                usuId: usuId,
                usuNome: usuNome,
                usuCPF: usuCPF,
                usuDtNascimento: usuDtNascimento,
                usuEmail: usuEmail,
                usuCargo: usuCargo,
                usuSenha: usuSenha,
                usuEscola: usuEscola,
              ),
          createCompanionCallback:
              ({
                Value<int> usuId = const Value.absent(),
                required String usuNome,
                required String usuCPF,
                required DateTime usuDtNascimento,
                required String usuEmail,
                required Cargos usuCargo,
                required String usuSenha,
                required int usuEscola,
              }) => UsuariosCompanion.insert(
                usuId: usuId,
                usuNome: usuNome,
                usuCPF: usuCPF,
                usuDtNascimento: usuDtNascimento,
                usuEmail: usuEmail,
                usuCargo: usuCargo,
                usuSenha: usuSenha,
                usuEscola: usuEscola,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UsuariosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                usuEscola = false,
                turmasRefs = false,
                alunosRefs = false,
                registrosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (turmasRefs) db.turmas,
                    if (alunosRefs) db.alunos,
                    if (registrosRefs) db.registros,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (usuEscola) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.usuEscola,
                                    referencedTable: $$UsuariosTableReferences
                                        ._usuEscolaTable(db),
                                    referencedColumn: $$UsuariosTableReferences
                                        ._usuEscolaTable(db)
                                        .escId,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (turmasRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          Turma
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._turmasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).turmasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.turProfessorId == item.usuId,
                              ),
                          typedResults: items,
                        ),
                      if (alunosRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          Aluno
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._alunosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).alunosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.aluCuidadorId == item.usuId,
                              ),
                          typedResults: items,
                        ),
                      if (registrosRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          Registro
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._registrosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).registrosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.regUsuario == item.usuId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosTable,
      Usuario,
      $$UsuariosTableFilterComposer,
      $$UsuariosTableOrderingComposer,
      $$UsuariosTableAnnotationComposer,
      $$UsuariosTableCreateCompanionBuilder,
      $$UsuariosTableUpdateCompanionBuilder,
      (Usuario, $$UsuariosTableReferences),
      Usuario,
      PrefetchHooks Function({
        bool usuEscola,
        bool turmasRefs,
        bool alunosRefs,
        bool registrosRefs,
      })
    >;
typedef $$TurmasTableCreateCompanionBuilder =
    TurmasCompanion Function({
      Value<int> turId,
      required Turno turTurno,
      required Ano turAno,
      required int turNumero,
      required int turEscola,
      required int turProfessorId,
    });
typedef $$TurmasTableUpdateCompanionBuilder =
    TurmasCompanion Function({
      Value<int> turId,
      Value<Turno> turTurno,
      Value<Ano> turAno,
      Value<int> turNumero,
      Value<int> turEscola,
      Value<int> turProfessorId,
    });

final class $$TurmasTableReferences
    extends BaseReferences<_$AppDatabase, $TurmasTable, Turma> {
  $$TurmasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EscolasTable _turEscolaTable(_$AppDatabase db) => db.escolas
      .createAlias($_aliasNameGenerator(db.turmas.turEscola, db.escolas.escId));

  $$EscolasTableProcessedTableManager get turEscola {
    final $_column = $_itemColumn<int>('tur_escola')!;

    final manager = $$EscolasTableTableManager(
      $_db,
      $_db.escolas,
    ).filter((f) => f.escId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_turEscolaTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsuariosTable _turProfessorIdTable(_$AppDatabase db) =>
      db.usuarios.createAlias(
        $_aliasNameGenerator(db.turmas.turProfessorId, db.usuarios.usuId),
      );

  $$UsuariosTableProcessedTableManager get turProfessorId {
    final $_column = $_itemColumn<int>('tur_professor_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.usuId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_turProfessorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AlunosTable, List<Aluno>> _alunosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.alunos,
    aliasName: $_aliasNameGenerator(db.turmas.turId, db.alunos.aluTurmaId),
  );

  $$AlunosTableProcessedTableManager get alunosRefs {
    final manager = $$AlunosTableTableManager(
      $_db,
      $_db.alunos,
    ).filter((f) => f.aluTurmaId.turId.sqlEquals($_itemColumn<int>('tur_id')!));

    final cache = $_typedResult.readTableOrNull(_alunosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TurmasTableFilterComposer
    extends Composer<_$AppDatabase, $TurmasTable> {
  $$TurmasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get turId => $composableBuilder(
    column: $table.turId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Turno, Turno, String> get turTurno =>
      $composableBuilder(
        column: $table.turTurno,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Ano, Ano, int> get turAno =>
      $composableBuilder(
        column: $table.turAno,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get turNumero => $composableBuilder(
    column: $table.turNumero,
    builder: (column) => ColumnFilters(column),
  );

  $$EscolasTableFilterComposer get turEscola {
    final $$EscolasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.turEscola,
      referencedTable: $db.escolas,
      getReferencedColumn: (t) => t.escId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EscolasTableFilterComposer(
            $db: $db,
            $table: $db.escolas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableFilterComposer get turProfessorId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.turProfessorId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.usuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> alunosRefs(
    Expression<bool> Function($$AlunosTableFilterComposer f) f,
  ) {
    final $$AlunosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.turId,
      referencedTable: $db.alunos,
      getReferencedColumn: (t) => t.aluTurmaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlunosTableFilterComposer(
            $db: $db,
            $table: $db.alunos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TurmasTableOrderingComposer
    extends Composer<_$AppDatabase, $TurmasTable> {
  $$TurmasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get turId => $composableBuilder(
    column: $table.turId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get turTurno => $composableBuilder(
    column: $table.turTurno,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get turAno => $composableBuilder(
    column: $table.turAno,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get turNumero => $composableBuilder(
    column: $table.turNumero,
    builder: (column) => ColumnOrderings(column),
  );

  $$EscolasTableOrderingComposer get turEscola {
    final $$EscolasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.turEscola,
      referencedTable: $db.escolas,
      getReferencedColumn: (t) => t.escId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EscolasTableOrderingComposer(
            $db: $db,
            $table: $db.escolas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableOrderingComposer get turProfessorId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.turProfessorId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.usuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TurmasTableAnnotationComposer
    extends Composer<_$AppDatabase, $TurmasTable> {
  $$TurmasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get turId =>
      $composableBuilder(column: $table.turId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Turno, String> get turTurno =>
      $composableBuilder(column: $table.turTurno, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Ano, int> get turAno =>
      $composableBuilder(column: $table.turAno, builder: (column) => column);

  GeneratedColumn<int> get turNumero =>
      $composableBuilder(column: $table.turNumero, builder: (column) => column);

  $$EscolasTableAnnotationComposer get turEscola {
    final $$EscolasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.turEscola,
      referencedTable: $db.escolas,
      getReferencedColumn: (t) => t.escId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EscolasTableAnnotationComposer(
            $db: $db,
            $table: $db.escolas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableAnnotationComposer get turProfessorId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.turProfessorId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.usuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> alunosRefs<T extends Object>(
    Expression<T> Function($$AlunosTableAnnotationComposer a) f,
  ) {
    final $$AlunosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.turId,
      referencedTable: $db.alunos,
      getReferencedColumn: (t) => t.aluTurmaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlunosTableAnnotationComposer(
            $db: $db,
            $table: $db.alunos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TurmasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TurmasTable,
          Turma,
          $$TurmasTableFilterComposer,
          $$TurmasTableOrderingComposer,
          $$TurmasTableAnnotationComposer,
          $$TurmasTableCreateCompanionBuilder,
          $$TurmasTableUpdateCompanionBuilder,
          (Turma, $$TurmasTableReferences),
          Turma,
          PrefetchHooks Function({
            bool turEscola,
            bool turProfessorId,
            bool alunosRefs,
          })
        > {
  $$TurmasTableTableManager(_$AppDatabase db, $TurmasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TurmasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TurmasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TurmasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> turId = const Value.absent(),
                Value<Turno> turTurno = const Value.absent(),
                Value<Ano> turAno = const Value.absent(),
                Value<int> turNumero = const Value.absent(),
                Value<int> turEscola = const Value.absent(),
                Value<int> turProfessorId = const Value.absent(),
              }) => TurmasCompanion(
                turId: turId,
                turTurno: turTurno,
                turAno: turAno,
                turNumero: turNumero,
                turEscola: turEscola,
                turProfessorId: turProfessorId,
              ),
          createCompanionCallback:
              ({
                Value<int> turId = const Value.absent(),
                required Turno turTurno,
                required Ano turAno,
                required int turNumero,
                required int turEscola,
                required int turProfessorId,
              }) => TurmasCompanion.insert(
                turId: turId,
                turTurno: turTurno,
                turAno: turAno,
                turNumero: turNumero,
                turEscola: turEscola,
                turProfessorId: turProfessorId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TurmasTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                turEscola = false,
                turProfessorId = false,
                alunosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (alunosRefs) db.alunos],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (turEscola) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.turEscola,
                                    referencedTable: $$TurmasTableReferences
                                        ._turEscolaTable(db),
                                    referencedColumn: $$TurmasTableReferences
                                        ._turEscolaTable(db)
                                        .escId,
                                  )
                                  as T;
                        }
                        if (turProfessorId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.turProfessorId,
                                    referencedTable: $$TurmasTableReferences
                                        ._turProfessorIdTable(db),
                                    referencedColumn: $$TurmasTableReferences
                                        ._turProfessorIdTable(db)
                                        .usuId,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (alunosRefs)
                        await $_getPrefetchedData<Turma, $TurmasTable, Aluno>(
                          currentTable: table,
                          referencedTable: $$TurmasTableReferences
                              ._alunosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TurmasTableReferences(db, table, p0).alunosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.aluTurmaId == item.turId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TurmasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TurmasTable,
      Turma,
      $$TurmasTableFilterComposer,
      $$TurmasTableOrderingComposer,
      $$TurmasTableAnnotationComposer,
      $$TurmasTableCreateCompanionBuilder,
      $$TurmasTableUpdateCompanionBuilder,
      (Turma, $$TurmasTableReferences),
      Turma,
      PrefetchHooks Function({
        bool turEscola,
        bool turProfessorId,
        bool alunosRefs,
      })
    >;
typedef $$AlunosTableCreateCompanionBuilder =
    AlunosCompanion Function({
      Value<int> aluId,
      required String aluNome,
      required String aluCFP,
      required DateTime aluDtNascimento,
      required int aluEscolaId,
      required int aluTurmaId,
      required int aluCuidadorId,
    });
typedef $$AlunosTableUpdateCompanionBuilder =
    AlunosCompanion Function({
      Value<int> aluId,
      Value<String> aluNome,
      Value<String> aluCFP,
      Value<DateTime> aluDtNascimento,
      Value<int> aluEscolaId,
      Value<int> aluTurmaId,
      Value<int> aluCuidadorId,
    });

final class $$AlunosTableReferences
    extends BaseReferences<_$AppDatabase, $AlunosTable, Aluno> {
  $$AlunosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EscolasTable _aluEscolaIdTable(_$AppDatabase db) =>
      db.escolas.createAlias(
        $_aliasNameGenerator(db.alunos.aluEscolaId, db.escolas.escId),
      );

  $$EscolasTableProcessedTableManager get aluEscolaId {
    final $_column = $_itemColumn<int>('alu_escola_id')!;

    final manager = $$EscolasTableTableManager(
      $_db,
      $_db.escolas,
    ).filter((f) => f.escId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_aluEscolaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TurmasTable _aluTurmaIdTable(_$AppDatabase db) => db.turmas
      .createAlias($_aliasNameGenerator(db.alunos.aluTurmaId, db.turmas.turId));

  $$TurmasTableProcessedTableManager get aluTurmaId {
    final $_column = $_itemColumn<int>('alu_turma_id')!;

    final manager = $$TurmasTableTableManager(
      $_db,
      $_db.turmas,
    ).filter((f) => f.turId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_aluTurmaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsuariosTable _aluCuidadorIdTable(_$AppDatabase db) =>
      db.usuarios.createAlias(
        $_aliasNameGenerator(db.alunos.aluCuidadorId, db.usuarios.usuId),
      );

  $$UsuariosTableProcessedTableManager get aluCuidadorId {
    final $_column = $_itemColumn<int>('alu_cuidador_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.usuId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_aluCuidadorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RegistrosTable, List<Registro>>
  _registrosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.registros,
    aliasName: $_aliasNameGenerator(db.alunos.aluId, db.registros.regAluno),
  );

  $$RegistrosTableProcessedTableManager get registrosRefs {
    final manager = $$RegistrosTableTableManager(
      $_db,
      $_db.registros,
    ).filter((f) => f.regAluno.aluId.sqlEquals($_itemColumn<int>('alu_id')!));

    final cache = $_typedResult.readTableOrNull(_registrosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AlunosTableFilterComposer
    extends Composer<_$AppDatabase, $AlunosTable> {
  $$AlunosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get aluId => $composableBuilder(
    column: $table.aluId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aluNome => $composableBuilder(
    column: $table.aluNome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aluCFP => $composableBuilder(
    column: $table.aluCFP,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get aluDtNascimento => $composableBuilder(
    column: $table.aluDtNascimento,
    builder: (column) => ColumnFilters(column),
  );

  $$EscolasTableFilterComposer get aluEscolaId {
    final $$EscolasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aluEscolaId,
      referencedTable: $db.escolas,
      getReferencedColumn: (t) => t.escId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EscolasTableFilterComposer(
            $db: $db,
            $table: $db.escolas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TurmasTableFilterComposer get aluTurmaId {
    final $$TurmasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aluTurmaId,
      referencedTable: $db.turmas,
      getReferencedColumn: (t) => t.turId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TurmasTableFilterComposer(
            $db: $db,
            $table: $db.turmas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableFilterComposer get aluCuidadorId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aluCuidadorId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.usuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> registrosRefs(
    Expression<bool> Function($$RegistrosTableFilterComposer f) f,
  ) {
    final $$RegistrosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aluId,
      referencedTable: $db.registros,
      getReferencedColumn: (t) => t.regAluno,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrosTableFilterComposer(
            $db: $db,
            $table: $db.registros,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AlunosTableOrderingComposer
    extends Composer<_$AppDatabase, $AlunosTable> {
  $$AlunosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get aluId => $composableBuilder(
    column: $table.aluId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aluNome => $composableBuilder(
    column: $table.aluNome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aluCFP => $composableBuilder(
    column: $table.aluCFP,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get aluDtNascimento => $composableBuilder(
    column: $table.aluDtNascimento,
    builder: (column) => ColumnOrderings(column),
  );

  $$EscolasTableOrderingComposer get aluEscolaId {
    final $$EscolasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aluEscolaId,
      referencedTable: $db.escolas,
      getReferencedColumn: (t) => t.escId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EscolasTableOrderingComposer(
            $db: $db,
            $table: $db.escolas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TurmasTableOrderingComposer get aluTurmaId {
    final $$TurmasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aluTurmaId,
      referencedTable: $db.turmas,
      getReferencedColumn: (t) => t.turId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TurmasTableOrderingComposer(
            $db: $db,
            $table: $db.turmas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableOrderingComposer get aluCuidadorId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aluCuidadorId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.usuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlunosTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlunosTable> {
  $$AlunosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get aluId =>
      $composableBuilder(column: $table.aluId, builder: (column) => column);

  GeneratedColumn<String> get aluNome =>
      $composableBuilder(column: $table.aluNome, builder: (column) => column);

  GeneratedColumn<String> get aluCFP =>
      $composableBuilder(column: $table.aluCFP, builder: (column) => column);

  GeneratedColumn<DateTime> get aluDtNascimento => $composableBuilder(
    column: $table.aluDtNascimento,
    builder: (column) => column,
  );

  $$EscolasTableAnnotationComposer get aluEscolaId {
    final $$EscolasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aluEscolaId,
      referencedTable: $db.escolas,
      getReferencedColumn: (t) => t.escId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EscolasTableAnnotationComposer(
            $db: $db,
            $table: $db.escolas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TurmasTableAnnotationComposer get aluTurmaId {
    final $$TurmasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aluTurmaId,
      referencedTable: $db.turmas,
      getReferencedColumn: (t) => t.turId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TurmasTableAnnotationComposer(
            $db: $db,
            $table: $db.turmas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableAnnotationComposer get aluCuidadorId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aluCuidadorId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.usuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> registrosRefs<T extends Object>(
    Expression<T> Function($$RegistrosTableAnnotationComposer a) f,
  ) {
    final $$RegistrosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aluId,
      referencedTable: $db.registros,
      getReferencedColumn: (t) => t.regAluno,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrosTableAnnotationComposer(
            $db: $db,
            $table: $db.registros,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AlunosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AlunosTable,
          Aluno,
          $$AlunosTableFilterComposer,
          $$AlunosTableOrderingComposer,
          $$AlunosTableAnnotationComposer,
          $$AlunosTableCreateCompanionBuilder,
          $$AlunosTableUpdateCompanionBuilder,
          (Aluno, $$AlunosTableReferences),
          Aluno,
          PrefetchHooks Function({
            bool aluEscolaId,
            bool aluTurmaId,
            bool aluCuidadorId,
            bool registrosRefs,
          })
        > {
  $$AlunosTableTableManager(_$AppDatabase db, $AlunosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlunosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlunosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlunosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> aluId = const Value.absent(),
                Value<String> aluNome = const Value.absent(),
                Value<String> aluCFP = const Value.absent(),
                Value<DateTime> aluDtNascimento = const Value.absent(),
                Value<int> aluEscolaId = const Value.absent(),
                Value<int> aluTurmaId = const Value.absent(),
                Value<int> aluCuidadorId = const Value.absent(),
              }) => AlunosCompanion(
                aluId: aluId,
                aluNome: aluNome,
                aluCFP: aluCFP,
                aluDtNascimento: aluDtNascimento,
                aluEscolaId: aluEscolaId,
                aluTurmaId: aluTurmaId,
                aluCuidadorId: aluCuidadorId,
              ),
          createCompanionCallback:
              ({
                Value<int> aluId = const Value.absent(),
                required String aluNome,
                required String aluCFP,
                required DateTime aluDtNascimento,
                required int aluEscolaId,
                required int aluTurmaId,
                required int aluCuidadorId,
              }) => AlunosCompanion.insert(
                aluId: aluId,
                aluNome: aluNome,
                aluCFP: aluCFP,
                aluDtNascimento: aluDtNascimento,
                aluEscolaId: aluEscolaId,
                aluTurmaId: aluTurmaId,
                aluCuidadorId: aluCuidadorId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$AlunosTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                aluEscolaId = false,
                aluTurmaId = false,
                aluCuidadorId = false,
                registrosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (registrosRefs) db.registros],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (aluEscolaId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.aluEscolaId,
                                    referencedTable: $$AlunosTableReferences
                                        ._aluEscolaIdTable(db),
                                    referencedColumn: $$AlunosTableReferences
                                        ._aluEscolaIdTable(db)
                                        .escId,
                                  )
                                  as T;
                        }
                        if (aluTurmaId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.aluTurmaId,
                                    referencedTable: $$AlunosTableReferences
                                        ._aluTurmaIdTable(db),
                                    referencedColumn: $$AlunosTableReferences
                                        ._aluTurmaIdTable(db)
                                        .turId,
                                  )
                                  as T;
                        }
                        if (aluCuidadorId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.aluCuidadorId,
                                    referencedTable: $$AlunosTableReferences
                                        ._aluCuidadorIdTable(db),
                                    referencedColumn: $$AlunosTableReferences
                                        ._aluCuidadorIdTable(db)
                                        .usuId,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (registrosRefs)
                        await $_getPrefetchedData<
                          Aluno,
                          $AlunosTable,
                          Registro
                        >(
                          currentTable: table,
                          referencedTable: $$AlunosTableReferences
                              ._registrosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AlunosTableReferences(
                                db,
                                table,
                                p0,
                              ).registrosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.regAluno == item.aluId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AlunosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AlunosTable,
      Aluno,
      $$AlunosTableFilterComposer,
      $$AlunosTableOrderingComposer,
      $$AlunosTableAnnotationComposer,
      $$AlunosTableCreateCompanionBuilder,
      $$AlunosTableUpdateCompanionBuilder,
      (Aluno, $$AlunosTableReferences),
      Aluno,
      PrefetchHooks Function({
        bool aluEscolaId,
        bool aluTurmaId,
        bool aluCuidadorId,
        bool registrosRefs,
      })
    >;
typedef $$RegistrosTableCreateCompanionBuilder =
    RegistrosCompanion Function({
      Value<int> regId,
      required DateTime regData,
      required Alimentacao regAlimentacao,
      required Atividades regAtividade,
      required Comportamento regComportamento,
      required String regObservacao,
      required int regAluno,
      required int regUsuario,
    });
typedef $$RegistrosTableUpdateCompanionBuilder =
    RegistrosCompanion Function({
      Value<int> regId,
      Value<DateTime> regData,
      Value<Alimentacao> regAlimentacao,
      Value<Atividades> regAtividade,
      Value<Comportamento> regComportamento,
      Value<String> regObservacao,
      Value<int> regAluno,
      Value<int> regUsuario,
    });

final class $$RegistrosTableReferences
    extends BaseReferences<_$AppDatabase, $RegistrosTable, Registro> {
  $$RegistrosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AlunosTable _regAlunoTable(_$AppDatabase db) => db.alunos.createAlias(
    $_aliasNameGenerator(db.registros.regAluno, db.alunos.aluId),
  );

  $$AlunosTableProcessedTableManager get regAluno {
    final $_column = $_itemColumn<int>('reg_aluno')!;

    final manager = $$AlunosTableTableManager(
      $_db,
      $_db.alunos,
    ).filter((f) => f.aluId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_regAlunoTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsuariosTable _regUsuarioTable(_$AppDatabase db) =>
      db.usuarios.createAlias(
        $_aliasNameGenerator(db.registros.regUsuario, db.usuarios.usuId),
      );

  $$UsuariosTableProcessedTableManager get regUsuario {
    final $_column = $_itemColumn<int>('reg_usuario')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.usuId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_regUsuarioTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RegistrosTableFilterComposer
    extends Composer<_$AppDatabase, $RegistrosTable> {
  $$RegistrosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get regId => $composableBuilder(
    column: $table.regId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get regData => $composableBuilder(
    column: $table.regData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Alimentacao, Alimentacao, String>
  get regAlimentacao => $composableBuilder(
    column: $table.regAlimentacao,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<Atividades, Atividades, String>
  get regAtividade => $composableBuilder(
    column: $table.regAtividade,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<Comportamento, Comportamento, String>
  get regComportamento => $composableBuilder(
    column: $table.regComportamento,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get regObservacao => $composableBuilder(
    column: $table.regObservacao,
    builder: (column) => ColumnFilters(column),
  );

  $$AlunosTableFilterComposer get regAluno {
    final $$AlunosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regAluno,
      referencedTable: $db.alunos,
      getReferencedColumn: (t) => t.aluId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlunosTableFilterComposer(
            $db: $db,
            $table: $db.alunos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableFilterComposer get regUsuario {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regUsuario,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.usuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegistrosTableOrderingComposer
    extends Composer<_$AppDatabase, $RegistrosTable> {
  $$RegistrosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get regId => $composableBuilder(
    column: $table.regId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get regData => $composableBuilder(
    column: $table.regData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regAlimentacao => $composableBuilder(
    column: $table.regAlimentacao,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regAtividade => $composableBuilder(
    column: $table.regAtividade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regComportamento => $composableBuilder(
    column: $table.regComportamento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regObservacao => $composableBuilder(
    column: $table.regObservacao,
    builder: (column) => ColumnOrderings(column),
  );

  $$AlunosTableOrderingComposer get regAluno {
    final $$AlunosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regAluno,
      referencedTable: $db.alunos,
      getReferencedColumn: (t) => t.aluId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlunosTableOrderingComposer(
            $db: $db,
            $table: $db.alunos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableOrderingComposer get regUsuario {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regUsuario,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.usuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegistrosTableAnnotationComposer
    extends Composer<_$AppDatabase, $RegistrosTable> {
  $$RegistrosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get regId =>
      $composableBuilder(column: $table.regId, builder: (column) => column);

  GeneratedColumn<DateTime> get regData =>
      $composableBuilder(column: $table.regData, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Alimentacao, String> get regAlimentacao =>
      $composableBuilder(
        column: $table.regAlimentacao,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<Atividades, String> get regAtividade =>
      $composableBuilder(
        column: $table.regAtividade,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<Comportamento, String>
  get regComportamento => $composableBuilder(
    column: $table.regComportamento,
    builder: (column) => column,
  );

  GeneratedColumn<String> get regObservacao => $composableBuilder(
    column: $table.regObservacao,
    builder: (column) => column,
  );

  $$AlunosTableAnnotationComposer get regAluno {
    final $$AlunosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regAluno,
      referencedTable: $db.alunos,
      getReferencedColumn: (t) => t.aluId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlunosTableAnnotationComposer(
            $db: $db,
            $table: $db.alunos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableAnnotationComposer get regUsuario {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regUsuario,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.usuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegistrosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RegistrosTable,
          Registro,
          $$RegistrosTableFilterComposer,
          $$RegistrosTableOrderingComposer,
          $$RegistrosTableAnnotationComposer,
          $$RegistrosTableCreateCompanionBuilder,
          $$RegistrosTableUpdateCompanionBuilder,
          (Registro, $$RegistrosTableReferences),
          Registro,
          PrefetchHooks Function({bool regAluno, bool regUsuario})
        > {
  $$RegistrosTableTableManager(_$AppDatabase db, $RegistrosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RegistrosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RegistrosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RegistrosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> regId = const Value.absent(),
                Value<DateTime> regData = const Value.absent(),
                Value<Alimentacao> regAlimentacao = const Value.absent(),
                Value<Atividades> regAtividade = const Value.absent(),
                Value<Comportamento> regComportamento = const Value.absent(),
                Value<String> regObservacao = const Value.absent(),
                Value<int> regAluno = const Value.absent(),
                Value<int> regUsuario = const Value.absent(),
              }) => RegistrosCompanion(
                regId: regId,
                regData: regData,
                regAlimentacao: regAlimentacao,
                regAtividade: regAtividade,
                regComportamento: regComportamento,
                regObservacao: regObservacao,
                regAluno: regAluno,
                regUsuario: regUsuario,
              ),
          createCompanionCallback:
              ({
                Value<int> regId = const Value.absent(),
                required DateTime regData,
                required Alimentacao regAlimentacao,
                required Atividades regAtividade,
                required Comportamento regComportamento,
                required String regObservacao,
                required int regAluno,
                required int regUsuario,
              }) => RegistrosCompanion.insert(
                regId: regId,
                regData: regData,
                regAlimentacao: regAlimentacao,
                regAtividade: regAtividade,
                regComportamento: regComportamento,
                regObservacao: regObservacao,
                regAluno: regAluno,
                regUsuario: regUsuario,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RegistrosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({regAluno = false, regUsuario = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (regAluno) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.regAluno,
                                referencedTable: $$RegistrosTableReferences
                                    ._regAlunoTable(db),
                                referencedColumn: $$RegistrosTableReferences
                                    ._regAlunoTable(db)
                                    .aluId,
                              )
                              as T;
                    }
                    if (regUsuario) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.regUsuario,
                                referencedTable: $$RegistrosTableReferences
                                    ._regUsuarioTable(db),
                                referencedColumn: $$RegistrosTableReferences
                                    ._regUsuarioTable(db)
                                    .usuId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RegistrosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RegistrosTable,
      Registro,
      $$RegistrosTableFilterComposer,
      $$RegistrosTableOrderingComposer,
      $$RegistrosTableAnnotationComposer,
      $$RegistrosTableCreateCompanionBuilder,
      $$RegistrosTableUpdateCompanionBuilder,
      (Registro, $$RegistrosTableReferences),
      Registro,
      PrefetchHooks Function({bool regAluno, bool regUsuario})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EscolasTableTableManager get escolas =>
      $$EscolasTableTableManager(_db, _db.escolas);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$TurmasTableTableManager get turmas =>
      $$TurmasTableTableManager(_db, _db.turmas);
  $$AlunosTableTableManager get alunos =>
      $$AlunosTableTableManager(_db, _db.alunos);
  $$RegistrosTableTableManager get registros =>
      $$RegistrosTableTableManager(_db, _db.registros);
}
