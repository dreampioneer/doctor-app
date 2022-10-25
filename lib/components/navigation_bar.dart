// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:doctor/api/storage.dart';
import 'package:doctor/patient/patient.dart';
import 'package:doctor/profile/change_password.dart';
import 'package:doctor/profile/profileEdit.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar>{
  String token = "";
  StorageService _storageService = StorageService();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    print(this.token);
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(
          "test"
      ),
      accountEmail: const Text(
          "test"
      ),
      currentAccountPicture: const CircleAvatar(
        child: FlutterLogo(size: 42.0),
      ),
    );
    final drawerItems = ListView(
      children: [
        drawerHeader,
        ListTile(
          title: const Text(
              "Patients"
          ),
          selected: widget.title == "Patients",
          leading: const Icon(Icons.comment),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Patient(title: "Patients"),
              ),
            );
          },
        ),
        ListTile(
          title: const Text(
              "About me"
          ),
          selected: widget.title == "About me",
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileEdit(title: "About me"),
              ),
            );
          },
        ),
        ListTile(
          title: const Text(
              "Change Password"
          ),
          selected: widget.title == "Change Password",
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChangePassword(title: "Change Password"),
              ),
            );
          },
        ),
        ListTile(
          title: const Text(
              "Logout"
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
          },
        ),
      ],
    );
    return Drawer(
      child: drawerItems,
    );
  }
}

