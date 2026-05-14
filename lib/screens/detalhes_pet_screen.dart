import 'package:flutter/material.dart';
import '../models/pet.dart';

class DetalhesPetScreen extends StatelessWidget {
  final Pet pet;

  const DetalhesPetScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(
          pet.nome,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              width: double.infinity,
              height: 240,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),

                gradient: const LinearGradient(
                  colors: [Color(0xFFCBA6F7), Color(0xFF9D7BFF)],
                ),
              ),

              child: const Center(
                child: Text('🐈', style: TextStyle(fontSize: 120)),
              ),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      pet.nome,

                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Muito feliz hoje ✨',

                      style: TextStyle(color: Colors.grey[400], fontSize: 16),
                    ),
                  ],
                ),

                Container(
                  padding: const EdgeInsets.all(14),

                  decoration: BoxDecoration(
                    color: const Color(0xFFCBA6F7).withOpacity(0.15),

                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: const Icon(
                    Icons.favorite,
                    color: Color(0xFFCBA6F7),
                    size: 32,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(child: _infoCard('Idade', '2 anos', Icons.cake)),

                const SizedBox(width: 14),

                Expanded(
                  child: _infoCard('Peso', '4.2kg', Icons.monitor_weight),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(child: _infoCard('Raça', 'Persa', Icons.pets)),

                const SizedBox(width: 14),

                Expanded(child: _infoCard('Humor', 'Feliz', Icons.mood)),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Descrição',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),

                borderRadius: BorderRadius.circular(24),
              ),

              child: Text(
                pet.descricao,

                style: TextStyle(
                  color: Colors.grey[300],
                  height: 1.7,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFCBA6F7), Color(0xFF9D7BFF)],
                ),

                borderRadius: BorderRadius.circular(28),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    '✨ IA do MeowCare',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Seu pet parece estar muito saudável hoje 🐾',

                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,

                      padding: const EdgeInsets.symmetric(vertical: 18),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    onPressed: () {},

                    child: const Center(
                      child: Text(
                        'Agendar cuidado',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String titulo, String valor, IconData icone) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),

        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        children: [
          Icon(icone, color: const Color(0xFFCBA6F7), size: 30),

          const SizedBox(height: 14),

          Text(
            valor,

            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Text(titulo, style: TextStyle(color: Colors.grey[400])),
        ],
      ),
    );
  }
}
