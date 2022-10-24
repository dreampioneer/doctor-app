import 'package:doctor/components/navigation_bar.dart';
import 'package:doctor/patient/add.dart';
import 'package:doctor/patient/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
        body: Scrollbar(
          child: ListView(
            restorationId: 'list_demo_list_view',
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              for (int index = 1; index < 21; index++)
                ListTile(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ViewPatient(title: 'View Patient'),
                      ),
                    ),
                  },
                  focusColor: const Color(0xff764abc),
                  hoverColor: const Color(0xff764abc),
                  selectedTileColor: const Color(0xff764abc),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xff764abc),
                    foregroundColor: const Color(0xffffffff),
                    child: Text(index.toString()),
                  ),
                  title: const Text(
                    'Fabric Softener',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          size: 20.0,
                          color: Colors.brown[900],
                        ),
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddPatient(title: 'Edit Patient'),
                              ),
                            ),
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          size: 20.0,
                          color: Colors.brown[900],
                        ),
                        onPressed: () {
                          //   _onDeleteItemPressed(index);
                        },
                      ),
                    ],
                  ),
                  // style: ListTileStyle(
                  //     border: 2px,
                  //   )
                ),
            ],
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
}