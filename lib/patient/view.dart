import 'package:flutter/material.dart';

class ViewPatient extends StatefulWidget {
  const ViewPatient({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ViewPatient> createState() => _ViewPatientState();
}

class _ViewPatientState extends State<ViewPatient> {

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
              'View Patient',
            ),
          ],
        ),
      ),
    );
  }
}
