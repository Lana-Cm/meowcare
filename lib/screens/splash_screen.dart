import 'dart:async';
import 'package:flutter/material.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animacao;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animacao = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),

      body: Center(
        child: FadeTransition(
          opacity: animacao,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                width: 160,
                height: 160,

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFCBA6F7), Color(0xFF9D7BFF)],
                  ),

                  borderRadius: BorderRadius.circular(40),

                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFCBA6F7).withOpacity(0.4),

                      blurRadius: 30,
                    ),
                  ],
                ),

                child: const Center(
                  child: Text('🐾', style: TextStyle(fontSize: 80)),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                'MeowCare',

                style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 14),

              Text(
                'Cuidando do seu pet com amor 💜',

                style: TextStyle(color: Colors.grey[400], fontSize: 16),
              ),

              const SizedBox(height: 50),

              const CircularProgressIndicator(color: Color(0xFFCBA6F7)),
            ],
          ),
        ),
      ),
    );
  }
}
