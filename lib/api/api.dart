import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = "http://10.10.11.226:8000";

  Future<Map<String, dynamic>> login(email, password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/user/token/"),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    Map<String, dynamic> data;
    if(response.statusCode == 200){
      data =  {'status': "success", 'token': jsonDecode(response.body)["token"]};
      return data;
    }else{
      data = {'status': "error"};
      return data;
    }
  }
}