import 'package:flutter/material.dart';
import '../models/pet.dart';
import 'detalhes_pet_screen.dart';

class FavoritosScreen extends StatelessWidget {
  final List<Pet> todosOsPets;
  final List<int> favoritosIds;

  const FavoritosScreen({
    super.key,
    required this.todosOsPets,
    required this.favoritosIds,
  });

  @override
  Widget build(BuildContext context) {
    // Filtra os pets: só entram os que o ID está na lista de favoritos
    final listaFavoritos = todosOsPets
        .where((pet) => favoritosIds.contains(pet.id))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        title: const Text(
          'Meus Favoritos 💜',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: listaFavoritos.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: listaFavoritos.length,
              itemBuilder: (context, index) {
                final pet = listaFavoritos[index];
                return _buildPetCard(context, pet);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('⭐', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 20),
          const Text(
            'Nada por aqui ainda',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Seus pets favoritos aparecerão aqui!',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildPetCard(BuildContext context, Pet pet) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetalhesPetScreen(pet: pet)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.amber.withOpacity(0.5), width: 1),
        ),
        child: Row(
          children: [
            const Text('🐈', style: TextStyle(fontSize: 36)),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.nome,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(pet.raca, style: TextStyle(color: Colors.grey[400])),
                ],
              ),
            ),
            const Icon(Icons.star, color: Colors.amber),
          ],
        ),
      ),
    );
  }
}
