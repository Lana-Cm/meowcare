import 'package:flutter/material.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int paginaAtual = 0;

  final paginas = [
    const HomeScreen(),
    const FavoritosScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: paginas[paginaAtual],

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),

          borderRadius: BorderRadius.circular(30),

          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),

          child: BottomNavigationBar(
            currentIndex: paginaAtual,

            onTap: (index) {
              setState(() {
                paginaAtual = index;
              });
            },

            backgroundColor: const Color(0xFF1E1E1E),

            selectedItemColor: const Color(0xFFCBA6F7),

            unselectedItemColor: Colors.grey,

            elevation: 0,

            type: BottomNavigationBarType.fixed,

            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Favoritos',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),

      appBar: AppBar(title: const Text('⭐ Favoritos')),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Icon(Icons.star, size: 80, color: Color(0xFFCBA6F7)),

            const SizedBox(height: 20),

            const Text(
              'Seus pets favoritos aparecerão aqui 💜',

              textAlign: TextAlign.center,

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),

      appBar: AppBar(title: const Text('👤 Perfil')),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,

              decoration: BoxDecoration(
                color: const Color(0xFFCBA6F7).withOpacity(0.2),

                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.person,
                size: 70,
                color: Color(0xFFCBA6F7),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Alana 🐾',

              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              'Tutora premium do MeowCare',

              style: TextStyle(color: Colors.grey[400]),
            ),

            const SizedBox(height: 40),

            _perfilCard(Icons.pets, 'Pets cadastrados', '10'),

            const SizedBox(height: 16),

            _perfilCard(Icons.star, 'Favoritos', '4'),

            const SizedBox(height: 16),

            _perfilCard(Icons.health_and_safety, 'Cuidados realizados', '28'),
          ],
        ),
      ),
    );
  }

  Widget _perfilCard(IconData icone, String titulo, String valor) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),

        borderRadius: BorderRadius.circular(24),
      ),

      child: Row(
        children: [
          Icon(icone, color: const Color(0xFFCBA6F7), size: 30),

          const SizedBox(width: 18),

          Expanded(
            child: Text(
              titulo,

              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          Text(
            valor,

            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
