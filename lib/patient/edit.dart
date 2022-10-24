import 'package:flutter/material.dart';

class EditPatient extends StatefulWidget {
  const EditPatient({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<EditPatient> createState() => _EditPatientState();
}

class _EditPatientState extends State<EditPatient> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Edit Patient',
            ),
          ],
        ),
      ),
    );
  }
}
