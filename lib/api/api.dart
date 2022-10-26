import 'package:doctor/api/storage.dart';
import 'package:doctor/model/patient.dart';
import 'package:doctor/model/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:doctor/model/signup.dart';
import 'dart:io' as Io;

import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = "http://10.10.11.226:8000";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String token = "";

  void initState() {
    token = "";
  }

  Future<void> setToken(token) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('token', "Token " + token);
  }
  getToken() async{
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('token') ?? "";
  }

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
      await setToken(jsonDecode(response.body)["token"]);
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

  Future<Map<String, dynamic>> emailVerify(email) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/user/emailverify/"),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'email': email}),
    );
    Map<String, dynamic> result;
    if(response.statusCode == 201){
      result = {'status': "success","data":jsonDecode(response.body)};
      return result;
    }else{

      result = {'status': "error","message":jsonDecode(response.body)};
      return result;
    }
  }

  Future<Map<String, dynamic>> emailTokenVerify(email_token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/user/email/verify/$email_token"),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    print("==========================");
    print(response.statusCode);
    print("==========================");
    Map<String, dynamic> result;
    if(response.statusCode == 200){
      result = {'status': "success","data":jsonDecode(response.body)};
      return result;
    }else{
      result = {'status': "error","message":jsonDecode(response.body)};
      return result;
    }
  }

  Future<Object?> getProfile() async {
    token = await getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/api/user/me/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
    );
    Map<String, String> result;
    if(response.statusCode == 200){
      return response.body;
      result = {'status': "success",'data': response.body};
      return result;
    }else{
      return null;
      result = {'status': "error","message":response.body};
      return result;
    }
  }

  Future<Map<String, dynamic>> changePassword(oldPassword, newPassword, newPasswordConfirm)async {
    token = await getToken();
    final response = await http.put(
      Uri.parse("$baseUrl/api/user/changepwd/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
      body: jsonEncode({
        'old_password': oldPassword,
        'new_password': newPassword,
        'new_password_confirm': newPasswordConfirm,
      }),
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
    token = await getToken();
    final response = await http.patch(
      Uri.parse("$baseUrl/api/user/me/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
      body: ProfileFormToJson(data),
    );
    Map<String, dynamic> result;
    if(response.statusCode == 200){
      result = {'status': "success"};
      return result;
    }else{
      result = {'status': "error","message":response.body};
      return result;
    }
  }

  Future<List<PatientForm>?> getPatients() async{
    token = await getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/api/patients/patientss/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
    );
    if(response.statusCode == 200){
      return PatientFormFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<Object?> getPatient(id)async{
    token = await getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/api/patients/patientss/$id"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
    );
    Map<String, dynamic> result;
    if(response.statusCode == 200){
      return response.body;
      result = {'status': "success",'data': jsonDecode(response.body)};
      return result;
    }else{
      return null;
      result = {'status': "error","message":jsonDecode(response.body)};
      return result;
    }
  }

  Future<Map<String, dynamic>> addPatient(PatientForm data)async{
    token = await getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/api/patients/patientss/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
      body: PatientFormToJson(data),
    );
    Map<String, dynamic> result;
    if(response.statusCode == 201){
      result = {'status': "success", 'id': jsonDecode(response.body)["id"]};
      print(jsonDecode(response.body)["id"]);
      return result;
    }else{
      result = {'status': "error", 'message': jsonDecode(response.body)};
      return result;
    }
  }

  Future<Map<String, dynamic>> updatePatient(id, PatientForm data)async{
    print(id);
    print(PatientFormToJson(data).runtimeType);
    token = await getToken();
    final response = await http.put(
      Uri.parse("$baseUrl/api/patients/patientss/$id/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
      body: PatientFormToJson(data),
    );
    Map<String, dynamic> result;
    if(response.statusCode == 200){
      result = {'status': "success", 'id': jsonDecode(response.body)["id"]};
      print(jsonDecode(response.body)["id"]);
      return result;
    }else{
      print(response.statusCode);
      print(response.body);
      result = {'status': "error", 'message': jsonDecode(response.body)};
      return result;
    }
  }

  Future<bool> deletePatient(id)async{
    token = await getToken();
    final response = await http.delete(
      Uri.parse("$baseUrl/api/patients/all/$id/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      },
    );
    debugPrint(jsonEncode(response.statusCode));
    debugPrint(jsonEncode(response.body));
    if(response.statusCode == 204){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> uploadImageFiles(data, id)async {
    token = await getToken();
      final uri = Uri.parse("$baseUrl/api/patients/patientss/$id/upload-image/");
      for (var index = 0; index < data.length; index++) {
        var request = http.MultipartRequest('POST', uri);
        var headers = {
          'Authorization': token
        };
        request.headers.addAll(headers);
        request.files.add(await http.MultipartFile(
            'image_lists',
            Io.File(data[index].path).readAsBytes().asStream(),
            Io.File(data[index].path).lengthSync(),
            filename: data[index].path
                .split("/")
                .last
        ));
        var response = await request.send();
      }
      return true;
  }
}