import 'dart:convert';

import 'package:doctor/api/api.dart';
import 'package:doctor/components/navigation_bar.dart';
import 'package:doctor/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
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
  String _controllerGender = "Male";
  String _controllerRole = "Doctor";

  List<DropdownMenuItem<String>> get _genderItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Male"),value: "Male"),
      const DropdownMenuItem(child: Text("Female"),value: "Female"),
      const DropdownMenuItem(child: Text("Non-binary/non-conforming"),value: "Non-binary/non-conforming"),
      const DropdownMenuItem(child: Text("Prefer not to respond"),value: "Prefer not to respond"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get _roleItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Doctor"),value: "Doctor"),
      const DropdownMenuItem(child: Text("Nurse"),value: "Nurse"),
      const DropdownMenuItem(child: Text("Transgender"),value: "Transgender"),
      const DropdownMenuItem(child: Text("Physical Therapist"),value: "Physical Therapist"),
    ];
    return menuItems;
  }

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
      _controllerRole = response["data"]["role"],
      _controllerGender = response["data"]["gender"],
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
                          setState(() => _isLoading = true);
                          String first_name = _controllerFirstName.text;
                          String last_name = _controllerLastName.text;
                          String email = _controllerEmail.text;
                          int department_id = int.parse(_controllerDepartment.text);
                          String gender = _controllerGender;
                          String role = _controllerRole;
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
    return Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Text(
              "Gender : ",
              style: TextStyle(fontSize: 17),
            ),
          ),
          DropdownButton<String>(
            value: _controllerGender,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            underline: Container(
              height: 2,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                _controllerGender = value!;
              });
            },
            items: _genderItems,
          )
        ]
    );
  }

  Widget _buildSelectFieldRole() {
    return Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Text(
              "Gender : ",
              style: TextStyle(fontSize: 17),
            ),
          ),
          DropdownButton<String>(
            value: _controllerRole,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            underline: Container(
              height: 2,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                _controllerRole = value!;
              });
            },
            items: _roleItems,
          )
        ]
    );
  }


}