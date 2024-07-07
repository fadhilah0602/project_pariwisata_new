import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/model_pesanan.dart';
import '../model/model_user.dart';
import '../util/session_manager.dart';
import 'navigation_page.dart';
import 'profile.dart';

class PesananScreen extends StatefulWidget {
  const PesananScreen({super.key});


  @override
  State<PesananScreen> createState() => _PesananScreen();
}

class _PesananScreen extends State<PesananScreen> with WidgetsBindingObserver {
  late ModelUsers currentUser;
  late Pesanan pesanan;

  int _selectedIndex = 1;
  List<Pesanan> _pesananList = [];
  List<Pesanan> _filteredPesananList = [];
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getDataSession();
    _fetchPesanan();
  }

  Future<void> _fetchPesanan() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.42.233/pariwisata/listPesanan.php?id_user=${sessionManager.id_user}'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        setState(() {
          _pesananList = List<Pesanan>.from(parsed['data'].map((x) => Pesanan.fromJson(x)));
          _filteredPesananList = _pesananList;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load pesanan');
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future<void> deletePesanan(String idPesanan) async {
    final String apiUrl = 'http://192.168.42.233/pariwisata/deletePesanan.php';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {"id_pesanan": idPesanan},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['isSuccess']) {
        setState(() {
          _fetchPesanan();
          // _pesananList.removeAt(idPesanan.toString() as int);
          // _filteredPesananList = List.from(_pesananList);
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

  void _filterPesananList(String query) {
    setState(() {
      _filteredPesananList = _pesananList.where((pesanan) => pesanan.nama_pariwisata.toLowerCase().contains(query.toLowerCase())).toList();
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
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => OrderScreen()),
        // );
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
        title: Text('Pesanan Saya'),
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
                onChanged: _filterPesananList,
                decoration: InputDecoration(
                  labelText: 'Search Pesanan',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredPesananList.length,
                itemBuilder: (context, index) {
                  final pesanan = _filteredPesananList[index];
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
                              'http://192.168.42.233/pariwisata/${pesanan.gambar}', // URL gambar
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
                                pesanan.nama_pariwisata,
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                onPressed: () => deletePesanan(pesanan.id_pesanan.toString()),
                              ),
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
                                'Rp. ${pesanan.harga.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Jumlah:',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '${pesanan.jumlah}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Rp. ${pesanan.total.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.shopping_cart),
          //   label: 'Keranjang',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_outlined),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
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
