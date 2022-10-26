import 'dart:convert';

import 'package:doctor/components/profile_pics.dart';
import 'package:doctor/model/patient.dart';
import 'package:doctor/profile/profileEdit.dart';
import 'package:flutter/material.dart';

class ViewPatient extends StatefulWidget {
  const ViewPatient({Key? key, required this.title, required this.patient}) : super(key: key);

  final String title;
  final dynamic patient;

  @override
  State<ViewPatient> createState() => _ViewPatientState();
}

class _ViewPatientState extends State<ViewPatient> {
  late String description = "";
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Scrollbar(
        child: ListView(
          children: <Widget>[
              Container(
                width: 10,
                height: 20,
                alignment: Alignment.topCenter,
              ),
              SizedBox(
                  width: double.infinity,
                  child: CircleAvatar(
                      minRadius: 45,
                      backgroundColor: const Color(0xff764abc),
                      foregroundColor: const Color(0xffffffff),
                      child: Text(
                        jsonDecode(widget.patient)["first_name"].substring(0, 1).toUpperCase() +
                            jsonDecode(widget.patient)["last_name"].substring(0, 1).toUpperCase(),
                        style: TextStyle(fontSize: 40),
                      )
                    ),
                  ),
              const SizedBox(
                width: 10,
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right:10.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildText("First Name", jsonDecode(widget.patient)["first_name"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildText("Last Name", jsonDecode(widget.patient)["last_name"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildText("Age", jsonDecode(widget.patient)["age"].toString()),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildText("Med List", jsonDecode(widget.patient)["med_list"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildText("Phone Number", jsonDecode(widget.patient)["phone_number"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildText("Date of Birth", jsonDecode(widget.patient)["date_of_birth"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildText("Street Address", jsonDecode(widget.patient)["street_address"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildText("City Address", jsonDecode(widget.patient)["city_address"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildText("Zipcode Address", jsonDecode(widget.patient)["zipcode_address"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildText("Sata Address", jsonDecode(widget.patient)["state_address"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildText("Link", jsonDecode(widget.patient)["link"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildText("Emergency Contact Name", jsonDecode(widget.patient)["emergency_contact_name"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildText("Emergency Phone Number", jsonDecode(widget.patient)["emergency_phone_number"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildText("Relationship", jsonDecode(widget.patient)["relationship"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildText("Gender", jsonDecode(widget.patient)["gender"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildBoolText("Is In Hospital", jsonDecode(widget.patient)["is_in_hospital"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildArrayText("Tags", jsonDecode(widget.patient)["tags"]),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  _buildArrayText("Treatment", jsonDecode(widget.patient)["treatment"]),
                  ]
                ),
              )
          ],
        )
      ),
    );
  }

  Widget _buildText(label,value) {
    value = value ?? "";
    if(value != ""){
      value = value;
    }else{
      value = "N/A";
    }
    return Text(
      label + " : " + value,
      style: const TextStyle(fontSize: 25),
    );
  }

  Widget _buildBoolText(label,value) {
    value = value ? "Yes" : "No";
    return Text(
      label + " : " + value,
      style: const TextStyle(fontSize: 25),
    );
  }
  Widget _buildArrayText(label, value) {
    var ss = "";
    if(value.length != 0){
      for(var i = 0; i < value.length ; i++){
        ss = ss + "," + value[i]["name"];
      }
    }else{
      value = "N/A";
    }
    return Text(
      label + " : " + ss,
      style: const TextStyle(fontSize: 25),
    );
  }
}


