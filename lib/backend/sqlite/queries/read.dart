import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN SELECTPOKEMONDATA
Future<List<SelectPokemonDataRow>> performSelectPokemonData(
  Database database,
) {
  const query = '''
SELECT * FROM pokemon;

''';
  return _readQuery(database, query, (d) => SelectPokemonDataRow(d));
}

class SelectPokemonDataRow extends SqliteRow {
  SelectPokemonDataRow(super.data);
}

/// END SELECTPOKEMONDATA
