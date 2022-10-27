import 'dart:convert';
import 'dart:io';

import 'package:doctor/api/api.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:image/image.dart';

class ViewPatient extends StatefulWidget {
  const ViewPatient({Key? key, required this.title, required this.patient}) : super(key: key);

  final String title;
  final dynamic patient;
  //final String url;

  @override
  State<ViewPatient> createState() => _ViewPatientState();
}

class _ViewPatientState extends State<ViewPatient> {
  bool _isLoading = false;
  String url  = "";
  late String description = "";
  ApiService _apiService = ApiService();

  final ImagePicker imgpicker = ImagePicker();
  bool multiFlag = false;

  chooseCamera() async {
    final choosedimage = await imgpicker.pickImage(source: ImageSource.camera);
    dynamic result = "";
    dynamic dir = "";
    if(choosedimage != null){
      GallerySaver.saveImage(choosedimage.path);
      SnackBar snackBar;
      setState(() {
        _isLoading = true;
      });
      _apiService.uploadImageFileVerify(choosedimage, jsonDecode(widget.patient)["id"]).then((response) =>{
        setState(() {
          _isLoading = false;
        }),
        dir = Directory(choosedimage.path),
        dir.deleteSync(recursive: true),
        result = jsonDecode(response),
        if(result["status"]){
            snackBar = SnackBar(
            content: const Text('Face Verify Successfully!'),
            action: SnackBarAction(
              label: 'Undo',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            ),
            ScaffoldMessenger.of(context).showSnackBar(snackBar),
          }else{
          snackBar = SnackBar(
            content: const Text('Face Verify Failed!'),
          ),
          ScaffoldMessenger.of(context).showSnackBar(snackBar),
        }
      });
      }
    }

      // SnackBar snackBar;
      // _apiService.uploadImageFileVerify(choosedimage, jsonDecode(widget.patient)["id"]).then((response) =>{
      //   result = jsonDecode(response),
      //   if(result["status"]){
      //       snackBar = SnackBar(
      //       content: const Text('Face Verify Successfully!'),
      //       action: SnackBarAction(
      //         label: 'Undo',
      //           onPressed: () {
      //             // Some code to undo the change.
      //           },
      //         ),
      //       ),
      //       ScaffoldMessenger.of(context).showSnackBar(snackBar),
      //     }else{
      //     snackBar = SnackBar(
      //       content: const Text('Face Verify Failed!'),
      //       action: SnackBarAction(
      //         label: 'Undo',
      //         onPressed: () {
      //           // Some code to undo the change.
      //         },
      //       ),
      //     ),
      //     ScaffoldMessenger.of(context).showSnackBar(snackBar),
      //   }
      // });
      // }

  @override
  void initState() {
    _apiService.getPatientImage(jsonDecode(widget.patient)["id"]).then((response) => {
       url = "http://10.10.11.226:8000" + jsonDecode(response!)["image_lists"][0]["image"],
      setState(() {

      }),
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Scrollbar(
        child: _isLoading ? Center(
            child : Column(
              mainAxisAlignment: MainAxisAlignment.center,//Center Column contents vertically,
              children: const [
                CircularProgressIndicator(),
                Text(
                  'Loading . . .',
                ),
              ],
            )
        ) : ListView(
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
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  url == "" ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                            "No Image",
                            style: const TextStyle(fontSize: 25),
                        ),
                      )
                    ],
                  )
                  : Card(
                    child: Container(
                      height: 150, width:150,
                      child: Image.network(url),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 3,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                          //crossAxisAlignment: CrossAxisAlignment.center,//Center Row contents vertically,
                          children: [FloatingActionButton.extended(
                            onPressed: () {
                              chooseCamera();
                            },
                            label: const Text(
                                "Take a picture"
                            ),
                          ),]
                      )
                  ),
                  ]
                ),
              ),
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
        ss = ss + value[i]["name"] + ",";
        ss = ss.substring(0, ss.length - 1);
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


