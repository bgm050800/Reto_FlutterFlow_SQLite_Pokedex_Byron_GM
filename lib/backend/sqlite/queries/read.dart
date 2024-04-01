import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN SELECTPOKEDEXDATA
Future<List<SelectPokedexDataRow>> performSelectPokedexData(
  Database database,
) {
  const query = '''
SELECT 
    p.id, -- Pokémon ID / ID del Pokémon
    p.name, -- Pokémon name / Nombre del Pokémon
    p.type1, -- Primary type of the Pokémon / Tipo primario del Pokémon
    p.type2, -- Secondary type of the Pokémon / Tipo secundario del Pokémon
    CASE
        WHEN p.id < 10 THEN '00' || CAST(p.id AS TEXT) -- Builds idDex with prefix '00' for IDs less than 10 / Construye idDex con el prefijo '00' para IDs menores a 10
        WHEN p.id < 100 THEN '0' || CAST(p.id AS TEXT) -- Builds idDex with prefix '0' for IDs less than 100 / Construye idDex con el prefijo '0' para IDs menores a 100
        ELSE CAST(p.id AS TEXT) -- Builds idDex without prefix for IDs greater than or equal to 100 / Construye idDex sin prefijo para IDs mayores o iguales a 100
    END AS idDex,-- Formatted Pokédex number / Número de Pokédex formateado
    CAST(p.generacion AS TEXT) as generacion, -- Pokémon generation / Generación Pokémon
    p.firstability,   -- Primary ability of the Pokémon / Habilidad primaria del Pokémon
    p.secondability, -- Secondary ability of the Pokémon / Habilidad secundaria del Pokémon
    'https://assets.pokemon.com/assets/cms2/img/pokedex/detail/252.png' as sprite
FROM 
    pokemon p -- Pokémon table / Tabla de Pokémon

''';
  return _readQuery(database, query, (d) => SelectPokedexDataRow(d));
}

class SelectPokedexDataRow extends SqliteRow {
  SelectPokedexDataRow(super.data);

  int get id => data['id'] as int;
  String get name => data['name'] as String;
  String get type1 => data['type1'] as String;
  String get type2 => data['type2'] as String;
  String get idDex => data['idDex'] as String;
  String get generacion => data['generacion'] as String;
  String get firstability => data['firstability'] as String;
  String get secondability => data['secondability'] as String;
  String get sprite => data['sprite'] as String;
}

/// END SELECTPOKEDEXDATA
