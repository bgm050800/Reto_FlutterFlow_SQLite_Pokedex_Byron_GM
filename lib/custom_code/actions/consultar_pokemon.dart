// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Importa la biblioteca para trabajar con bases de datos SQLite en Dart
import 'package:sqflite/sqflite.dart';

// Importa la biblioteca para manipulación de rutas de archivo y directorio
import 'package:path/path.dart';

// Importa la biblioteca para obtener el directorio de almacenamiento local en Dart
import 'package:path_provider/path_provider.dart';

// Importa la biblioteca para manejar operaciones asíncronas en Dart
import 'dart:async';

// Importar custom action para el manejo de las alertas
import '/custom_code/actions/alertas.dart';

// Funcion de prueba para consultar la informacion de la Pokedex
Future<void> consultarPokemon(BuildContext context) async {
  // Obtener la ruta del directorio de la base de datos
  var databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'poke_data.db');

  // Abrir la conexión a la base de datos
  Database database = await openDatabase(dbPath, version: 1);

  // Consulta SQL
  String query = '''
    SELECT 
        p.id, 
        p.name, 
        p.type1, 
        pt1.colores AS type1_colors, 
        p.type2, 
        pt2.colores AS type2_colors,
        p.imagen
    FROM 
        pokemon p
    LEFT OUTER JOIN 
        pokemon_tipos pt1 ON p.type1 = pt1.types
    LEFT OUTER JOIN 
        pokemon_tipos pt2 ON p.type2 = pt2.types;
  ''';

  // Ejecutar la consulta
  List<Map<String, dynamic>> result = await database.rawQuery(query);

  // Construir el mensaje de la alerta
  String mensaje = '';
  result.forEach((row) {
    mensaje +=
        'ID: ${row['id']}, Name: ${row['name']}, Type 1: ${row['type1']}, Type 1 Colors: ${row['type1_colors']}, Type 2: ${row['type2']}, Type 2 Colors: ${row['type2_colors']}, Image: ${row['imagen']}\n';
  });

  // Mostrar la alerta con la información
  await mostrarAlerta(context, mensaje, Colors.blue);

  // Cerrar la conexión a la base de datos
  await database.close();
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
