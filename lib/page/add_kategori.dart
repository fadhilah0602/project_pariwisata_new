import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:project_pariwisata_new/model/model_addKategori.dart';

import '../model/model_Kategori.dart';
import 'kategori.dart';

class AddKategori extends StatefulWidget {
  const AddKategori({Key? key}) : super(key: key);

  @override
  State<AddKategori> createState() => _AddKategoriState();
}

class _AddKategoriState extends State<AddKategori> {
  TextEditingController _namaController = TextEditingController();
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
    _fetchCategoryKategori();
  }

  Future<bool> requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      var result = await Permission.storage.request();
      return result.isGranted;
    }
    return true;
  }

  // Future<void> selectFile() async {
  //   if (await requestPermissions()) {
  //     FilePickerResult? result =
  //     await FilePicker.platform.pickFiles(type: FileType.image);
  //     if (result != null && result.files.single.path != null) {
  //       setState(() {
  //         _fotoPath = result.files.single.path!;
  //       });
  //     } else {
  //       print("No file selected");
  //     }
  //   } else {
  //     print("Storage permission not granted");
  //   }
  // }

  Future<void> addKategori() async {
    if (_namaController.text.isEmpty) {
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
      Uri.parse('http://192.168.43.99/pariwisata/createKategori.php');

      http.MultipartRequest request = http.MultipartRequest('POST', uri)
        ..fields['nama_kategori'] = _namaController.text;

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      print(
          "Server response: $responseBody"); // This line will print the response body

      if (response.statusCode == 200) {
        try {
          ModelAddKategori data = modelAddKategoriFromJson(responseBody);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
          if (data.isSuccess) {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => KategoriPage1()),
            // );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => KategoriScreen()),
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

  Future<void> _fetchCategoryKategori() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.43.99/Kategori/listCategory.php'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        setState(() {
          _categoryList = List<Kategori>.from(
              parsed['data'].map((x) => Kategori.fromJson(x)));
          _filteredCategoryList = _categoryList;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load Category Kategori');
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
              'Add Kategori',
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
                hintText: 'Nama Kategori',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              controller: _namaController,
            ),
            InkWell(
              onTap: () {
                addKategori();
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
