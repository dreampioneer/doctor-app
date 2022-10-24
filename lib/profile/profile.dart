import 'package:doctor/components/navigation_bar.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.title}) : super(key: key);
  
  final String title;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

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
              "Profile"
          ),
        ),
      ),
      drawer:  Navbar(title: widget.title)
    );
  }
}