// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
mixin _$PlayersDaoMixin on DatabaseAccessor<AppDatabase> {
  $PlayersTable get players => attachedDatabase.players;
}
mixin _$StatsDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $MatchesTable get matches => attachedDatabase.matches;
  $MatchSetsTable get matchSets => attachedDatabase.matchSets;
  $PlayersTable get players => attachedDatabase.players;
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, username, email, passwordHash];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String email;
  final String passwordHash;
  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.passwordHash,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['email'] = Variable<String>(email);
    map['password_hash'] = Variable<String>(passwordHash);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      email: Value(email),
      passwordHash: Value(passwordHash),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      email: serializer.fromJson<String>(json['email']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'email': serializer.toJson<String>(email),
      'passwordHash': serializer.toJson<String>(passwordHash),
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? passwordHash,
  }) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    email: email ?? this.email,
    passwordHash: passwordHash ?? this.passwordHash,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, email, passwordHash);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> email;
  final Value<String> passwordHash;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String email,
    required String passwordHash,
  }) : username = Value(username),
       email = Value(email),
       passwordHash = Value(passwordHash);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? email,
    Expression<String>? passwordHash,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? email,
    Value<String>? passwordHash,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash')
          ..write(')'))
        .toString();
  }
}

class $MatchesTable extends Matches with TableInfo<$MatchesTable, MatchData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _creatorIdMeta = const VerificationMeta(
    'creatorId',
  );
  @override
  late final GeneratedColumn<int> creatorId = GeneratedColumn<int>(
    'creator_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _matchTypeMeta = const VerificationMeta(
    'matchType',
  );
  @override
  late final GeneratedColumn<String> matchType = GeneratedColumn<String>(
    'match_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playerAMeta = const VerificationMeta(
    'playerA',
  );
  @override
  late final GeneratedColumn<String> playerA = GeneratedColumn<String>(
    'player_a',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playerBMeta = const VerificationMeta(
    'playerB',
  );
  @override
  late final GeneratedColumn<String> playerB = GeneratedColumn<String>(
    'player_b',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playerCMeta = const VerificationMeta(
    'playerC',
  );
  @override
  late final GeneratedColumn<String> playerC = GeneratedColumn<String>(
    'player_c',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _playerDMeta = const VerificationMeta(
    'playerD',
  );
  @override
  late final GeneratedColumn<String> playerD = GeneratedColumn<String>(
    'player_d',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _winnerMeta = const VerificationMeta('winner');
  @override
  late final GeneratedColumn<String> winner = GeneratedColumn<String>(
    'winner',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _teamALabelMeta = const VerificationMeta(
    'teamALabel',
  );
  @override
  late final GeneratedColumn<String> teamALabel = GeneratedColumn<String>(
    'team_a_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Team A'),
  );
  static const VerificationMeta _teamBLabelMeta = const VerificationMeta(
    'teamBLabel',
  );
  @override
  late final GeneratedColumn<String> teamBLabel = GeneratedColumn<String>(
    'team_b_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Team B'),
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    creatorId,
    date,
    matchType,
    playerA,
    playerB,
    playerC,
    playerD,
    winner,
    teamALabel,
    teamBLabel,
    isCompleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'matches';
  @override
  VerificationContext validateIntegrity(
    Insertable<MatchData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('creator_id')) {
      context.handle(
        _creatorIdMeta,
        creatorId.isAcceptableOrUnknown(data['creator_id']!, _creatorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_creatorIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('match_type')) {
      context.handle(
        _matchTypeMeta,
        matchType.isAcceptableOrUnknown(data['match_type']!, _matchTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_matchTypeMeta);
    }
    if (data.containsKey('player_a')) {
      context.handle(
        _playerAMeta,
        playerA.isAcceptableOrUnknown(data['player_a']!, _playerAMeta),
      );
    } else if (isInserting) {
      context.missing(_playerAMeta);
    }
    if (data.containsKey('player_b')) {
      context.handle(
        _playerBMeta,
        playerB.isAcceptableOrUnknown(data['player_b']!, _playerBMeta),
      );
    } else if (isInserting) {
      context.missing(_playerBMeta);
    }
    if (data.containsKey('player_c')) {
      context.handle(
        _playerCMeta,
        playerC.isAcceptableOrUnknown(data['player_c']!, _playerCMeta),
      );
    }
    if (data.containsKey('player_d')) {
      context.handle(
        _playerDMeta,
        playerD.isAcceptableOrUnknown(data['player_d']!, _playerDMeta),
      );
    }
    if (data.containsKey('winner')) {
      context.handle(
        _winnerMeta,
        winner.isAcceptableOrUnknown(data['winner']!, _winnerMeta),
      );
    }
    if (data.containsKey('team_a_label')) {
      context.handle(
        _teamALabelMeta,
        teamALabel.isAcceptableOrUnknown(
          data['team_a_label']!,
          _teamALabelMeta,
        ),
      );
    }
    if (data.containsKey('team_b_label')) {
      context.handle(
        _teamBLabelMeta,
        teamBLabel.isAcceptableOrUnknown(
          data['team_b_label']!,
          _teamBLabelMeta,
        ),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MatchData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      creatorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}creator_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      matchType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_type'],
      )!,
      playerA: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_a'],
      )!,
      playerB: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_b'],
      )!,
      playerC: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_c'],
      ),
      playerD: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_d'],
      ),
      winner: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}winner'],
      ),
      teamALabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_a_label'],
      )!,
      teamBLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_b_label'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
    );
  }

  @override
  $MatchesTable createAlias(String alias) {
    return $MatchesTable(attachedDatabase, alias);
  }
}

class MatchData extends DataClass implements Insertable<MatchData> {
  final int id;
  final int creatorId;
  final DateTime date;
  final String matchType;
  final String playerA;
  final String playerB;
  final String? playerC;
  final String? playerD;
  final String? winner;
  final String teamALabel;
  final String teamBLabel;
  final bool isCompleted;
  const MatchData({
    required this.id,
    required this.creatorId,
    required this.date,
    required this.matchType,
    required this.playerA,
    required this.playerB,
    this.playerC,
    this.playerD,
    this.winner,
    required this.teamALabel,
    required this.teamBLabel,
    required this.isCompleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['creator_id'] = Variable<int>(creatorId);
    map['date'] = Variable<DateTime>(date);
    map['match_type'] = Variable<String>(matchType);
    map['player_a'] = Variable<String>(playerA);
    map['player_b'] = Variable<String>(playerB);
    if (!nullToAbsent || playerC != null) {
      map['player_c'] = Variable<String>(playerC);
    }
    if (!nullToAbsent || playerD != null) {
      map['player_d'] = Variable<String>(playerD);
    }
    if (!nullToAbsent || winner != null) {
      map['winner'] = Variable<String>(winner);
    }
    map['team_a_label'] = Variable<String>(teamALabel);
    map['team_b_label'] = Variable<String>(teamBLabel);
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  MatchesCompanion toCompanion(bool nullToAbsent) {
    return MatchesCompanion(
      id: Value(id),
      creatorId: Value(creatorId),
      date: Value(date),
      matchType: Value(matchType),
      playerA: Value(playerA),
      playerB: Value(playerB),
      playerC: playerC == null && nullToAbsent
          ? const Value.absent()
          : Value(playerC),
      playerD: playerD == null && nullToAbsent
          ? const Value.absent()
          : Value(playerD),
      winner: winner == null && nullToAbsent
          ? const Value.absent()
          : Value(winner),
      teamALabel: Value(teamALabel),
      teamBLabel: Value(teamBLabel),
      isCompleted: Value(isCompleted),
    );
  }

  factory MatchData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchData(
      id: serializer.fromJson<int>(json['id']),
      creatorId: serializer.fromJson<int>(json['creatorId']),
      date: serializer.fromJson<DateTime>(json['date']),
      matchType: serializer.fromJson<String>(json['matchType']),
      playerA: serializer.fromJson<String>(json['playerA']),
      playerB: serializer.fromJson<String>(json['playerB']),
      playerC: serializer.fromJson<String?>(json['playerC']),
      playerD: serializer.fromJson<String?>(json['playerD']),
      winner: serializer.fromJson<String?>(json['winner']),
      teamALabel: serializer.fromJson<String>(json['teamALabel']),
      teamBLabel: serializer.fromJson<String>(json['teamBLabel']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'creatorId': serializer.toJson<int>(creatorId),
      'date': serializer.toJson<DateTime>(date),
      'matchType': serializer.toJson<String>(matchType),
      'playerA': serializer.toJson<String>(playerA),
      'playerB': serializer.toJson<String>(playerB),
      'playerC': serializer.toJson<String?>(playerC),
      'playerD': serializer.toJson<String?>(playerD),
      'winner': serializer.toJson<String?>(winner),
      'teamALabel': serializer.toJson<String>(teamALabel),
      'teamBLabel': serializer.toJson<String>(teamBLabel),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  MatchData copyWith({
    int? id,
    int? creatorId,
    DateTime? date,
    String? matchType,
    String? playerA,
    String? playerB,
    Value<String?> playerC = const Value.absent(),
    Value<String?> playerD = const Value.absent(),
    Value<String?> winner = const Value.absent(),
    String? teamALabel,
    String? teamBLabel,
    bool? isCompleted,
  }) => MatchData(
    id: id ?? this.id,
    creatorId: creatorId ?? this.creatorId,
    date: date ?? this.date,
    matchType: matchType ?? this.matchType,
    playerA: playerA ?? this.playerA,
    playerB: playerB ?? this.playerB,
    playerC: playerC.present ? playerC.value : this.playerC,
    playerD: playerD.present ? playerD.value : this.playerD,
    winner: winner.present ? winner.value : this.winner,
    teamALabel: teamALabel ?? this.teamALabel,
    teamBLabel: teamBLabel ?? this.teamBLabel,
    isCompleted: isCompleted ?? this.isCompleted,
  );
  MatchData copyWithCompanion(MatchesCompanion data) {
    return MatchData(
      id: data.id.present ? data.id.value : this.id,
      creatorId: data.creatorId.present ? data.creatorId.value : this.creatorId,
      date: data.date.present ? data.date.value : this.date,
      matchType: data.matchType.present ? data.matchType.value : this.matchType,
      playerA: data.playerA.present ? data.playerA.value : this.playerA,
      playerB: data.playerB.present ? data.playerB.value : this.playerB,
      playerC: data.playerC.present ? data.playerC.value : this.playerC,
      playerD: data.playerD.present ? data.playerD.value : this.playerD,
      winner: data.winner.present ? data.winner.value : this.winner,
      teamALabel: data.teamALabel.present
          ? data.teamALabel.value
          : this.teamALabel,
      teamBLabel: data.teamBLabel.present
          ? data.teamBLabel.value
          : this.teamBLabel,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchData(')
          ..write('id: $id, ')
          ..write('creatorId: $creatorId, ')
          ..write('date: $date, ')
          ..write('matchType: $matchType, ')
          ..write('playerA: $playerA, ')
          ..write('playerB: $playerB, ')
          ..write('playerC: $playerC, ')
          ..write('playerD: $playerD, ')
          ..write('winner: $winner, ')
          ..write('teamALabel: $teamALabel, ')
          ..write('teamBLabel: $teamBLabel, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    creatorId,
    date,
    matchType,
    playerA,
    playerB,
    playerC,
    playerD,
    winner,
    teamALabel,
    teamBLabel,
    isCompleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchData &&
          other.id == this.id &&
          other.creatorId == this.creatorId &&
          other.date == this.date &&
          other.matchType == this.matchType &&
          other.playerA == this.playerA &&
          other.playerB == this.playerB &&
          other.playerC == this.playerC &&
          other.playerD == this.playerD &&
          other.winner == this.winner &&
          other.teamALabel == this.teamALabel &&
          other.teamBLabel == this.teamBLabel &&
          other.isCompleted == this.isCompleted);
}

class MatchesCompanion extends UpdateCompanion<MatchData> {
  final Value<int> id;
  final Value<int> creatorId;
  final Value<DateTime> date;
  final Value<String> matchType;
  final Value<String> playerA;
  final Value<String> playerB;
  final Value<String?> playerC;
  final Value<String?> playerD;
  final Value<String?> winner;
  final Value<String> teamALabel;
  final Value<String> teamBLabel;
  final Value<bool> isCompleted;
  const MatchesCompanion({
    this.id = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.date = const Value.absent(),
    this.matchType = const Value.absent(),
    this.playerA = const Value.absent(),
    this.playerB = const Value.absent(),
    this.playerC = const Value.absent(),
    this.playerD = const Value.absent(),
    this.winner = const Value.absent(),
    this.teamALabel = const Value.absent(),
    this.teamBLabel = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  MatchesCompanion.insert({
    this.id = const Value.absent(),
    required int creatorId,
    required DateTime date,
    required String matchType,
    required String playerA,
    required String playerB,
    this.playerC = const Value.absent(),
    this.playerD = const Value.absent(),
    this.winner = const Value.absent(),
    this.teamALabel = const Value.absent(),
    this.teamBLabel = const Value.absent(),
    this.isCompleted = const Value.absent(),
  }) : creatorId = Value(creatorId),
       date = Value(date),
       matchType = Value(matchType),
       playerA = Value(playerA),
       playerB = Value(playerB);
  static Insertable<MatchData> custom({
    Expression<int>? id,
    Expression<int>? creatorId,
    Expression<DateTime>? date,
    Expression<String>? matchType,
    Expression<String>? playerA,
    Expression<String>? playerB,
    Expression<String>? playerC,
    Expression<String>? playerD,
    Expression<String>? winner,
    Expression<String>? teamALabel,
    Expression<String>? teamBLabel,
    Expression<bool>? isCompleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (creatorId != null) 'creator_id': creatorId,
      if (date != null) 'date': date,
      if (matchType != null) 'match_type': matchType,
      if (playerA != null) 'player_a': playerA,
      if (playerB != null) 'player_b': playerB,
      if (playerC != null) 'player_c': playerC,
      if (playerD != null) 'player_d': playerD,
      if (winner != null) 'winner': winner,
      if (teamALabel != null) 'team_a_label': teamALabel,
      if (teamBLabel != null) 'team_b_label': teamBLabel,
      if (isCompleted != null) 'is_completed': isCompleted,
    });
  }

  MatchesCompanion copyWith({
    Value<int>? id,
    Value<int>? creatorId,
    Value<DateTime>? date,
    Value<String>? matchType,
    Value<String>? playerA,
    Value<String>? playerB,
    Value<String?>? playerC,
    Value<String?>? playerD,
    Value<String?>? winner,
    Value<String>? teamALabel,
    Value<String>? teamBLabel,
    Value<bool>? isCompleted,
  }) {
    return MatchesCompanion(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      date: date ?? this.date,
      matchType: matchType ?? this.matchType,
      playerA: playerA ?? this.playerA,
      playerB: playerB ?? this.playerB,
      playerC: playerC ?? this.playerC,
      playerD: playerD ?? this.playerD,
      winner: winner ?? this.winner,
      teamALabel: teamALabel ?? this.teamALabel,
      teamBLabel: teamBLabel ?? this.teamBLabel,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (creatorId.present) {
      map['creator_id'] = Variable<int>(creatorId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (matchType.present) {
      map['match_type'] = Variable<String>(matchType.value);
    }
    if (playerA.present) {
      map['player_a'] = Variable<String>(playerA.value);
    }
    if (playerB.present) {
      map['player_b'] = Variable<String>(playerB.value);
    }
    if (playerC.present) {
      map['player_c'] = Variable<String>(playerC.value);
    }
    if (playerD.present) {
      map['player_d'] = Variable<String>(playerD.value);
    }
    if (winner.present) {
      map['winner'] = Variable<String>(winner.value);
    }
    if (teamALabel.present) {
      map['team_a_label'] = Variable<String>(teamALabel.value);
    }
    if (teamBLabel.present) {
      map['team_b_label'] = Variable<String>(teamBLabel.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchesCompanion(')
          ..write('id: $id, ')
          ..write('creatorId: $creatorId, ')
          ..write('date: $date, ')
          ..write('matchType: $matchType, ')
          ..write('playerA: $playerA, ')
          ..write('playerB: $playerB, ')
          ..write('playerC: $playerC, ')
          ..write('playerD: $playerD, ')
          ..write('winner: $winner, ')
          ..write('teamALabel: $teamALabel, ')
          ..write('teamBLabel: $teamBLabel, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }
}

class $MatchSetsTable extends MatchSets
    with TableInfo<$MatchSetsTable, MatchSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _matchIdMeta = const VerificationMeta(
    'matchId',
  );
  @override
  late final GeneratedColumn<int> matchId = GeneratedColumn<int>(
    'match_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES matches (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _setNumberMeta = const VerificationMeta(
    'setNumber',
  );
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
    'set_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreAMeta = const VerificationMeta('scoreA');
  @override
  late final GeneratedColumn<int> scoreA = GeneratedColumn<int>(
    'score_a',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreBMeta = const VerificationMeta('scoreB');
  @override
  late final GeneratedColumn<int> scoreB = GeneratedColumn<int>(
    'score_b',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    matchId,
    setNumber,
    scoreA,
    scoreB,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'match_sets';
  @override
  VerificationContext validateIntegrity(
    Insertable<MatchSet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('match_id')) {
      context.handle(
        _matchIdMeta,
        matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(
        _setNumberMeta,
        setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('score_a')) {
      context.handle(
        _scoreAMeta,
        scoreA.isAcceptableOrUnknown(data['score_a']!, _scoreAMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreAMeta);
    }
    if (data.containsKey('score_b')) {
      context.handle(
        _scoreBMeta,
        scoreB.isAcceptableOrUnknown(data['score_b']!, _scoreBMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreBMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MatchSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchSet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      matchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}match_id'],
      )!,
      setNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_number'],
      )!,
      scoreA: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_a'],
      )!,
      scoreB: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_b'],
      )!,
    );
  }

  @override
  $MatchSetsTable createAlias(String alias) {
    return $MatchSetsTable(attachedDatabase, alias);
  }
}

class MatchSet extends DataClass implements Insertable<MatchSet> {
  final int id;
  final int matchId;
  final int setNumber;
  final int scoreA;
  final int scoreB;
  const MatchSet({
    required this.id,
    required this.matchId,
    required this.setNumber,
    required this.scoreA,
    required this.scoreB,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_id'] = Variable<int>(matchId);
    map['set_number'] = Variable<int>(setNumber);
    map['score_a'] = Variable<int>(scoreA);
    map['score_b'] = Variable<int>(scoreB);
    return map;
  }

  MatchSetsCompanion toCompanion(bool nullToAbsent) {
    return MatchSetsCompanion(
      id: Value(id),
      matchId: Value(matchId),
      setNumber: Value(setNumber),
      scoreA: Value(scoreA),
      scoreB: Value(scoreB),
    );
  }

  factory MatchSet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchSet(
      id: serializer.fromJson<int>(json['id']),
      matchId: serializer.fromJson<int>(json['matchId']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
      scoreA: serializer.fromJson<int>(json['scoreA']),
      scoreB: serializer.fromJson<int>(json['scoreB']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchId': serializer.toJson<int>(matchId),
      'setNumber': serializer.toJson<int>(setNumber),
      'scoreA': serializer.toJson<int>(scoreA),
      'scoreB': serializer.toJson<int>(scoreB),
    };
  }

  MatchSet copyWith({
    int? id,
    int? matchId,
    int? setNumber,
    int? scoreA,
    int? scoreB,
  }) => MatchSet(
    id: id ?? this.id,
    matchId: matchId ?? this.matchId,
    setNumber: setNumber ?? this.setNumber,
    scoreA: scoreA ?? this.scoreA,
    scoreB: scoreB ?? this.scoreB,
  );
  MatchSet copyWithCompanion(MatchSetsCompanion data) {
    return MatchSet(
      id: data.id.present ? data.id.value : this.id,
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      scoreA: data.scoreA.present ? data.scoreA.value : this.scoreA,
      scoreB: data.scoreB.present ? data.scoreB.value : this.scoreB,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchSet(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('setNumber: $setNumber, ')
          ..write('scoreA: $scoreA, ')
          ..write('scoreB: $scoreB')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, matchId, setNumber, scoreA, scoreB);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchSet &&
          other.id == this.id &&
          other.matchId == this.matchId &&
          other.setNumber == this.setNumber &&
          other.scoreA == this.scoreA &&
          other.scoreB == this.scoreB);
}

class MatchSetsCompanion extends UpdateCompanion<MatchSet> {
  final Value<int> id;
  final Value<int> matchId;
  final Value<int> setNumber;
  final Value<int> scoreA;
  final Value<int> scoreB;
  const MatchSetsCompanion({
    this.id = const Value.absent(),
    this.matchId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.scoreA = const Value.absent(),
    this.scoreB = const Value.absent(),
  });
  MatchSetsCompanion.insert({
    this.id = const Value.absent(),
    required int matchId,
    required int setNumber,
    required int scoreA,
    required int scoreB,
  }) : matchId = Value(matchId),
       setNumber = Value(setNumber),
       scoreA = Value(scoreA),
       scoreB = Value(scoreB);
  static Insertable<MatchSet> custom({
    Expression<int>? id,
    Expression<int>? matchId,
    Expression<int>? setNumber,
    Expression<int>? scoreA,
    Expression<int>? scoreB,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchId != null) 'match_id': matchId,
      if (setNumber != null) 'set_number': setNumber,
      if (scoreA != null) 'score_a': scoreA,
      if (scoreB != null) 'score_b': scoreB,
    });
  }

  MatchSetsCompanion copyWith({
    Value<int>? id,
    Value<int>? matchId,
    Value<int>? setNumber,
    Value<int>? scoreA,
    Value<int>? scoreB,
  }) {
    return MatchSetsCompanion(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      setNumber: setNumber ?? this.setNumber,
      scoreA: scoreA ?? this.scoreA,
      scoreB: scoreB ?? this.scoreB,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matchId.present) {
      map['match_id'] = Variable<int>(matchId.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (scoreA.present) {
      map['score_a'] = Variable<int>(scoreA.value);
    }
    if (scoreB.present) {
      map['score_b'] = Variable<int>(scoreB.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchSetsCompanion(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('setNumber: $setNumber, ')
          ..write('scoreA: $scoreA, ')
          ..write('scoreB: $scoreB')
          ..write(')'))
        .toString();
  }
}

class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(
    Insertable<Player> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final int id;
  final String name;
  final DateTime createdAt;
  const Player({required this.id, required this.name, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory Player.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Player copyWith({int? id, String? name, DateTime? createdAt}) => Player(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
  );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PlayersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
  }) {
    return PlayersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $MatchesTable matches = $MatchesTable(this);
  late final $MatchSetsTable matchSets = $MatchSetsTable(this);
  late final $PlayersTable players = $PlayersTable(this);
  late final PlayersDao playersDao = PlayersDao(this as AppDatabase);
  late final StatsDao statsDao = StatsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    matches,
    matchSets,
    players,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('matches', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'matches',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('match_sets', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String username,
      required String email,
      required String passwordHash,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String> email,
      Value<String> passwordHash,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MatchesTable, List<MatchData>> _matchesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.matches,
    aliasName: $_aliasNameGenerator(db.users.id, db.matches.creatorId),
  );

  $$MatchesTableProcessedTableManager get matchesRefs {
    final manager = $$MatchesTableTableManager(
      $_db,
      $_db.matches,
    ).filter((f) => f.creatorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_matchesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> matchesRefs(
    Expression<bool> Function($$MatchesTableFilterComposer f) f,
  ) {
    final $$MatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matches,
      getReferencedColumn: (t) => t.creatorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableFilterComposer(
            $db: $db,
            $table: $db.matches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  Expression<T> matchesRefs<T extends Object>(
    Expression<T> Function($$MatchesTableAnnotationComposer a) f,
  ) {
    final $$MatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matches,
      getReferencedColumn: (t) => t.creatorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.matches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool matchesRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                email: email,
                passwordHash: passwordHash,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required String email,
                required String passwordHash,
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                email: email,
                passwordHash: passwordHash,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({matchesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (matchesRefs) db.matches],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (matchesRefs)
                    await $_getPrefetchedData<User, $UsersTable, MatchData>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences._matchesRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).matchesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.creatorId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool matchesRefs})
    >;
typedef $$MatchesTableCreateCompanionBuilder =
    MatchesCompanion Function({
      Value<int> id,
      required int creatorId,
      required DateTime date,
      required String matchType,
      required String playerA,
      required String playerB,
      Value<String?> playerC,
      Value<String?> playerD,
      Value<String?> winner,
      Value<String> teamALabel,
      Value<String> teamBLabel,
      Value<bool> isCompleted,
    });
typedef $$MatchesTableUpdateCompanionBuilder =
    MatchesCompanion Function({
      Value<int> id,
      Value<int> creatorId,
      Value<DateTime> date,
      Value<String> matchType,
      Value<String> playerA,
      Value<String> playerB,
      Value<String?> playerC,
      Value<String?> playerD,
      Value<String?> winner,
      Value<String> teamALabel,
      Value<String> teamBLabel,
      Value<bool> isCompleted,
    });

final class $$MatchesTableReferences
    extends BaseReferences<_$AppDatabase, $MatchesTable, MatchData> {
  $$MatchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _creatorIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.matches.creatorId, db.users.id),
  );

  $$UsersTableProcessedTableManager get creatorId {
    final $_column = $_itemColumn<int>('creator_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_creatorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MatchSetsTable, List<MatchSet>>
  _matchSetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.matchSets,
    aliasName: $_aliasNameGenerator(db.matches.id, db.matchSets.matchId),
  );

  $$MatchSetsTableProcessedTableManager get matchSetsRefs {
    final manager = $$MatchSetsTableTableManager(
      $_db,
      $_db.matchSets,
    ).filter((f) => f.matchId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_matchSetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MatchesTableFilterComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matchType => $composableBuilder(
    column: $table.matchType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playerA => $composableBuilder(
    column: $table.playerA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playerB => $composableBuilder(
    column: $table.playerB,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playerC => $composableBuilder(
    column: $table.playerC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playerD => $composableBuilder(
    column: $table.playerD,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get winner => $composableBuilder(
    column: $table.winner,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamALabel => $composableBuilder(
    column: $table.teamALabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamBLabel => $composableBuilder(
    column: $table.teamBLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get creatorId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.creatorId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> matchSetsRefs(
    Expression<bool> Function($$MatchSetsTableFilterComposer f) f,
  ) {
    final $$MatchSetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchSets,
      getReferencedColumn: (t) => t.matchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchSetsTableFilterComposer(
            $db: $db,
            $table: $db.matchSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MatchesTableOrderingComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchType => $composableBuilder(
    column: $table.matchType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playerA => $composableBuilder(
    column: $table.playerA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playerB => $composableBuilder(
    column: $table.playerB,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playerC => $composableBuilder(
    column: $table.playerC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playerD => $composableBuilder(
    column: $table.playerD,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get winner => $composableBuilder(
    column: $table.winner,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamALabel => $composableBuilder(
    column: $table.teamALabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamBLabel => $composableBuilder(
    column: $table.teamBLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get creatorId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.creatorId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get matchType =>
      $composableBuilder(column: $table.matchType, builder: (column) => column);

  GeneratedColumn<String> get playerA =>
      $composableBuilder(column: $table.playerA, builder: (column) => column);

  GeneratedColumn<String> get playerB =>
      $composableBuilder(column: $table.playerB, builder: (column) => column);

  GeneratedColumn<String> get playerC =>
      $composableBuilder(column: $table.playerC, builder: (column) => column);

  GeneratedColumn<String> get playerD =>
      $composableBuilder(column: $table.playerD, builder: (column) => column);

  GeneratedColumn<String> get winner =>
      $composableBuilder(column: $table.winner, builder: (column) => column);

  GeneratedColumn<String> get teamALabel => $composableBuilder(
    column: $table.teamALabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get teamBLabel => $composableBuilder(
    column: $table.teamBLabel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get creatorId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.creatorId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> matchSetsRefs<T extends Object>(
    Expression<T> Function($$MatchSetsTableAnnotationComposer a) f,
  ) {
    final $$MatchSetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchSets,
      getReferencedColumn: (t) => t.matchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchSetsTableAnnotationComposer(
            $db: $db,
            $table: $db.matchSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MatchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MatchesTable,
          MatchData,
          $$MatchesTableFilterComposer,
          $$MatchesTableOrderingComposer,
          $$MatchesTableAnnotationComposer,
          $$MatchesTableCreateCompanionBuilder,
          $$MatchesTableUpdateCompanionBuilder,
          (MatchData, $$MatchesTableReferences),
          MatchData,
          PrefetchHooks Function({bool creatorId, bool matchSetsRefs})
        > {
  $$MatchesTableTableManager(_$AppDatabase db, $MatchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> creatorId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> matchType = const Value.absent(),
                Value<String> playerA = const Value.absent(),
                Value<String> playerB = const Value.absent(),
                Value<String?> playerC = const Value.absent(),
                Value<String?> playerD = const Value.absent(),
                Value<String?> winner = const Value.absent(),
                Value<String> teamALabel = const Value.absent(),
                Value<String> teamBLabel = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
              }) => MatchesCompanion(
                id: id,
                creatorId: creatorId,
                date: date,
                matchType: matchType,
                playerA: playerA,
                playerB: playerB,
                playerC: playerC,
                playerD: playerD,
                winner: winner,
                teamALabel: teamALabel,
                teamBLabel: teamBLabel,
                isCompleted: isCompleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int creatorId,
                required DateTime date,
                required String matchType,
                required String playerA,
                required String playerB,
                Value<String?> playerC = const Value.absent(),
                Value<String?> playerD = const Value.absent(),
                Value<String?> winner = const Value.absent(),
                Value<String> teamALabel = const Value.absent(),
                Value<String> teamBLabel = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
              }) => MatchesCompanion.insert(
                id: id,
                creatorId: creatorId,
                date: date,
                matchType: matchType,
                playerA: playerA,
                playerB: playerB,
                playerC: playerC,
                playerD: playerD,
                winner: winner,
                teamALabel: teamALabel,
                teamBLabel: teamBLabel,
                isCompleted: isCompleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MatchesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({creatorId = false, matchSetsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (matchSetsRefs) db.matchSets],
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
                    if (creatorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.creatorId,
                                referencedTable: $$MatchesTableReferences
                                    ._creatorIdTable(db),
                                referencedColumn: $$MatchesTableReferences
                                    ._creatorIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (matchSetsRefs)
                    await $_getPrefetchedData<
                      MatchData,
                      $MatchesTable,
                      MatchSet
                    >(
                      currentTable: table,
                      referencedTable: $$MatchesTableReferences
                          ._matchSetsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MatchesTableReferences(db, table, p0).matchSetsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.matchId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MatchesTable,
      MatchData,
      $$MatchesTableFilterComposer,
      $$MatchesTableOrderingComposer,
      $$MatchesTableAnnotationComposer,
      $$MatchesTableCreateCompanionBuilder,
      $$MatchesTableUpdateCompanionBuilder,
      (MatchData, $$MatchesTableReferences),
      MatchData,
      PrefetchHooks Function({bool creatorId, bool matchSetsRefs})
    >;
typedef $$MatchSetsTableCreateCompanionBuilder =
    MatchSetsCompanion Function({
      Value<int> id,
      required int matchId,
      required int setNumber,
      required int scoreA,
      required int scoreB,
    });
typedef $$MatchSetsTableUpdateCompanionBuilder =
    MatchSetsCompanion Function({
      Value<int> id,
      Value<int> matchId,
      Value<int> setNumber,
      Value<int> scoreA,
      Value<int> scoreB,
    });

final class $$MatchSetsTableReferences
    extends BaseReferences<_$AppDatabase, $MatchSetsTable, MatchSet> {
  $$MatchSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MatchesTable _matchIdTable(_$AppDatabase db) => db.matches
      .createAlias($_aliasNameGenerator(db.matchSets.matchId, db.matches.id));

  $$MatchesTableProcessedTableManager get matchId {
    final $_column = $_itemColumn<int>('match_id')!;

    final manager = $$MatchesTableTableManager(
      $_db,
      $_db.matches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_matchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MatchSetsTableFilterComposer
    extends Composer<_$AppDatabase, $MatchSetsTable> {
  $$MatchSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreA => $composableBuilder(
    column: $table.scoreA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreB => $composableBuilder(
    column: $table.scoreB,
    builder: (column) => ColumnFilters(column),
  );

  $$MatchesTableFilterComposer get matchId {
    final $$MatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableFilterComposer(
            $db: $db,
            $table: $db.matches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatchSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $MatchSetsTable> {
  $$MatchSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreA => $composableBuilder(
    column: $table.scoreA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreB => $composableBuilder(
    column: $table.scoreB,
    builder: (column) => ColumnOrderings(column),
  );

  $$MatchesTableOrderingComposer get matchId {
    final $$MatchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableOrderingComposer(
            $db: $db,
            $table: $db.matches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatchSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatchSetsTable> {
  $$MatchSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<int> get scoreA =>
      $composableBuilder(column: $table.scoreA, builder: (column) => column);

  GeneratedColumn<int> get scoreB =>
      $composableBuilder(column: $table.scoreB, builder: (column) => column);

  $$MatchesTableAnnotationComposer get matchId {
    final $$MatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.matches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatchSetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MatchSetsTable,
          MatchSet,
          $$MatchSetsTableFilterComposer,
          $$MatchSetsTableOrderingComposer,
          $$MatchSetsTableAnnotationComposer,
          $$MatchSetsTableCreateCompanionBuilder,
          $$MatchSetsTableUpdateCompanionBuilder,
          (MatchSet, $$MatchSetsTableReferences),
          MatchSet,
          PrefetchHooks Function({bool matchId})
        > {
  $$MatchSetsTableTableManager(_$AppDatabase db, $MatchSetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> matchId = const Value.absent(),
                Value<int> setNumber = const Value.absent(),
                Value<int> scoreA = const Value.absent(),
                Value<int> scoreB = const Value.absent(),
              }) => MatchSetsCompanion(
                id: id,
                matchId: matchId,
                setNumber: setNumber,
                scoreA: scoreA,
                scoreB: scoreB,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int matchId,
                required int setNumber,
                required int scoreA,
                required int scoreB,
              }) => MatchSetsCompanion.insert(
                id: id,
                matchId: matchId,
                setNumber: setNumber,
                scoreA: scoreA,
                scoreB: scoreB,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MatchSetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({matchId = false}) {
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
                    if (matchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.matchId,
                                referencedTable: $$MatchSetsTableReferences
                                    ._matchIdTable(db),
                                referencedColumn: $$MatchSetsTableReferences
                                    ._matchIdTable(db)
                                    .id,
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

typedef $$MatchSetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MatchSetsTable,
      MatchSet,
      $$MatchSetsTableFilterComposer,
      $$MatchSetsTableOrderingComposer,
      $$MatchSetsTableAnnotationComposer,
      $$MatchSetsTableCreateCompanionBuilder,
      $$MatchSetsTableUpdateCompanionBuilder,
      (MatchSet, $$MatchSetsTableReferences),
      MatchSet,
      PrefetchHooks Function({bool matchId})
    >;
typedef $$PlayersTableCreateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> id,
      required String name,
      Value<DateTime> createdAt,
    });
typedef $$PlayersTableUpdateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> createdAt,
    });

class $$PlayersTableFilterComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PlayersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayersTable,
          Player,
          $$PlayersTableFilterComposer,
          $$PlayersTableOrderingComposer,
          $$PlayersTableAnnotationComposer,
          $$PlayersTableCreateCompanionBuilder,
          $$PlayersTableUpdateCompanionBuilder,
          (Player, BaseReferences<_$AppDatabase, $PlayersTable, Player>),
          Player,
          PrefetchHooks Function()
        > {
  $$PlayersTableTableManager(_$AppDatabase db, $PlayersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlayersCompanion(id: id, name: name, createdAt: createdAt),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlayersCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayersTable,
      Player,
      $$PlayersTableFilterComposer,
      $$PlayersTableOrderingComposer,
      $$PlayersTableAnnotationComposer,
      $$PlayersTableCreateCompanionBuilder,
      $$PlayersTableUpdateCompanionBuilder,
      (Player, BaseReferences<_$AppDatabase, $PlayersTable, Player>),
      Player,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$MatchesTableTableManager get matches =>
      $$MatchesTableTableManager(_db, _db.matches);
  $$MatchSetsTableTableManager get matchSets =>
      $$MatchSetsTableTableManager(_db, _db.matchSets);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
}
