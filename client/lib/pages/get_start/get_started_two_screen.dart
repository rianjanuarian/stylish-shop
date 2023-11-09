import 'package:client/pages/auth/login_screen.dart';
import 'package:client/pages/auth/login_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedTwoScreen extends StatelessWidget {
  const GetStartedTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
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
            ],
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(left: 120),
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
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 175, 172, 172),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 40,
                      height: 15,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginSignupScreen()),
                    );
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
