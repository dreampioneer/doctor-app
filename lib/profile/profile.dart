import 'dart:convert';

import 'package:doctor/api/api.dart';
import 'package:doctor/components/navigation_bar.dart';
import 'package:doctor/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isLoading = false;
  bool _isFieldFirstNameValid = false;
  bool _isFieldLastNameValid = false;
  bool _isFieldEmailValid = false;
  bool _isFieldDepartmentValid = false;
  bool _isFieldGenderValid = false;
  bool _isFieldRoleValid = false;

  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerDepartment = TextEditingController();
  final TextEditingController _controllerGender = TextEditingController();
  final TextEditingController _controllerRole = TextEditingController();

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
    _isFieldFirstNameValid = true;
    _isFieldLastNameValid = true;
    _isFieldEmailValid = true;
    _isFieldDepartmentValid = true;
    _isFieldGenderValid = true;
    _isFieldRoleValid = true;
    _apiService.getProfile().then((response) => {
      _controllerFirstName.text = response["data"]["first_name"],
      _controllerLastName.text = response["data"]["last_name"],
      _controllerEmail.text = response["data"]["email"],
      _controllerDepartment.text = response["data"]["department_id"].toString(),
      _controllerRole.text = response["data"]["role"],
      _controllerGender.text = response["data"]["gender"],
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            (widget.title)
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
                    _buildTextFieldDepartment(),
                    _buildSelectFieldGender(),
                    _buildSelectFieldRole(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FloatingActionButton.extended(
                        label: Text(
                          "save".toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          if (
                          !_isFieldFirstNameValid ||
                              !_isFieldLastNameValid ||
                              !_isFieldEmailValid ||
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
                          int department_id = int.parse(_controllerDepartment.text);
                          String gender = _controllerGender.text;
                          String role = _controllerRole.text;
                          ProfileForm profileForm = ProfileForm(
                              first_name: first_name,
                              last_name: last_name,
                              email: email,
                              department_id: department_id,
                              gender: gender,
                              role: role
                          );
                          _apiService.saveProfile(profileForm).then((response) {
                            print(jsonEncode(response["status"]));
                            if(response["status"] == "success"){
                              final snackBar = SnackBar(
                                content: const Text('Save your profile Successfully!'),
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
      drawer:  Navbar(title: widget.title)
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

  Widget _buildTextFieldDepartment() {
    return TextField(
      controller: _controllerDepartment,
      keyboardType: TextInputType.number,
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
      controller: _controllerGender,
      type: SelectFormFieldType.dialog, // or can be dialog
      //initialValue: _controllerGender.text,
      labelText: 'Gender',
      decoration: InputDecoration(
        labelText: "Select Gender",
        errorText: _isFieldGenderValid
            ? null
            : "Gender is required",
      ),
      items: _genderItems,
      onChanged: (val) => {
        //_controllerGender.text = val,
        _isFieldGenderValid = true,
      },
      onSaved: (val) => print(val),
    );
  }

  Widget _buildSelectFieldRole() {
    return SelectFormField(
      controller: _controllerRole,
      type: SelectFormFieldType.dialog, // or can be dialog
      //initialValue: _controllerRole.text,
      labelText: 'Role',
      decoration: InputDecoration(
        labelText: "Select Role",
        errorText: _isFieldRoleValid
            ? null
            : "Role is required",
      ),
      items: _roleItems,
      onChanged: (val) => {
        //_controllerRole.text = val,
        _isFieldRoleValid = true,
      },
      onSaved: (val) => print(val),
    );
  }
}