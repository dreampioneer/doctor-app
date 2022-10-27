import 'package:doctor/components/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:doctor/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/storage.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  bool _isLoading = false;
  ApiService _apiService = ApiService();

  @override
  void initState() {
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
      body:  Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const <Widget>[
                Text("Hello"),
              ],
            ),
          ),
        ],
      ),
      drawer:  const Navbar(title: "Home")
    );
  }
}