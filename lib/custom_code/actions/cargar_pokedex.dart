// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/alertas.dart';

Future<bool> cargarPokedex(BuildContext context) async {
  try {
    // Cargar generaciones
    bool generacionesCargadas = await cargarGeneraciones(context);
    if (!generacionesCargadas) return false;

    // Cargar tipos
    bool tiposCargados = await cargarTipos(context);
    if (!tiposCargados) return false;

    // Cargar habilidades
    bool habilidadesCargadas = await cargarHabilidades(context);
    if (!habilidadesCargadas) return false;

    // Cargar Pokémon
    bool cargarPokemonCargados = await cargarPokemon(context);
    if (!cargarPokemonCargados) return false;

    // Mostrar mensaje de bienvenida después de cargar todo
    await mostrarAlerta(
        context,
        'Todos los datos de la Pokédex han sido cargados. ¡Bienvenido al mundo Pokémon!',
        Colors.green);

    // Cambiar el estado de validarCargaCompleta a true usando FFAppState
    FFAppState().update(() {
      FFAppState().validarCargaCompleta = true;
    });

    // Si todos los datos se cargaron correctamente, devolver true
    return true;
  } catch (e) {
    // Mostrar alerta roja si ocurre algún error
    await mostrarAlerta(
        context, 'Error al cargar los datos de la Pokédex: $e', Colors.red);
    print('Error al cargar los datos de la Pokédex: $e');
    // Si ocurre un error, devolver false
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
