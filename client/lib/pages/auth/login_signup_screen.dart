import 'package:flutter/material.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
           Align(
            alignment: Alignment.center,
            child: Image.asset('assets/logo/logo_dark.png', height: 250,),
          ),
          Positioned(
            bottom: 30,
            child: SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                       style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder (
                          side: BorderSide(
                            color: Colors.white
                          )
                        )
                      ),
                      child: const Text('Sign Up'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
