import 'package:doctor/model/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:doctor/model/signup.dart';

class ApiService {
  final String baseUrl = "http://10.10.11.226:8000";
  static const token = "Token b2e4f32720c5425730dd5dec0b8ed487d8a861e5";
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
      result = {'status': "error","message":response.body};
      return result;
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/user/me/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
    );
    Map<String, dynamic> result;
    if(response.statusCode == 200){
      result = {'status': "success",'data': jsonDecode(response.body)};
      return result;
    }else{
      result = {'status': "error","message":jsonDecode(response.body)};
      return result;
    }
  }
  Future<Map<String, dynamic>> saveProfile(ProfileForm data) async{
    final response = await http.patch(
      Uri.parse("$baseUrl/api/user/me/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
      body: ProfileFormToJson(data),
    );
    Map<String, dynamic> result;
    print(ProfileFormToJson(data));
    print(jsonEncode(response.body));
    if(response.statusCode == 200){
      result = {'status': "success"};
      return result;
    }else{
      result = {'status': "error","message":response.body};
      return result;
    }
  }
}