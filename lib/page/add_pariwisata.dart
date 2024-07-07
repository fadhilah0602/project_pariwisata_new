import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:project_pariwisata_new/model/model_kategori.dart';

import '../model/model_addPariwisata.dart';
import 'home_admin_page.dart';

class AddPariwisata extends StatefulWidget {
  const AddPariwisata({Key? key}) : super(key: key);

  @override
  State<AddPariwisata> createState() => _AddPariwisataState();
}

class _AddPariwisataState extends State<AddPariwisata> {
  TextEditingController _namaController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  String _fotoPath = ''; // Ubah ke tipe String
  TextEditingController _hargaController = TextEditingController();
  TextEditingController _lokasiController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  bool _obscurePassword = true;
  String? _name;
  List<Kategori> _categoryList = [];
  List<Kategori> _filteredCategoryList = [];
  Kategori? _selectedCategory;

  bool isLoading = false;

  // Future<bool> requestPermissions() async {
  //   var status = await Permission.storage.request();
  //   return status.isGranted;
  // }

  @override
  void initState() {
    super.initState();
    _fetchCategoryPariwisata();
  }

  Future<bool> requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      var result = await Permission.storage.request();
      return result.isGranted;
    }
    return true;
  }

  Future<void> selectFile() async {
    if (await requestPermissions()) {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.path != null) {
        setState(() {
          _fotoPath = result.files.single.path!;
        });
      } else {
        print("No file selected");
      }
    } else {
      print("Storage permission not granted");
    }
  }

  Future<void> addPariwisata() async {
    if (_namaController.text.isEmpty ||
        _lokasiController.text.isEmpty ||
        _selectedCategory!.nama_kategori.isEmpty ||
        _hargaController.text.isEmpty ||
        _deskripsiController.text.isEmpty ||
        _fotoPath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field harus diisi')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      Uri uri =
          Uri.parse('http://192.168.43.99/pariwisata/createPariwisata.php');

      http.MultipartRequest request = http.MultipartRequest('POST', uri)
        ..fields['nama_pariwisata'] = _namaController.text
        ..fields['lokasi'] = _lokasiController.text
        ..fields['id_kategori'] = _selectedCategory!.id_kategori
        ..fields['harga'] = _hargaController.text
        ..fields['keterangan'] = _deskripsiController.text;

      if (_fotoPath.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'gambar',
            _fotoPath,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      print(
          "Server response: $responseBody"); // This line will print the response body

      if (response.statusCode == 200) {
        try {
          ModelAddPariwisata data = modelAddPariwisataFromJson(responseBody);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
          if (data.isSuccess) {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => PariwisataPage1()),
            // );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PariwisataScreen()),
              (route) => false,
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to parse response: $e')),
          );
        }
      } else {
        throw Exception(
            'Failed to upload data, status code: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchCategoryPariwisata() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.43.99/pariwisata/listCategory.php'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        setState(() {
          _categoryList = List<Kategori>.from(
              parsed['data'].map((x) => Kategori.fromJson(x)));
          _filteredCategoryList = _categoryList;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load Category Pariwisata');
      }
    } catch (e) {
      print('Error fetching category: $e');
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAFC8AD),
        title: Row(
          children: [
            Text(
              'Add Pariwisata',
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFAFC8AD),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Nama Pariwisata',
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
            DropdownButtonFormField<Kategori>(
              decoration: InputDecoration(
                hintText: 'Category',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              value: _selectedCategory,
              onChanged: (Kategori? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: _filteredCategoryList.map<DropdownMenuItem<Kategori>>((Kategori value) {
                return DropdownMenuItem<Kategori>(
                  value: value,
                  child: Text(value.nama_kategori),
                );
              }).toList(),
            ),
            // TextField(
            //   decoration: InputDecoration(
            //     filled: true,
            //     fillColor: Colors.white,
            //     hintText: 'Category',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8.0),
            //       borderSide: BorderSide.none,
            //     ),
            //     contentPadding:
            //     EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            //   ),
            //   controller: _categoryController,
            // ),
            SizedBox(height: 16),
            InkWell(
              // onTap: selectFile,
              onTap: () async {
                selectFile();

                // FilePickerResult? result =
                //     await FilePicker.platform.pickFiles(type: FileType.image);
                //
                // if (result != null) {
                //   setState(() {
                //     _fotoPath = result.files.single.path!;
                //   });
                // }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Pilih Foto",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      SizedBox(width: 10),
                      Text(_fotoPath.isNotEmpty
                          ? _fotoPath.split('/').last
                          : 'Pilih foto'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Lokasi",
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
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Harga",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              controller: _hargaController,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _deskripsiController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Deskripsi',
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
              onTap: () {
                addPariwisata();
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFF88AB8E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Save ',
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
