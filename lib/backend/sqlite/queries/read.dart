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
SELECT 
    p.id, 
    p.name, 
    p.type1, 
    pt1.colores AS type1_colors, 
    p.type2, 
    pt2.colores AS type2_colors, 
    p.firstability, 
    ph1.abilitydescription AS firstability_description, 
    p.secondability, 
    ph2.abilitydescription AS secondability_description, 
    p.weight, 
    p.height, 
    p.dexdescription, 
    p.generacion,
    pg.region, 
    pg.gameversion,
    pt1.imagentypeurl AS type1_image_url, 
    pt2.imagentypeurl AS type2_image_url,
    p.imagen
FROM 
    pokemon p
LEFT OUTER JOIN 
    pokemon_generacion pg ON p.generacion = pg.gamegeneracion
LEFT OUTER JOIN 
    pokemon_habilidades ph1 ON p.firstability = ph1.ability
LEFT OUTER JOIN 
    pokemon_habilidades ph2 ON p.secondability = ph2.ability
LEFT OUTER JOIN 
    pokemon_tipos pt1 ON p.type1 = pt1.types
LEFT OUTER JOIN 
    pokemon_tipos pt2 ON p.type2 = pt2.types;

''';
  return _readQuery(database, query, (d) => SelectPokemonDataRow(d));
}

class SelectPokemonDataRow extends SqliteRow {
  SelectPokemonDataRow(super.data);

  int get id => data['id'] as int;
  String get name => data['name'] as String;
  String get type1 => data['type1'] as String;
  String get type1colors => data['type1colors'] as String;
  String get type2 => data['type2'] as String;
  String get type2colors => data['type2colors'] as String;
  String get firstability => data['firstability'] as String;
  String get firstabilitydescription =>
      data['firstabilitydescription'] as String;
  String get secondability => data['secondability'] as String;
  String get secondabilitydescription =>
      data['secondabilitydescription'] as String;
  double get weight => data['weight'] as double;
  double get height => data['height'] as double;
  String get dexdescription => data['dexdescription'] as String;
  int get generacion => data['generacion'] as int;
  String get region => data['region'] as String;
  String get gameversion => data['gameversion'] as String;
  String get type1imageurl => data['type1imageurl'] as String;
  String get type2imageurl => data['type2imageurl'] as String;
  String get imagen => data['imagen'] as String;
}

/// END SELECTPOKEMONDATA

/// BEGIN SELECTTIPOS
Future<List<SelectTiposRow>> performSelectTipos(
  Database database,
) {
  const query = '''
SELECT 
    types,
    colores,
    imagentypeurl
FROM 
    pokemon_tipos

''';
  return _readQuery(database, query, (d) => SelectTiposRow(d));
}

class SelectTiposRow extends SqliteRow {
  SelectTiposRow(super.data);

  String get types => data['types'] as String;
  String get colores => data['colores'] as String;
  String get imagentypeurl => data['imagentypeurl'] as String;
}

/// END SELECTTIPOS

/// BEGIN SELECTPOKEDEXDATA
Future<List<SelectPokedexDataRow>> performSelectPokedexData(
  Database database,
) {
  const query = '''
SELECT 
    p.id, 
    p.name, 
    p.type1,
    p.type2
FROM 
    pokemon p

''';
  return _readQuery(database, query, (d) => SelectPokedexDataRow(d));
}

class SelectPokedexDataRow extends SqliteRow {
  SelectPokedexDataRow(super.data);

  int get id => data['id'] as int;
  String get name => data['name'] as String;
  String get type1 => data['type1'] as String;
  String get type2 => data['type2'] as String;
}

/// END SELECTPOKEDEXDATA
