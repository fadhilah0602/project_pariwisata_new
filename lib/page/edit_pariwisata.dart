import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:project_pariwisata_new/page/home_admin_page.dart';

import '../model/model_Pariwisata.dart';
// Make sure this path and model are correct

class EditPariwisataPage extends StatefulWidget {
  final ModelPariwisata pariwisata;

  const EditPariwisataPage({Key? key, required this.pariwisata})
      : super(key: key);

  @override
  _EditPariwisataPageState createState() => _EditPariwisataPageState();
}

class _EditPariwisataPageState extends State<EditPariwisataPage> {
  TextEditingController _namaController = TextEditingController();
  String _fotoPath = '';
  TextEditingController _lokasiController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.pariwisata.data!.isNotEmpty) {
      _namaController.text = widget.pariwisata.data!.first.nama_pariwisata;
      _fotoPath = widget.pariwisata.data!.first.gambar;
      _lokasiController.text = widget.pariwisata.data!.first.lokasi;
      _deskripsiController.text = widget.pariwisata.data!.first.keterangan;
      _hargaController.text = widget.pariwisata.data!.first.harga;
    }
  }

  Future<void> selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _fotoPath = result.files.single.path!;
      });
    }
  }

  Future<void> saveChanges(String newNama, String newLokasi, String newHarga, String newDeskripsi,
      String newJenisKelamin) async {
    if (newNama.isEmpty ||
        newLokasi.isEmpty ||
        newHarga.isEmpty ||
        newDeskripsi.isEmpty ||
        newJenisKelamin.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('All fields are required')));
      return;
    }

    Uri uri = Uri.parse('http://192.168.43.99/pariwisata/updatePariwisata.php');
    http.MultipartRequest request = http.MultipartRequest('POST', uri)
      ..fields['id_pariwisata'] = widget.pariwisata.data!.first.id_pariwisata
      ..fields['nama_pariwisata'] = newNama
      ..fields['lokasi'] = newLokasi
      ..fields['keterangan'] = newDeskripsi
      ..fields['harga'] = newHarga;

    if (_fotoPath.isNotEmpty && _fotoPath != widget.pariwisata.data!.first.gambar) {
      request.files.add(await http.MultipartFile.fromPath('foto', _fotoPath,
          contentType: MediaType('image', 'jpeg')));
    }

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var data = json.decode(responseBody);
        print(
            "Response Body: $responseBody"); // Log the full response body for debugging

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));

        // Safely check for 'is_success' with a default value of false if not found
        bool isSuccess = data['isSuccess'] ?? false;
        if (isSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PariwisataScreen()),
          );

          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => PariwisataPage1()));
        }
      } else {
        throw Exception(
            'Failed to update data, status code: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    } finally {
      setState(() {
        var isLoading =
            false; // Ensure isLoading is set to false in finally block
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF87CEEB),
        title: Row(
          children: [
            Text(
              'Edit Pariwisata',
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF87CEEB),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              style: TextStyle(
                fontFamily: 'Mulish',
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              controller: _namaController,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              controller: _lokasiController,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _deskripsiController,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(type: FileType.image);

                if (result != null) {
                  setState(() {
                    _fotoPath = result.files.single.path!;
                  });
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
                child: Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(width: 10),
                    Expanded(
                      // This ensures the text widget expands to fill the space
                      child: Text(
                        _fotoPath.isNotEmpty
                            ? _fotoPath.split('/').last
                            : 'Pilih foto',
                        overflow: TextOverflow
                            .ellipsis, // Helps avoid text overflow issues
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                saveChanges(_namaController.text, _lokasiController.text,
                    _deskripsiController.text, _deskripsiController.text,_fotoPath);
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFF008080),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Edit ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
