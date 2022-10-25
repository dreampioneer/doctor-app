import 'package:doctor/components/profile_pics.dart';
import 'package:doctor/model/patient.dart';
import 'package:doctor/profile/profileEdit.dart';
import 'package:flutter/material.dart';

class ViewPatient extends StatefulWidget {
  const ViewPatient({Key? key, required this.title, required this.patient}) : super(key: key);

  final String title;
  final PatientForm patient;

  @override
  State<ViewPatient> createState() => _ViewPatientState();
}

class _ViewPatientState extends State<ViewPatient> {
  late String description = "";
  @override
  void initState() {
    description = widget.patient.description ?? "N/A";
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
                        widget.patient.first_name.substring(0, 1).toUpperCase() +
                            widget.patient.last_name.substring(0, 1).toUpperCase(),
                        style: TextStyle(fontSize: 40),
                      )
                    ),
                  ),
              const SizedBox(
                width: 10,
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 200.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildText("Age", widget.patient.age.toString()),
                  _buildText("Med List", widget.patient.med_list),
                  _buildText("Phone Number", widget.patient.phone_number),
                  _buildText("Date of Birth", widget.patient.date_of_birth),
                  _buildText("Street Address", widget.patient.street_address),
                  _buildText("City Address", widget.patient.city_address),
                  _buildText("Zipcode Address", widget.patient.zipcode_address),
                  _buildText("Sata Address", widget.patient.state_address),
                  _buildText("Link", widget.patient.link),
                  _buildText("Emergency Contact Name", widget.patient.emergency_contact_name),
                  _buildText("Emergency Phone Number", widget.patient.emergency_phone_number),
                  _buildText("Relationship", widget.patient.relationship),
                  _buildText("Gender", widget.patient.gender),
                  _buildBoolText("Is In Hospital", widget.patient.is_in_hospital),
                  _buildArrayText("Tags", widget.patient.tags),
                  _buildArrayText("Treatment", widget.patient.treatment),
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
    if(value.length != 0){
      value = value.toString();
    }else{
      value = "N/A";
    }
    return Text(
      label + " : " + value.toString(),
      style: const TextStyle(fontSize: 25),
    );
  }
}


