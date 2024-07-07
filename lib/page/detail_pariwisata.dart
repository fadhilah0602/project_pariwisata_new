import 'package:flutter/material.dart';

import '../model/model_pariwisata.dart';
import 'add_pesanan.dart';

class DetailPariwisata extends StatelessWidget {
  final Pariwisata? data;

  const DetailPariwisata({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("data.id_kategori: ${data?.id_kategori}");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFAFC8AD),
          title: Text('Detail Pariwisata'),
        ),
        backgroundColor: Color(0xFFAFC8AD),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: data != null && data!.gambar.isNotEmpty
                        ? Image.network(
                      'http://192.168.42.233/pariwisata/${data!.gambar}',
                      fit: BoxFit.fill,
                      width: 300,
                      height: 200,
                    )
                        : Container(),
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data?.nama_pariwisata ?? 'No Title',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          data?.keterangan ?? 'No Content',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Rubik',
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Harga : Rp.${data?.harga ?? 'No Title'}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lokasi : ${data?.lokasi ?? 'No Content'}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "id_kategori : ${data?.id_kategori ?? 'No Content'}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  // Tampilkan tombol "add to pesanan" jika id_kategori == 1
                  // if (data?.id_kategori == 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return AddPesanan(data: data!);
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 5),
                              Text(
                                "add to pesanan",
                                style: TextStyle(color: Colors.greenAccent),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
