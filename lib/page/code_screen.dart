import 'package:flutter/material.dart';
import 'package:project_pariwisata_new/page/reset_password.dart';

class CodeScreen extends StatefulWidget {
  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 223, 221, 221),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Enter 4 Digits Code',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Enter the 4 digits code that you received on\n your email',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 50,
                child: TextFormField(
                  controller: _controller1,
                  // maxLength: 1,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    fillColor: Color(0xFF00BFFF),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  controller: _controller2,
                  // maxLength: 1,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    fillColor: Color(0xFF00BFFF),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  controller: _controller3,
                  // maxLength: 1,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    fillColor: Color(0xFF00BFFF),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  controller: _controller4,
                  // maxLength: 1,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    fillColor: Color(0xFF00BFFF),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: MaterialButton(
              onPressed: () {
                showModalBottomSheet(
                    // backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return ResetPassword();
                    });
              },
              padding: EdgeInsets.symmetric(
                horizontal: 175,
                vertical: 15,
              ),
              color: Color(0xFF88AB8E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
