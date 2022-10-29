import 'dart:convert';

import 'package:doctor/components/navigation_bar.dart';
import 'package:doctor/patient/patient.dart';
import 'package:flutter/material.dart';
import 'package:doctor/api/api.dart';
import 'package:slider_button/slider_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  String first_name = "";
  String last_name = "";
  String gender = "";
  String mrorms = "";

  @override
  void initState() {
    _apiService.getProfile().then((response) {
      first_name = jsonDecode(response.toString())["first_name"];
      last_name = jsonDecode(response.toString())["last_name"];
      gender = jsonDecode(response.toString())["gender"];
      mrorms = gender == "Male" ? "Mr." : "Ms.";
      setState(() {});
    });
    setState(() {
      _isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldState,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 147, 197, 244),
                borderRadius: BorderRadius.circular(16),
              ),
              child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        minRadius: 60,
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: const Color(0xffffffff),
                        child: Text(
                            first_name.substring(0, 1).toUpperCase() + last_name.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, " + mrorms + first_name + " " + last_name + "!",
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const SizedBox(
                            width: 120,
                            child: Text(
                              "Fill out your medical right now",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
              ),
              Container(
                height: 100,
              ),
              Card(
                child: ListTile(
                  onTap: () =>{
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Patient(title: "Patients", type: "only"),
                      ),
                      ModalRoute.withName("/Patients"),
                    )
                  },
                  title: const Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Text(
                        "Show Your Patients",
                        style: TextStyle(
                            fontSize: 30),
                      )
                    )
                  )
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () =>{
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Patient(title: "Patients", type: "all"),
                      ),
                      ModalRoute.withName("/AllPatients"),
                    )
                  },
                  title: const Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Text(
                          "Show All Patients",
                          style: TextStyle(
                              fontSize: 30),
                        )
                      )
                  )
                ),
              ),
          //     SliderButton(
          //     action: () {
          //       Navigator.pushAndRemoveUntil(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const Patient(title: "Patients", type: "only"),
          //         ),
          //         ModalRoute.withName("/Patients"),
          //       );
          //     },
          //     label: const Text(
          //       "Slide to view your patients",
          //       style: TextStyle(
          //           color: Color(0xff4a4a4a), fontWeight: FontWeight.w500, fontSize: 17),
          //     ),
          //     icon: const Text(
          //       "x",
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.w400,
          //         fontSize: 30,
          //       ),
          //     ),
          //   ),
          //     Container(
          //     height: 10,
          //   ),
          //     SliderButton(
          //   action: () {
          //     Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const Patient(title: "Patients", type: "all"),
          //       ),
          //       ModalRoute.withName("/AllPatients"),
          //     );
          //   },
          //   label: const Text(
          //     "Slide to view all patients",
          //     style: TextStyle(
          //         color: Color(0xff4a4a4a), fontWeight: FontWeight.w500, fontSize: 17),
          //   ),
          //   icon: const Text(
          //     "x",
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontWeight: FontWeight.w400,
          //       fontSize: 30,
          //     ),
          //   ),
          // )
          ],
        ),
        ),
      ),
      drawer:  const Navbar(title: "Home")
    );
  }
}