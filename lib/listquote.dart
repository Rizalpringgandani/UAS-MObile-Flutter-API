import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListQuote extends StatelessWidget {
  final String apiUrl =
      "https://indonesia-public-static-api.vercel.app/api/heroes";

  const ListQuote({super.key});

  Future<List<dynamic>> _fetchListQuotes() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nama-nama Pahlawan'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchListQuotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var listTile = ListTile(
                  
                  title: Text(
                    snapshot.data[index]['name'].toString(),
                    textAlign: TextAlign.justify,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "lahir: " + snapshot.data[index]['birth_year'].toString(),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "wafat: " + snapshot.data[index]['death_year'].toString(),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "deskripsi: " + snapshot.data[index]['description'],
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "tahun kenaikan: " + snapshot.data[index]['ascension_year'].toString(),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                     
                    ],
                  ),
                  // trailing: SizedBox(
                  //   width: 60,
                  //   child: Row(
                  //     children: [
                  //       Text(snapshot.data[index]['id'].toString()),
                  //     ],
                  //   ),
                  // ),
                );
                return Card(
                  child: listTile,
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}