import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_pariwisata_new/page/edit_pariwisata.dart';
import 'package:project_pariwisata_new/page/penilaian_screen.dart';

import '../model/model_Pariwisata.dart';
import '../model/model_user.dart';
import '../util/session_manager.dart';
import 'add_pariwisata.dart';
import 'add_penilaian_customers.dart';
import 'navigation_page.dart';
import 'profile.dart';

class PariwisataScreen extends StatefulWidget {
  const PariwisataScreen({super.key});
  // final ModelPariwisata pariwisata;
  //
  // const PariwisataScreen({super.key, required this.pariwisata});


  @override
  State<PariwisataScreen> createState() => _PariwisataScreen();
}

class _PariwisataScreen extends State<PariwisataScreen> with WidgetsBindingObserver {
  late ModelUsers currentUser;
  late Pariwisata pariwisata;

  int _selectedIndex = 1;
  List<Pariwisata> _PariwisataList = [];
  List<Pariwisata> _filteredPariwisataList = [];
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getDataSession();
    _fetchPariwisata();
  }

  Future<void> _fetchPariwisata() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.43.99/pariwisata/listPariwisata.php'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        setState(() {
          _PariwisataList = List<Pariwisata>.from(parsed['data'].map((x) => Pariwisata.fromJson(x)));
          _filteredPariwisataList = _PariwisataList;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load Pariwisata');
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future<void> deletePariwisata(String idPariwisata) async {
    final String apiUrl = 'http://192.168.43.99/pariwisata/deletePariwisata.php';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {"id_Pariwisata": idPariwisata},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['isSuccess']) {
        setState(() {
          _fetchPariwisata();
          // _PariwisataList.removeAt(idPariwisata.toString() as int);
          // _filteredPariwisataList = List.from(_PariwisataList);
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

  void _filterPariwisataList(String query) {
    setState(() {
      _filteredPariwisataList = _PariwisataList.where((Pariwisata) => Pariwisata.nama_pariwisata.toLowerCase().contains(query.toLowerCase())).toList();
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
          MaterialPageRoute(builder: (context) => NavigationPage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PariwisataScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PenilaianScreen()),
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
        title: Text('Pariwisata Saya'),
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
                onChanged: _filterPariwisataList,
                decoration: InputDecoration(
                  labelText: 'Search Pariwisata',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredPariwisataList.length,
                itemBuilder: (context, index) {
                  final Pariwisata = _filteredPariwisataList[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gambar ditambahkan di sini
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'http://192.168.43.99/pariwisata/${Pariwisata.gambar}', // URL gambar
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Pariwisata.nama_pariwisata,
                                style: TextStyle(fontSize: 16),
                              ),
                              // IconButton(
                              //     onPressed: () {
                              //       // Buat ModelSejarawan baru dengan satu objek Datum dalam list data
                              //       ModelPariwisata modelPariwisata =
                              //       ModelPariwisata(
                              //         isSuccess: true,
                              //         message: "Success",
                              //         data: [
                              //           pariwisata
                              //         ], // Masukkan objek Datum ke dalam list data
                              //       );
                              //
                              //       // Navigasi ke halaman EditSejarawanPage dengan memberikan parameter yang diperlukan
                              //       Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => EditPariwisataPage(
                              //               pariwisata: modelPariwisata),
                              //         ),
                              //       );
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

                              IconButton(
                                onPressed: () {
                                  // Buat ModelSejarawan baru dengan satu objek Datum dalam list data
                                  ModelPariwisata modelPariwisata =
                                        ModelPariwisata(
                                          isSuccess: true,
                                          message: "Success",
                                          data: [
                                            pariwisata
                                          ], // Masukkan objek Datum ke dalam list data
                                        );

                                  // Navigasi ke halaman EditSejarawanPage dengan memberikan parameter yang diperlukan
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditPariwisataPage(
                                                pariwisata: modelPariwisata),
                                          ),
                                        );
                                },
                                icon: Icon(Icons.edit),
                                color: Colors.blue,
                              ),
                              IconButton(
                                onPressed: () {
                                  deletePariwisata(Pariwisata.id_pariwisata.toString());
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
                              //   onPressed: () => deletePariwisata(Pariwisata.id_pariwisata.toString()),
                              // ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Harga:',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Rp. ${Pariwisata.harga}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Lokasi:',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '${Pariwisata.lokasi}',
                                style: TextStyle(fontSize: 16),
                              ),
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
              builder: (context) => AddPariwisata(),
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
            label: 'Pariwisata',
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
