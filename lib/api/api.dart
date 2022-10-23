import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:doctor/model/signup.dart';

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
    Map<String, dynamic> result;
    if(response.statusCode == 200){
      result =  {'status': "success", 'token': jsonDecode(response.body)["token"]};
      return result;
    }else{
      result = {'status': "error"};
      return result;
    }
  }

  Future<Map<String, dynamic>> signup(SignupForm data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/user/create/"),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: SignupFormToJson(data),
    );
    Map<String, dynamic> result;
    if(response.statusCode == 201){
      result = {'status': "success"};
      return result;
    }else{
      result = {'status': "error","messge":response.body};
      return result;
    }
  }

}