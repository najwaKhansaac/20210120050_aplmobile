import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Najwa kdc',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'BELAJAR RESTFULL API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<dynamic>> _fecthData() async {
    String url = 'http://localhost/smt5/api.php';
    var result = await http.get(Uri.parse(url));

    print(result.body);
    // list = result.body;

    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<dynamic>>(
                  future: _fecthData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: SizedBox(
                          height: 600,
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(snapshot
                                            .data[index]['foto_produk']),
                                      ),
                                      title: Text(
                                        snapshot.data[index]['nama_barang'],
                                      ),
                                      subtitle: Text(
                                        '${snapshot.data[index]['stok']} Pcs',
                                      ),
                                      trailing: const Icon(
                                          Icons.shopping_bag_outlined)),
                                );
                              }),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })
            ],
          ),
        ));
  }
}
