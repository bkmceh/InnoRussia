import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:inno_russian/sign_in.dart';
import 'package:http/http.dart' as http;

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  String urlForCode =
      'https://intense-meadow-04093.herokuapp.com/api/v1.0/auth/confirmcode/';

  UserData _user;
  bool _onEditing = true;
  String _code;

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context).settings;
    _user = settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify code'),
        centerTitle: true,
        backgroundColor: hexToColor("#3D3F70"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Enter your code',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          VerificationCode(
            textStyle: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
            keyboardType: TextInputType.number,
            // in case underline color is null it will use primaryColor: Colors.red from Theme
            underlineColor: Colors.blueGrey,
            length: 4,
            // clearAll is NOT required, you can delete it
            // takes any widget, so you can implement your design
            clearAll: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'clear all',
                style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.underline,
                    color: Colors.blue[700]),
              ),
            ),
            onCompleted: (String value) {
              setState(() {
                _code = value;
              });
            },
            onEditing: (bool value) {
              setState(() {
                _onEditing = value;
              });
              if (!_onEditing) FocusScope.of(context).unfocus();
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: _onEditing ? Text('Please enter full code') : _fullCode(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "We sent code on your Email",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                _user.getEmail(),
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _fullCode() {

    _sendDataToServer();

    return Text("Your code is ${_code}");
  }


  void _sendDataToServer() async {
    var response = await http.post(urlForCode,
        body: {'code': _code}, headers: {'Cookie': _user.getSessionId()});

  }
}
