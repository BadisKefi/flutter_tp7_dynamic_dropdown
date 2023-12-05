import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:flutter_7/entities/Student.dart';
import 'package:flutter_7/entities/matiere.dart';
import 'package:flutter_7/entities/student.dart';

Future getAllMatieres() async {
  Response response =
      await http.get(Uri.parse("http://192.168.31.215:8081/matiere/all"));
  return jsonDecode(response.body);
}

Future deleteMatiere(int id) {
  return http
      .delete(Uri.parse("http://192.168.31.215:8081/matiere/delete?id=${id}"));
}

Future addMatiere(Matiere matiere) async {
  Response response = await http.post(
      Uri.parse("http://192.168.31.215:8081/matiere/add"),
      headers: {"Content-type": "Application/json"},
      body: jsonEncode(<String, dynamic>{
        "intMat": matiere.intMat,
        "description": matiere.description
      }));

  return response.body;
}

Future updateMatiere(Matiere matiere) async {
  Response response =
      await http.put(Uri.parse("http://192.168.31.215:8081/matiere/update"),
          headers: {"Content-type": "Application/json"},
          body: jsonEncode(<String, dynamic>{
            "codMat": matiere.codMat,
            "intMat": matiere.intMat,
            "description": matiere.description
          }));

  return response.body;
}
