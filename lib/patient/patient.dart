import 'package:doctor/components/navigation_bar.dart';
import 'package:flutter/material.dart';

class Patient extends StatefulWidget {
  const Patient({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              (widget.title)
          ),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(50.0),
            child: Text(
                "Patients"
            ),
          ),
        ),
        drawer:  Navbar(title: widget.title)
    );
  }
}