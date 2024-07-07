import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_pariwisata_new/model/model_penilaian.dart';
import 'package:project_pariwisata_new/page/pesanan_screen.dart';

import '../model/model_penilaian.dart';
import '../model/model_user.dart';
import '../util/session_manager.dart';
import 'add_penilaian_customers.dart';
import 'navigation_page.dart';
import 'profile.dart';

class PenilaianScreen extends StatefulWidget {
  const PenilaianScreen({super.key});


  @override
  State<PenilaianScreen> createState() => _PenilaianScreen();
}

class _PenilaianScreen extends State<PenilaianScreen> with WidgetsBindingObserver {
  late ModelUsers currentUser;
  late Penilaian penilaian;

  int _selectedIndex = 1;
  List<Penilaian> _penilaianList = [];
  List<Penilaian> _filteredpenilaianList = [];
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getDataSession();
    _fetchpenilaian();
  }

  Future<void> _fetchpenilaian() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.43.99/pariwisata/penilaian.php'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        setState(() {
          _penilaianList = List<Penilaian>.from(parsed['data'].map((x) => Penilaian.fromJson(x)));
          _filteredpenilaianList = _penilaianList;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load penilaian');
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future<void> deletepenilaian(String idpenilaian) async {
    final String apiUrl = 'http://192.168.43.99/pariwisata/deletepenilaian.php';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {"id_penilaian": idpenilaian},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['isSuccess']) {
        setState(() {
          _fetchpenilaian();
          // _penilaianList.removeAt(idpenilaian.toString() as int);
          // _filteredpenilaianList = List.from(_penilaianList);
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

  void _filterpenilaianList(String query) {
    setState(() {
      _filteredpenilaianList = _penilaianList.where((penilaian) => penilaian.rating.toLowerCase().contains(query.toLowerCase())).toList();
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
          MaterialPageRoute(builder: (context) => PesananScreen()),
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
        title: Text('Penilaian Saya'),
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
                onChanged: _filterpenilaianList,
                decoration: InputDecoration(
                  labelText: 'Search penilaian',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredpenilaianList.length,
                itemBuilder: (context, index) {
                  final penilaian = _filteredpenilaianList[index];
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
                                penilaian.rating,
                                style: TextStyle(fontSize: 16),
                                maxLines: 1, // Batasi teks menjadi satu baris
                                overflow: TextOverflow.ellipsis,
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
              builder: (context) => AddPenilaianCustomersScreen(),
            ),
          );
        },
        backgroundColor: Colors.teal,
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
            label: 'Pesanan',
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
