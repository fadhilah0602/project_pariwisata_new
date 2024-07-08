import 'package:flutter/material.dart';

class Informasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sejarah Singkat'),
        backgroundColor: Color(0xFF88AB8E),// Sesuaikan dengan warna tema aplikasi Anda
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
              'Awal Mula Berdirinya Jakarta',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Sejarah penamaan Jakarta dimulai pada abad ke-5 Masehi. Pada waktu itu, kawasan yang sekarang dikenal sebagai Jakarta adalah sebuah pelabuhan kecil yang bernama Sunda Kelapa. ',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Sebelum 1527, bernama Sunda Kelapa, lalu menjadi Jayakarta dari tahun 1527 sampai 1619. Lalu menjadi Batavia/Batauia, atau Jaccatra dari 1619 -1942 dan Djakarta pada 1942-1972. Lambang DKI Jakarta yang kita kenal sampai saat ini dibuat oleh Gubernur ke-6 Jakarta Henk Ngantung.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            // SizedBox(height: 20),
            // Text(
            //   'Ketidaksesuaian spesifikasi barang yang Anda terima dengan barang tertera dalam iklan/foto penawaran barang merupakan bentuk pelanggaran/larangan bagi pelaku usaha dalam memperdagangkan barang.',
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
            // SizedBox(height: 20),
            // Text(
            //   'Bagaimana perlindungan hukum terhadap konsumen? Anda selaku konsumen sesuai Pasal 4 huruf h UU Perlindungan Konsumen berhak mendapatkan kompensasi, ganti rugi dan/atau penggantian apabila barang dan/atau jasa yang diterima tidak sesuai dengan perjanjian atau tidak sebagaimana mestinya.',
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
