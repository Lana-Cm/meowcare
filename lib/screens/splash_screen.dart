import 'dart:async';
import 'package:flutter/material.dart';
import 'main_screen.dart'; // Verifique se o nome do arquivo é este mesmo

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animacaoFade;
  late Animation<double> animacaoScale;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Animação de Opacidade (Surgir)
    animacaoFade = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    // Animação de Escala (Crescer levemente)
    animacaoScale = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));

    controller.forward();

    // Timer de 3 segundos para ir para a tela principal
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
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
          opacity: animacaoFade,
          child: ScaleTransition(
            scale: animacaoScale,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo estilizado com degradê e sombra
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
                        offset: const Offset(0, 10),
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
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Cuidando do seu pet com amor 💜',
                  style: TextStyle(color: Colors.grey[400], fontSize: 16),
                ),
                const SizedBox(height: 60),
                // Carregamento combinando com o tema
                const CircularProgressIndicator(
                  color: Color(0xFFCBA6F7),
                  strokeWidth: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}