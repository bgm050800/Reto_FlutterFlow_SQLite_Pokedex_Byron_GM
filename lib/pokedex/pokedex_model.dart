import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'pokedex_widget.dart' show PokedexWidget;
import 'package:flutter/material.dart';

class PokedexModel extends FlutterFlowModel<PokedexWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for listaGeneraciones widget.
  int? listaGeneracionesValue;
  FormFieldController<int>? listaGeneracionesValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
