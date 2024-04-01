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
  Database database, {
  int? filtroGeneracion,
}) {
  final query = '''
-- Selects data from the pokemon table along with colors of primary and secondary types from the pokemon_tipos table / Selecciona datos de la tabla pokemon junto con los colores de los tipos primario y secundario de la tabla pokemon_tipos
SELECT 
    p.id, -- Pokémon ID / ID del Pokémon
    p.name, -- Pokémon name / Nombre del Pokémon
    p.type1, -- Primary type of the Pokémon / Tipo primario del Pokémon
    p.type2, -- Secondary type of the Pokémon / Tipo secundario del Pokémon
    CASE 
        WHEN p.id < 10 THEN '00' || CAST(p.id AS TEXT)
        WHEN p.id < 100 THEN '0' || CAST(p.id AS TEXT)
        ELSE CAST(p.id AS TEXT)
    END AS idDex, -- Formatted Pokédex number / Número de Pokédex formateado
    CAST(p.generacion AS TEXT) as generacion, -- Pokémon generation / Generación Pokémon
    p.firstability,   -- Primary ability of the Pokémon / Habilidad primaria del Pokémon
    p.secondability, -- Secondary ability of the Pokémon / Habilidad secundaria del Pokémon
    p.imagen as sprite, -- Pokémon sprite / Sprite del Pokémon
    t1.colores AS type1colors, -- Colors of the primary type / Colores del tipo primario
    t2.colores AS type2colors -- Colors of the secondary type / Colores del tipo secundario
FROM 
    pokemon p -- Pokémon table / Tabla de Pokémon
LEFT OUTER JOIN
    pokemon_tipos t1 ON p.type1 = t1.types
LEFT OUTER JOIN
    pokemon_tipos t2 ON p.type2 = t2.types
WHERE
    p.generacion = $filtroGeneracion; -- Filter Pokémon of generation 1 / Filtrar Pokémon de la primera generación

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
  String get type1colors => data['type1colors'] as String;
  String get type2colors => data['type2colors'] as String;
}

/// END SELECTPOKEDEXDATA

/// BEGIN LISTARGENERACIONES
Future<List<ListarGeneracionesRow>> performListarGeneraciones(
  Database database,
) {
  const query = '''
-- Selects data from the pokemon_generacion table / Selecciona datos de la tabla pokemon_generacion
SELECT 
    gamegeneracion, -- Generation of the Pokémon game / Generación del juego de Pokémon
    region, -- Region of the Pokémon game / Región del juego de Pokémon
    gameversion -- Version of the Pokémon game / Versión del juego de Pokémon
FROM 
    pokemon_generacion;

''';
  return _readQuery(database, query, (d) => ListarGeneracionesRow(d));
}

class ListarGeneracionesRow extends SqliteRow {
  ListarGeneracionesRow(super.data);

  int get gamegeneracion => data['gamegeneracion'] as int;
  String get region => data['region'] as String;
  String get gameversion => data['gameversion'] as String;
}

/// END LISTARGENERACIONES
