import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dummy_data.dart';

final db = FirebaseFirestore.instance;

class TataCaraMasakScreen extends StatelessWidget {
  final int index;

  TataCaraMasakScreen({required this.index});

  Map<String, dynamic>? data;
  String? nama;
  List<String>? cara;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tata Cara Memasak',
          style: GoogleFonts.roboto(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 8, 32, 73),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: db.collection('dataMasak').doc(dataMasak[index].nama).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            ); // Loading indicator while waiting for data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Text('Document does not exist');
          } else {
            // Document exists in the database
            data = snapshot.data!.data() as Map<String, dynamic>;

            // Extract data
            nama = data!['nama'].toString();
            cara = List<String>.from(data!['cara'] ?? []);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Langkah-langkah memasak $nama:',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cara?.length,
                      itemBuilder: (context, i) => ListTile(
                        leading: CircleAvatar(child: Text((i + 1).toString())),
                        title: Text(cara![i]),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
