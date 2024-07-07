import 'package:flutter/material.dart';

import 'code_screen.dart';
// import 'package:project_ecommerce/code_screen.dart';

class ForgotPassword extends StatelessWidget {
  String? _name;

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
        crossAxisAlignment: CrossAxisAlignment.start, // Arahkan widget ke kiri
        children: [
          // LoginScreen01(),
          SizedBox(height: 10),
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 223, 221, 221),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 30), // Jarak antara judul dan input field
          Text(
            'Forgot Password', // Judul input field
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20), // Jarak antara judul dan input field
          Text(
            'Enter your email for the verification proccess,\n we will send 4 digits code to your email', // Judul input field
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 450,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.2),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Email',
                      suffixIcon: _name != null && _name!.isNotEmpty
                          ? Icon(Icons.check, color: Colors.blue)
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _name = value.trim();
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    showModalBottomSheet(
                        // backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return CodeScreen();
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
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),// Jarak antara judul dan input field
        ],
      ),
    );
  }

  void setState(Null Function() param0) {}
}
