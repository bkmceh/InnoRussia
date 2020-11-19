import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:inno_russian/verification.dart';

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();
  String _email;
  bool _showLogin = true;
  String url_auth = "https://intense-meadow-04093.herokuapp.com/api/v1.0/auth/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor("#3D3F70"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment(
                  -69.5 / (0.5 * MediaQuery.of(context).size.width), 0),
              child: CustomPaint(painter: Book())),
          _logo(),
          (_showLogin
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      _form("REGISTER", _buttonAction),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Text(
                            "Already registered? Login!",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              _showLogin = false;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                )
              : Column(
                  children: [
                    _form("LOGIN", _buttonAction),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        child: Text(
                          "Not registered yet? Register!",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            _showLogin = true;
                          });
                        },
                      ),
                    )
                  ],
                )),
          // _form("LOGIN", _buttonAction),
        ],
      ),
    );
  }

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: Container(
        child: Align(
          child: Text(
            "InnoRussian",
            style: TextStyle(
                fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _form(String label, void func()) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(Icon(Icons.email), "EMAIL", _emailController),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: _button(label, func),
            ),
          )
        ],
      ),
    );
  }

  Widget _input(Icon icon, String hint, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 20, color: Colors.white),
        decoration: InputDecoration(
            hintStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white30),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white54, width: 1)),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: IconTheme(
                data: IconThemeData(color: Colors.white),
                child: icon,
              ),
            )),
      ),
    );
  }

  Widget _button(String text, void func()) {
    return RaisedButton(
        splashColor: Colors.blueGrey,
        highlightColor: Colors.blueGrey,
        color: Colors.white,
        onPressed: () {
          func();
        },
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
              fontSize: 20),
        ));
  }

  void _buttonAction() {
    _email = _emailController.text;

    if (EmailValidator.validate(_email) == true) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Verification(_email)));
    } else {
      print("Error");
      _emailController.clear();
    }
  }
}

class Book extends CustomPainter {
  void paint_marker(Canvas canvas, Size size, double x, double y) {
    canvas.drawCircle(Offset(0 + x, 0 + y), 20, Paint());
    var path = Path();

    path.moveTo(-16.629 + x, 400 / 36 + y);
    path.lineTo(0 + x, 37 + y);
    path.lineTo(16.629 + x, 400 / 36 + y);
    path.close();

    Paint painter = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, painter);

    var path_white = Path();
    path_white.arcTo(
        Rect.fromCircle(center: Offset(0 + x, 0 + y), radius: 16.5),
        -3.1415 + 0.33984,
        3.1415 - 2 * 0.33984,
        true);
    path_white.close();
    Paint painter_white = Paint()
      ..color = hexToColor('#EFEFEF')
      ..style = PaintingStyle.fill;
    canvas.drawPath(path_white, painter_white);

    var path_blue = Path();
    path_blue.arcTo(Rect.fromCircle(center: Offset(0 + x, 0 + y), radius: 16.5),
        3.1415 - 0.33984, 2 * 0.33984, false);
    path_blue.lineTo(15.556 + x, -5.5 + y);
    path_blue.arcTo(Rect.fromCircle(center: Offset(0 + x, 0 + y), radius: 16.5),
        -0.33984, 2 * 0.33984, false);
    path_blue.close();
    Paint painter_blue = Paint()
      ..color = hexToColor('#3757A6')
      ..style = PaintingStyle.fill;
    canvas.drawPath(path_blue, painter_blue);

    var path_red = Path();
    path_red.arcTo(Rect.fromCircle(center: Offset(0 + x, 0 + y), radius: 16.5),
        0.33984, 3.1415 - 2 * 0.33984, false);
    path.close();
    Paint painter_red = Paint()
      ..color = hexToColor('#E73B36')
      ..style = PaintingStyle.fill;
    canvas.drawPath(path_red, painter_red);
  }

  void paint_lines(Canvas canvas, Size size, double y) {
    Paint line_painter = Paint()..color = hexToColor('#DADBDC');
    var path_line_1 = Path();
    path_line_1.moveTo(20, 0 + y);
    path_line_1.cubicTo(35, 10 + y, 45, -8 + y, 65, 0 + y);
    path_line_1.arcTo(Rect.fromCircle(center: Offset(65, 2 + y), radius: 2),
        -3.1415 / 2, 3.1415, false);
    path_line_1.cubicTo(45, -4 + y, 35, 14 + y, 20, 4 + y);
    path_line_1.arcTo(Rect.fromCircle(center: Offset(20, 2 + y), radius: 2),
        3.1415 / 2, 3.1415, false);
    path_line_1.close();

    var path_line_2 = Path();
    path_line_2.moveTo(119, 0 + y);
    path_line_2.cubicTo(104, 10 + y, 94, -8 + y, 74, 0 + y);
    path_line_2.arcTo(Rect.fromCircle(center: Offset(74, 2 + y), radius: 2),
        -3.1415 / 2, -3.1415, false);
    path_line_2.cubicTo(94, -4 + y, 104, 14 + y, 119, 4 + y);
    path_line_2.arcTo(Rect.fromCircle(center: Offset(119, 2 + y), radius: 2),
        3.1415 / 2, -3.1415, false);
    path_line_2.close();
    canvas.drawPath(path_line_1, line_painter);
    canvas.drawPath(path_line_2, line_painter);
  }

  @override
  void paint(Canvas canvas, Size size) {
    //canvas.drawRect(Rect.fromLTWH(0, 12.5, 150.5, 105.5), Paint());
    var path = Path();

    path.moveTo(0, 4);
    path.lineTo(0, 96);
    path.arcTo(Rect.fromCircle(center: Offset(4, 96), radius: 4), 3.1415,
        -3.1415 / 2, false);
    path.lineTo(135, 100);
    path.arcTo(Rect.fromCircle(center: Offset(135, 96), radius: 4), 3.1415 / 2,
        -3.1415 / 2, false);
    path.lineTo(139, 4);
    path.arcTo(Rect.fromCircle(center: Offset(135, 4), radius: 4), 0,
        -3.1415 / 2, false);
    path.lineTo(4, 0);
    path.arcTo(Rect.fromCircle(center: Offset(4, 4), radius: 4), -3.1415 / 2,
        -3.1415 / 2, false);
    path.close();
    Paint painter = Paint()
      ..color = hexToColor('#796CBE')
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, painter);

    canvas.drawCircle(Offset(69.5, 98), 10, painter);

    var path_1 = Path();
    path_1.moveTo(56, 100);
    path_1.quadraticBezierTo(60, 100, 69.5, 108);
    path_1.quadraticBezierTo(79, 100, 83, 100);
    path_1.close();
    canvas.drawPath(path_1, painter);

    Paint paper_paint = Paint()
      ..color = hexToColor('#FFFFFF')
      ..style = PaintingStyle.fill;
    var path_papers = Path();
    path_papers.moveTo(10, 90);
    path_papers.cubicTo(40, 99, 40, 80, 63, 90);
    path_papers.lineTo(76, 90);
    path_papers.cubicTo(99, 80, 99, 99, 129, 90);
    path_papers.lineTo(129, -10);
    path_papers.cubicTo(99, -1, 99, -20, 76, -10);
    path_papers.arcTo(
        Rect.fromCircle(center: Offset(69.5, -16.5), radius: 9.192),
        0.785,
        3.1415 / 2,
        false);
    path_papers.cubicTo(40, -20, 40, -1, 10, -10);
    path_papers.close();

    canvas.drawPath(path_papers, paper_paint);
    canvas.drawCircle(Offset(69.5, 83.5), 9.192, paper_paint);
    for (double i = 0; i < 80; i += 10) {
      paint_lines(canvas, size, i + 3);
    }
    paint_marker(canvas, size, 99, -20);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
