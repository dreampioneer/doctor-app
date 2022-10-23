import 'package:flutter/material.dart';
import 'package:doctor/api/api.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>{
  bool _isLoading = false;
  bool _isFieldEmailValid = true;
  bool _isFieldPasswordValid = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldState,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Login Form",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldEmail(),
                _buildTextFieldPassword(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: FloatingActionButton.extended(
                    label: Text(
                      "login".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (
                          !_isFieldEmailValid ||
                          !_isFieldPasswordValid) {
                        return;
                      }
                      setState(() => _isLoading = true);
                      String email = _controllerEmail.text;
                      String password = _controllerPassword.text;
                      _apiService.login(email, password).then((response) {
                        print(response["status"]);
                        if(response["status"] == "success"){

                        }
                        if(response["status"] == "error"){

                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: FloatingActionButton.extended(
                    label: Text(
                      "sign up".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() => _isLoading = true);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SignUpScreen(),
                      //   ),
                      // ),
                      print("register");
                    },
                  ),
                )
              ],
            ),
          ),
          // _isLoading
          //     ? Stack(
          //   children: [
          //     const Opacity(
          //       opacity: 0.3,
          //       child: const ModalBarrier(
          //         dismissible: false,
          //         color: Colors.grey,
          //       ),
          //     ),
          //     const Center(
          //       child: const CircularProgressIndicator(),
          //     ),
          //   ],
          // )
          //     : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldEmail() {
    return TextField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        errorText: _isFieldEmailValid
            ? null
            : "Email is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldPassword() {
    return TextField(
      controller: _controllerPassword,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        errorText: _isFieldPasswordValid
            ? null
            : "Password is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldPasswordValid) {
          setState(() => _isFieldPasswordValid = isFieldValid);
        }
      },
    );
  }
 }