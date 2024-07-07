import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/model_pariwisata.dart';
import '../util/session_manager.dart';

class AddPesanan extends StatefulWidget {
  final Pariwisata data;

  AddPesanan({required this.data});

  @override
  _AddPesananState createState() => _AddPesananState();
}

class _AddPesananState extends State<AddPesanan> {
  int jumlah = 1;
  bool _isAddingToPesanan = false;

  void _incrementQuantity() {
    setState(() {
      jumlah++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (jumlah > 1) {
        jumlah--;
      }
    });
  }

  Future<void> _addToPesanan(Pariwisata pariwisata) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.42.233/pariwisata/addPesanan.php'),
        body: {
          'id_user': sessionManager.id_user,
          'id_pariwisata': pariwisata.id_pariwisata,
          'jumlah': jumlah.toString(),
        },
      );

      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200 && responseBody['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Product added to cart successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['message'] ?? "Failed to add product to cart")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error adding product to cart: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 223, 221, 221),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Jumlah : ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, color: Colors.greenAccent),
                      onPressed: _decrementQuantity,
                    ),
                    Text(
                      '$jumlah',
                      style: TextStyle(fontSize: 16, color: Colors.greenAccent),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.greenAccent),
                      onPressed: _incrementQuantity,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                MaterialButton(
                  onPressed: () async {
                    await _addToPesanan(widget.data);
                  },
                  color: Color(0xFF88AB8E),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 5),
                      Text(
                        "add to pesanan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
