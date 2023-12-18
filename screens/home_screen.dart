import 'package:bisa/screens/loginscreen.dart';
import 'package:bisa/screens/option_screen.dart';
import 'package:bisa/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final int index;

  const HomeScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/wallpaper.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Removed shopping cart button
                _buildLogoAndOptions(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoAndOptions(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logobisamasak.png'),
          const SizedBox(height: 20.0),
          _buildOptionButton(context, 'Start Cooking', OptionScreen(), false),
          const SizedBox(height: 10),
          _buildOptionButton(context, 'Recipe Watchlist', WatchListScreen(), false),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Or',
                style: GoogleFonts.kdamThmorPro(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildOptionButton(context, 'LogOut', LoginScreen(), false),
        ],
      ),
    );
  }

  Widget _buildOptionButton(
    BuildContext context,
    String label,
    Widget destination,
    bool showArrow,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        height: 70.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: label == 'LogOut' ? Colors.white.withOpacity(0.5) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.kdamThmorPro(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
