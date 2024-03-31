// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:convert';
import 'dart:io'; // Importar la clase File
import 'package:csv/csv.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

// Importar custom action para el manejo de las alertas
import '/custom_code/actions/alertas.dart';

Future<bool> cargarHabilidades(BuildContext context) async {
  try {
    // Obtener la ruta del directorio de la base de datos
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'pokeData');

    // Abrir la base de datos
    Database database = await openDatabase(dbPath);

    // Verificar si la tabla existe, y si no, crearla
    bool tablaExiste = await existeTabla(database, 'pokemon_habilidades');
    if (!tablaExiste) {
      await database.execute('''CREATE TABLE pokemon_habilidades (
            ability TEXT PRIMARY KEY NOT NULL,
            abilitydescription TEXT NOT NULL
          )''');
    }

    await mostrarAlerta(context, 'Cargar habilidades', Colors.blue);

    // Solicitar al usuario que seleccione un archivo CSV
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null && result.files.isNotEmpty) {
      // Leer el archivo CSV seleccionado por el usuario
      PlatformFile file = result.files.first;
      String csvString = await File(file.path!).readAsString();
      List<List<dynamic>> csvTable = CsvToListConverter().convert(csvString);

      // Insertar datos en la tabla
      Batch batch = database.batch();
      for (int i = 1; i < csvTable.length; i++) {
        batch.insert(
          'pokemon_habilidades',
          {
            'ability': csvTable[i][0],
            'abilitydescription': csvTable[i][1],
          },
        );
      }
      await batch.commit();

      // Mostrar alerta verde
      await mostrarAlerta(context, 'Carga exitosa', Colors.green);
      return true; // Indicar que la carga fue exitosa
    } else {
      // Usuario canceló la selección
      await mostrarAlerta(
          context, 'No se seleccionó ningún archivo', Colors.red);
      return false; // Indicar que la carga no fue exitosa
    }
  } catch (e) {
    // Mostrar alerta roja solo si no es un error de violación de clave primaria
    if (e.toString().contains('UNIQUE constraint failed')) {
      // Si se produce un error por violación de la clave primaria,
      // mostrar mensaje indicando que las habilidades ya están cargadas
      await mostrarAlerta(
          context, 'Las habilidades ya están cargadas', Colors.green);
      return true; // Indicar que la carga fue exitosa (ya que los datos ya están cargados)
    } else {
      // Mostrar alerta roja si ocurre otro tipo de error
      await mostrarAlerta(
          context, 'Error al cargar habilidades: $e', Colors.red);
      print('Error al cargar habilidades: $e');
      return false; // Indicar que la carga no fue exitosa
    }
  }
}

Future<bool> existeTabla(Database db, String tabla) async {
  var res = await db.rawQuery(
      "SELECT * FROM sqlite_master WHERE type = 'table' AND name = '$tabla'");
  return res.isNotEmpty;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
