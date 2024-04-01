// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Importa la biblioteca para manejar operaciones asíncronas en Dart
import 'dart:async';

Future<void> alertas(BuildContext context) async {
  // Esta función no realiza ninguna acción específica,
  // simplemente está aquí para envolver la función mostrarAlerta
  // y hacerla accesible como una acción en FlutterFlow.
}

Future<void> mostrarAlerta(
    BuildContext context, String mensaje, Color color) async {
  Completer<void> completer = Completer<void>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: color,
        title: Text(
          mensaje,
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              completer
                  .complete(); // Completa el Future cuando se presiona el botón "Cerrar"
            },
            child: Text(
              'Cerrar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );

  await completer.future; // Espera hasta que se complete el Future
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
