import 'dart:async';

import 'package:projeto_restaurante/Model/usuario.dart';
import 'package:projeto_restaurante/api_response.dart';
import 'package:projeto_restaurante/firebase/firebase_service.dart';


class LoginBloc {
  final _streamController = StreamController<bool>();

  get stream => _streamController.stream;

  Future<ApiResponse> login(String email, String senha) async {

    _streamController.add(true);

    ApiResponse response = await FirebaseService().login(email, senha);

    _streamController.add(false);

    return response;
  }

  void dispose() {
    _streamController.close();
  }
}