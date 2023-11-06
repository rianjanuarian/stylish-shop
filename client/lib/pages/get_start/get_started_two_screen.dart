import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedTwoScreen extends StatelessWidget {
  const GetStartedTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Image.asset(
              'assets/images/baju2.png',
              width: double.infinity,
              height: 450,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 80,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Discover New \nFashion',
                    style: GoogleFonts.playfair(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 36,
                        height: 1),
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'It brings your the latets trends and \nproducts from the world...',
                    textAlign: TextAlign.end,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
