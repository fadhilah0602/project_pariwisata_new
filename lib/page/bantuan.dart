import 'package:flutter/material.dart';

class Bantuan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        backgroundColor: Color(0xFF88AB8E), // Sesuaikan dengan warna tema aplikasi Anda
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Penggunaan Aplikasi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Aplikasi ini merupaka aplikasi yang membantu pengguna untuk berkunjung ke tempat wisata dan mendapatkan informasi mengenai tempat wisata yang ingin dituju',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            // SizedBox(height: 20),
            // Text(
            //   'Ancol',
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
            // SizedBox(height: 20),
            // Text(
            //   'Monas',
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
            // SizedBox(height: 20),
            // Text(
            //   'Mesjid Istiqlal',
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
            // SizedBox(height: 20),
            // Text(
            //   'Di sisi lain, pelaku usaha wajib memberi kompensasi, ganti rugi dan/atau penggantian apabila barang dan/atau jasa yang diterima atau dimanfaatkan tidak sesuai dengan perjanjian.',
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
