import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:inno_russian/MainSreens/menu.dart';
import 'package:inno_russian/main_screen.dart';

//import 'package:inno_russian/main_screen.dart';
import 'package:inno_russian/sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:inno_russian/state.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:inno_russian/sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:inno_russian/state.dart';

class Verification extends StatefulWidget {
  String userEmail;
  String userSessionId;

  Verification(this.userEmail);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  StateData stateData = StateData();
  String url_auth = "https://intense-meadow-04093.herokuapp.com/api/v1.0/auth/";
  String _sessionId;

  @override
  void initState() {
    _sendEmailToServer();

    super.initState();
  }

  String urlForCode =
      'https://intense-meadow-04093.herokuapp.com/api/v1.0/auth/confirmcode/';

  bool _onEditing = true;
  String _code;

  @override
  Widget build(BuildContext context) {
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
              if (!_onEditing) {
                FocusScope.of(context).unfocus();
              }
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: _onEditing
                  ? Text('Please enter full code')
                  : FutureBuilder<StateData>(
                future: _sendDataToServer(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    stateData = snapshot.data;
                    if (stateData.status == 0) {
                      return Text(
                        'Incorrect code try again!',
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      );
                    } else {
                      goToMainPage();
                      return Text(
                        'Confirmed',
                        style:
                        TextStyle(color: Colors.green, fontSize: 20),
                      );
                    }
                  } else {
                    return Text('wating...');
                  }
                },
              ),
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
                widget.userEmail,
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

  void _sendEmailToServer() async {
    var response = await http.post(url_auth, body: {'email': widget.userEmail});

    String _cookie = response.headers['set-cookie'];

    _sessionId = _cookie.substring(0, _cookie.indexOf(';'));
    widget.userSessionId = _sessionId;
  }

  Future<StateData> _sendDataToServer() async {
    var response = await http.post(urlForCode,
        body: {'code': _code}, headers: {'Cookie': widget.userSessionId});
    Map<String, dynamic> decodeJson = jsonDecode(response.body);
    StateData stateData = StateData.fromMappedJson(decodeJson);
    return stateData;
  }

  void goToMainPage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => MainNavigation(stateData.access_token)));
    });
  }


}
