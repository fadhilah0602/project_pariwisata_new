import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_pariwisata_new/page/pesanan_screen.dart';

import '../model/model_Kategori.dart';
import '../model/model_user.dart';
import '../util/session_manager.dart';
import 'add_kategori.dart';
import 'add_penilaian_customers.dart';
import 'home_admin_page.dart';
import 'navigation_page.dart';
import 'profile.dart';

class KategoriScreen extends StatefulWidget {
  const KategoriScreen({super.key});
  // final ModelKategori Kategori;
  //
  // const KategoriScreen({super.key, required this.Kategori});


  @override
  State<KategoriScreen> createState() => _KategoriScreen();
}

class _KategoriScreen extends State<KategoriScreen> with WidgetsBindingObserver {
  late ModelUsers currentUser;
  late Kategori kategori;

  int _selectedIndex = 1;
  List<Kategori> _kategoriList = [];
  List<Kategori> _filteredKategoriList = [];
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getDataSession();
    _fetchKategori();
  }

  Future<void> _fetchKategori() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.43.99/pariwisata/kategori.php'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        setState(() {
          _kategoriList = List<Kategori>.from(parsed['data'].map((x) => Kategori.fromJson(x)));
          _filteredKategoriList = _kategoriList;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load Kategori');
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future<void> deleteKategori(String idKategori) async {
    final String apiUrl = 'http://192.168.43.99/pariwisata/deleteKategori.php';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {"id_kategori": idKategori},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['isSuccess']) {
        setState(() {
          _fetchKategori();
          // _KategoriList.removeAt(idKategori.toString() as int);
          // _filteredKategoriList = List.from(_KategoriList);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to delete data');
    }
  }

  void _filterKategoriList(String query) {
    setState(() {
      _filteredKategoriList = _kategoriList.where((Kategori) => Kategori.nama_kategori.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getDataSession();
    }
  }

  Future<void> getDataSession() async {
    bool hasSession = await sessionManager.getSession();
    if (hasSession) {
      setState(() {
        currentUser = ModelUsers(
          id_user: sessionManager.id_user!,
          username: sessionManager.username!,
          email: sessionManager.email!,
          no_hp: sessionManager.no_hp!,
          fullname: sessionManager.fullname!,
          alamat: sessionManager.alamat!,
          role: sessionManager.role!,
          jenis_kelamin: sessionManager.jenis_kelamin!,
        );
      });
    } else {
      print('Log Session tidak ditemukan!');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PariwisataScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => KategoriScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PesananScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(currentUser: currentUser)),
        );
        break;
      default:
    }
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      getDataSession();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAFC8AD),
        title: Text('Kategori Saya'),
      ),
      backgroundColor: Color(0xFFAFC8AD),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: _filterKategoriList,
                decoration: InputDecoration(
                  labelText: 'Search Kategori',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredKategoriList.length,
                itemBuilder: (context, index) {
                  final Kategori = _filteredKategoriList[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Kategori.nama_kategori,
                                style: TextStyle(fontSize: 16),
                              ),
                              // IconButton(
                              //     onPressed: () {
                              //       // Buat ModelSejarawan baru dengan satu objek Datum dalam list data
                              //       ModelKategori modelKategori =
                              //       ModelKategori(
                              //         isSuccess: true,
                              //         message: "Success",
                              //         data: [
                              //           Kategori
                              //         ], // Masukkan objek Datum ke dalam list data
                              //       );
                              //
                              //       // Navigasi ke halaman EditSejarawanPage dengan memberikan parameter yang diperlukan
                              //       // Navigator.push(
                              //       //   context,
                              //       //   MaterialPageRoute(
                              //       //     builder: (context) => EditKategoriPage(
                              //       //         Kategori: modelKategori),
                              //       //   ),
                              //       // );
                              //
                              //       ScaffoldMessenger.of(context)
                              //           .showSnackBar(SnackBar(content: Text("Klikk")));
                              //     },
                              //   icon: Icon(
                              //     Icons.edit,
                              //     size: 20,
                              //     color: Colors.blue,
                              //   ),
                              // ),

                              // IconButton(
                              //   onPressed: () {
                              //     // Buat ModelSejarawan baru dengan satu objek Datum dalam list data
                              //     ModelKategori modelKategori =
                              //           ModelKategori(
                              //             isSuccess: true,
                              //             message: "Success",
                              //             data: [
                              //               Kategori
                              //             ], // Masukkan objek Datum ke dalam list data
                              //           );
                              //
                              //     // Navigasi ke halaman EditSejarawanPage dengan memberikan parameter yang diperlukan
                              //           Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //               builder: (context) => EditKategoriPage(
                              //                   Kategori: modelKategori),
                              //             ),
                              //           );
                              //   },
                              //   icon: Icon(Icons.edit),
                              //   color: Colors.blue,
                              // ),
                              IconButton(
                                onPressed: () {
                                  deleteKategori(Kategori.id_kategori.toString());
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                              ),
                              // IconButton(
                              //   icon: Icon(
                              //     Icons.delete,
                              //     size: 20,
                              //     color: Colors.red,
                              //   ),
                              //   onPressed: () => deleteKategori(Kategori.id_Kategori.toString()),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );

                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddKategori(),
            ),
          );
        },
        backgroundColor: Color(0xFF88AB8E),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_outlined),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Rating',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF88AB8E),
        unselectedItemColor: Color(0xFF88AB8E),
        backgroundColor: Color(0xFFAFC8AD),
        onTap: _onItemTapped,
      ),
    );
  }
}
