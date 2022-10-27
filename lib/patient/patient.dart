import 'dart:convert';
import 'dart:math';

import 'package:doctor/components/navigation_bar.dart';
import 'package:doctor/model/patient.dart';
import 'package:doctor/patient/add.dart';
import 'package:doctor/patient/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../api/api.dart';
import 'edit.dart';

class Patient extends StatefulWidget {
  const Patient({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  late BuildContext context;

  ApiService _apiService = ApiService();
  @override
  void initState() {
    setState(() {

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
        body: Scrollbar(
          child:FutureBuilder(
            future: _apiService.getPatients(),
            builder: (BuildContext context, AsyncSnapshot<List<PatientForm>?> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Something wrong with message: ${snapshot.error.toString()}"),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                List<PatientForm>? patients = snapshot.data;
                return _buildListView(patients!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddPatient(title: 'Add Patient'),
                ),
              ),
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        drawer:  Navbar(title: widget.title)
    );
  }

  Widget _buildListView(List<PatientForm> patients) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
      itemBuilder: (context, index) {
          PatientForm patient = patients[index];
          return ListTile(
            onTap: () =>
            {
              _apiService.getPatient(patient.id).then((response){
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ViewPatient(title: 'View Patient', patient: response),
                  ),
                );
              }),
            },
            leading: CircleAvatar(
              backgroundColor: const Color(0xff764abc),
              foregroundColor: const Color(0xffffffff),
              child: Text(
                  patient.first_name.substring(0, 1).toUpperCase() +
                  patient.last_name.substring(0, 1).toUpperCase()
              ),
            ),
            title: Text(
              patient.first_name + " " + patient.last_name,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.border_color,
                    size: 20.0,
                    color: Colors.brown[900],
                  ),
                  onPressed: () =>
                  {
                    _apiService.getPatient(patient.id).then((response){
                      Navigator.push(
                        context,
                       MaterialPageRoute(
                        builder: (context) =>
                        EditPatient(title: 'Edit Patient', patient: response),
                        ),
                      );
                    }),
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20.0,
                    color: Colors.brown[900],
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Warning"),
                            content: const Text("Are you sure want to delete this data"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Yes"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _apiService.deletePatient(patient.id).then((response) {
                                    if (response) {
                                      setState(() {});
                                      final snackBar = SnackBar(
                                        content: const Text('Delete data Successfully!'),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            // Some code to undo the change.
                                          },
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    } else {
                                      final snackBar = SnackBar(
                                        content: const Text('Fail!'),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            // Some code to undo the change.
                                          },
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  });
                                },
                              ),
                              TextButton(
                                child: const Text("No"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
          );
        },
        itemCount: patients.length,
      ),

    );
  }
}