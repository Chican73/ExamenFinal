import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String _baseUrl = '143.198.118.203:8100';
  static const String _user = 'test';
  static const String _pass = 'test2023';
  static const Duration _timeout = Duration(seconds: 15);

  static Map<String, String> get _headers => {
    'authorization': 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}',
    'Content-Type': 'application/json; charset=UTF-8',
  };

  /// Hace un GET y devuelve la lista de registros que venga en la respuesta.
    static Future<List<Map<String, dynamic>>> getLista(String path) async {
    final url = Uri.http(_baseUrl, path);
    final response = await http.get(url, headers: _headers).timeout(_timeout);
    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}');
    }
    final data = json.decode(utf8.decode(response.bodyBytes));
    return _buscarLista(
      data,
    ).whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
  }

  /// Hace un POST con el json del enunciado. Devuelve true si salió bien.
  static Future<bool> post(String path, Map<String, dynamic> body) async {
    try {
      final response = await http
          .post(
            Uri.http(_baseUrl, path),
            body: json.encode(body),
            headers: _headers,
          )
          .timeout(_timeout);
      debugPrint('POST $path ${json.encode(body)} -> ${response.statusCode}');
      debugPrint(response.body);
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      debugPrint('Error en $path: $e');
      return false;
    }
  }

    static List<dynamic> _buscarLista(dynamic data) {
    if (data is List) return data;
    if (data is Map) {
      if (data['Listado'] is List) return data['Listado'];
      for (final valor in data.values) {
        if (valor is List) return valor;
      }
    }
    return [];
  }
}
