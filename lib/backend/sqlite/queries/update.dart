import 'package:sqflite/sqflite.dart';

/// BEGIN INSERTTIPOS
Future performInsertTipos(
  Database database,
) {
  const query = '''
INSERT INTO pokemon_tipos (types, colores, imagentypeurl)
VALUES ('acero', '#B8B8D0', 'http://www.rw-designer.com/icon-view/21180-256x256x8-256x256x8.png');

''';
  return database.rawQuery(query);
}

/// END INSERTTIPOS
