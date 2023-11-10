import 'package:client/pages/get_start/get_started_two_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedOneScreen extends StatelessWidget {
  const GetStartedOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Image.asset(
                  'assets/images/baju1.png',
                  width: double.infinity,
                  height: 450,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 80,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explore \nTrendy Fashion',
                        style: GoogleFonts.playfair(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 36,
                            height: 1),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                          'Explore the 2023’s hottest fashion in the \namazing world'),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 175, 172, 172),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                         
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const GetStartedTwoScreen()
        ],
      ),
    );
  }
}
