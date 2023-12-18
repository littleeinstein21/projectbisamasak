import 'package:bisa/dummy_data.dart';
import 'package:bisa/firestore_dataUser.dart';
import 'package:bisa/widgets/video_masak.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final db = FirebaseFirestore.instance;

class ResepMasakanScreen extends StatefulWidget {
  final int index;

  const ResepMasakanScreen({Key? key, required this.index}) : super(key: key);

  @override
  _ResepMasakanScreenState createState() => _ResepMasakanScreenState();
}

class _ResepMasakanScreenState extends State<ResepMasakanScreen> {
  List<String> selectedItems = [];
  Map<String, dynamic>? data;
  List<dynamic>? resep;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resep Masakan',
          style: GoogleFonts.roboto(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 8, 32, 73),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<DocumentSnapshot>(
        future: db.collection('dataMasak').doc(dataMasak[widget.index].nama).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Text('Document does not exist');
          } else {
            // Document exists in the database
            data = snapshot.data!.data() as Map<String, dynamic>;

            // Extract data
            resep = List<String>.from(data!['resep'] ?? []);
            String videoUrl = data!['videoUrl'] ?? ''; // Tambahkan ini untuk mendapatkan URL video

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: resep?.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue, // Change circle color as needed
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: Colors.white, // Change text color to white
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8), // Add some spacing between number and text
                                Expanded(
                                  child: Text(resep?[index]),
                                ),
                              ],
                            ),
                            onTap: () {
                              _playVideo(videoUrl); // Memanggil fungsi untuk memutar video
                              setState(() {
                                // Use a Set for selectedItems
                                selectedItems.add(resep?[index]);
                                Firestore_Datasource().AddCart(selectedItems.toList());
                              });
                            },
                          ),
                          const Divider(
                            color: Colors.black,
                            height: 1.0,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _playVideo(String videoUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoMemasakScreen(
          videoUrl: videoUrl,
          nama: dataMasak[widget.index].nama,
        ),
      ),
    );
  }
}
