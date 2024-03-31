import '/flutter_flow/flutter_flow_util.dart';
import 'insertar_datos_pokemon_widget.dart' show InsertarDatosPokemonWidget;
import 'package:flutter/material.dart';

class InsertarDatosPokemonModel
    extends FlutterFlowModel<InsertarDatosPokemonWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
