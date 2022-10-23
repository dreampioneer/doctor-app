import 'dart:convert';

import 'package:doctor/model/signup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:doctor/api/api.dart';
import 'package:doctor/login/login.dart';
import 'package:select_form_field/select_form_field.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isLoading = false;
  bool _isFieldFirstNameValid = false;
  bool _isFieldLastNameValid = false;
  bool _isFieldEmailValid = false;
  bool _isFieldPasswordValid = false;
  bool _isFieldRePasswordValid = false;
  bool _isFieldDepartmentValid = false;
  bool _isFieldGenderValid = false;
  bool _isFieldRoleValid = false;

  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerRePassword = TextEditingController();
  final TextEditingController _controllerDepartment = TextEditingController();
  String _controllerGender = "";
  String _controllerRole = "";

  final List<Map<String, dynamic>> _genderItems = [
    {
      'value': 'Male',
      'label': 'Male',
    },
    {
      'value': 'Female',
      'label': 'Female',
    },
    {
      'value': 'Transgender',
      'label': 'Transgender',
    },
    {
      'value': 'Non-binary/non-conforming',
      'label': 'Non-binary/non-conforming',
    },
    {
      'value': 'Prefer not to respond',
      'label': 'Prefer not to respond',
    },
  ];

  final List<Map<String, dynamic>> _roleItems = [
    {
      'value': 'Doctor',
      'label': 'Doctor',
    },
    {
      'value': 'Nurse',
      'label': 'Nurse',
    },
    {
      'value': 'Transgender',
      'label': 'Transgender',
    },
    {
      'value': 'Physical Therapist',
      'label': 'Physical Therapist',
    },
  ];

  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // key: _scaffoldState,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Signup Form",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildTextFieldFirstName(),
                  _buildTextFieldLastName(),
                  _buildTextFieldEmail(),
                  _buildTextFieldPassword(),
                  _buildTextFieldRePassword(),
                  _buildTextFieldDepartment(),
                  _buildSelectFieldGender(),
                  _buildSelectFieldRole(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: FloatingActionButton.extended(
                      label: Text(
                        "sign up".toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (
                            !_isFieldFirstNameValid ||
                            !_isFieldLastNameValid ||
                            !_isFieldEmailValid ||
                            !_isFieldPasswordValid ||
                            !_isFieldRePasswordValid ||
                            !_isFieldDepartmentValid ||
                            !_isFieldGenderValid ||
                            !_isFieldRoleValid
                        ) {
                          return;
                        }
                        setState(() => _isLoading = true);
                        String first_name = _controllerFirstName.text;
                        String last_name = _controllerLastName.text;
                        String email = _controllerEmail.text;
                        String password = _controllerPassword.text;
                        int department_id = int.parse(_controllerDepartment.text);
                        String gender = _controllerGender;
                        String role = _controllerRole;
                        SignupForm signupForm = SignupForm(
                          first_name: first_name,
                          last_name: last_name,
                          email: email,
                          password: password,
                          department_id: department_id,
                          gender: gender,
                          role: role
                        );
                        _apiService.signup(signupForm).then((response) {
                          print(jsonEncode(response));
                          if(response["status"] == "success"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                            final snackBar = SnackBar(
                              content: const Text('Sign Up Successfully!'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );

                            // Find the ScaffoldMessenger in the widget tree
                            // and use it to show a SnackBar.
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                          if(response["status"] == "error"){

                          }
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: FloatingActionButton.extended(
                      label: Text(
                        "login".toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        setState(() => _isLoading = true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            // _isLoading
            //     ? Stack(
            //   children: [
            //     const Opacity(
            //       opacity: 0.3,
            //       child: const ModalBarrier(
            //         dismissible: false,
            //         color: Colors.grey,
            //       ),
            //     ),
            //     const Center(
            //       child: const CircularProgressIndicator(),
            //     ),
            //   ],
            // )
            //     : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldFirstName() {
    return TextField(
      controller: _controllerFirstName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "First Name",
        errorText: _isFieldFirstNameValid
            ? null
            : "First Name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldFirstNameValid) {
          setState(() => _isFieldFirstNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldLastName() {
    return TextField(
      controller: _controllerLastName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Last Name",
        errorText: _isFieldLastNameValid
            ? null
            : "Last Name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldLastNameValid) {
          setState(() => _isFieldLastNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldEmail() {
    return TextField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        errorText: _isFieldEmailValid
            ? null
            : "Email is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldPassword() {
    return TextField(
      controller: _controllerPassword,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        errorText: _isFieldPasswordValid
            ? null
            : "Password is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldPasswordValid) {
          setState(() => _isFieldPasswordValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldRePassword() {
    return TextField(
      controller: _controllerRePassword,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Re-type Password",
        errorText: _isFieldRePasswordValid
            ? null
            : "Re-type Password is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldRePasswordValid) {
          setState(() => _isFieldRePasswordValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldDepartment() {
    return TextField(
      controller: _controllerDepartment,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Department",
        errorText: _isFieldDepartmentValid
            ? null
            : "Department is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldDepartmentValid) {
          setState(() => _isFieldDepartmentValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildSelectFieldGender() {
    return SelectFormField(
      type: SelectFormFieldType.dropdown, // or can be dialog
      initialValue: 'circle',
      labelText: 'Gender',
      decoration: InputDecoration(
        labelText: "Select Gender",
        errorText: _isFieldGenderValid
            ? null
            : "Gender is required",
      ),
      items: _genderItems,
      onChanged: (val) => {
        _isFieldGenderValid = true,
        _controllerGender = val
      },
      onSaved: (val) => print(val),
    );
  }

  Widget _buildSelectFieldRole() {
    return SelectFormField(
      type: SelectFormFieldType.dropdown, // or can be dialog
      initialValue: 'circle',
      labelText: 'Role',
      decoration: InputDecoration(
        labelText: "Select Role",
        errorText: _isFieldRoleValid
            ? null
            : "Role is required",
      ),
      items: _roleItems,
      onChanged: (val) => {
        _isFieldRoleValid = true,
        _controllerRole = val
      },
      onSaved: (val) => print(val),
    );
  }
}