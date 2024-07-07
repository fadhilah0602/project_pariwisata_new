import 'package:flutter/material.dart';

class LegalAndPoliciesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legal and Policies'),
        backgroundColor: Color(0xFF87CEEB), // Sesuaikan dengan warna tema aplikasi Anda
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
              'Perlindungan Konsumen dari Bisnis Online',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Dengan pendekatan UU Perlindungan Konsumen, kasus Anda dapat kami simpulkan sebagai salah satu pelanggaran terhadap hak konsumen. Bagaimana perlindungan konsumen dari bisnis online?',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Persoalan Anda secara tegas diatur dalam Pasal 8 ayat (1) huruf f UU Perlindungan Konsumen yang melarang pelaku usaha untuk memproduksi dan/atau memperdagangkan barang dan/atau jasa yang tidak sesuai dengan janji yang dinyatakan dalam label, etiket, keterangan, iklan atau promosi penjualan barang dan/atau jasa tersebut.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Ketidaksesuaian spesifikasi barang yang Anda terima dengan barang tertera dalam iklan/foto penawaran barang merupakan bentuk pelanggaran/larangan bagi pelaku usaha dalam memperdagangkan barang.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Bagaimana perlindungan hukum terhadap konsumen? Anda selaku konsumen sesuai Pasal 4 huruf h UU Perlindungan Konsumen berhak mendapatkan kompensasi, ganti rugi dan/atau penggantian apabila barang dan/atau jasa yang diterima tidak sesuai dengan perjanjian atau tidak sebagaimana mestinya.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Di sisi lain, pelaku usaha wajib memberi kompensasi, ganti rugi dan/atau penggantian apabila barang dan/atau jasa yang diterima atau dimanfaatkan tidak sesuai dengan perjanjian.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
