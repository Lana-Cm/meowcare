import 'package:flutter/material.dart';
import 'cadastro_pet_screen.dart';
import '../models/pet.dart';
import '../services/api_service.dart';
import 'editar_pet_screen.dart';
import 'detalhes_pet_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pet> pets = [];
  List<Pet> petsFiltrados = [];
  List<int> favoritos = [];

  bool carregando = true;

  final buscaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarPets();
  }

  @override
  void dispose() {
    buscaController.dispose();
    super.dispose();
  }

  Future<void> carregarPets() async {
    try {
      final resultado = await ApiService.buscarPets();

      setState(() {
        pets = resultado.take(10).toList();
        petsFiltrados = pets;
        carregando = false;
      });
    } catch (e) {
      setState(() {
        carregando = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao carregar pets: $e')));
    }
  }

  Future<void> deletarPet(Pet pet) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Excluir pet'),
          content: Text('Deseja excluir ${pet.nome}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );

    if (confirmar != true) return;

    try {
      await ApiService.deletarPet(pet.id);

      setState(() {
        pets.removeWhere((item) => item.id == pet.id);

        petsFiltrados.removeWhere((item) => item.id == pet.id);

        favoritos.remove(pet.id);
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('🐾 Pet removido com sucesso')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao excluir: $e')));
    }
  }

  void filtrarPets(String texto) {
    setState(() {
      petsFiltrados = pets.where((pet) {
        return pet.nome.toLowerCase().contains(texto.toLowerCase());
      }).toList();
    });
  }

  void toggleFavorito(int id) {
    setState(() {
      if (favoritos.contains(id)) {
        favoritos.remove(id);
      } else {
        favoritos.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🐾 MeowCare',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFCBA6F7),
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () async {
          final novoPet = await Navigator.push<Pet>(
            context,
            MaterialPageRoute(builder: (context) => const CadastroPetScreen()),
          );

          if (novoPet != null) {
            setState(() {
              pets.insert(0, novoPet);
              petsFiltrados = pets;
            });
          }
        },
      ),

      body: carregando
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFCBA6F7)),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Olá, Alana 🐾',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          'MeowCare',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCBA6F7).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(Icons.pets, color: Color(0xFFCBA6F7)),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(
                      child: _infoCard(
                        'Pets',
                        pets.length.toString(),
                        Icons.favorite,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: _infoCard(
                        'Favoritos',
                        favoritos.length.toString(),
                        Icons.star,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFCBA6F7), Color(0xFF9D7BFF)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '✨ Assistente inteligente',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        'Luna parece muito feliz hoje 🐈',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                TextField(
                  controller: buscaController,
                  onChanged: filtrarPets,
                  decoration: InputDecoration(
                    hintText: 'Buscar pet...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: const Color(0xFF1E1E1E),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Seus pets',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 18),

                ...petsFiltrados.map((pet) {
                  final ehFavorito = favoritos.contains(pet.id);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalhesPetScreen(pet: pet),
                        ),
                      );
                    },

                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),

                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),

                        borderRadius: BorderRadius.circular(24),

                        border: ehFavorito
                            ? Border.all(color: Colors.amber, width: 2)
                            : null,
                      ),

                      child: Row(
                        children: [
                          Container(
                            width: 65,
                            height: 65,

                            decoration: BoxDecoration(
                              color: const Color(0xFFCBA6F7).withOpacity(0.15),

                              borderRadius: BorderRadius.circular(18),
                            ),

                            child: const Center(
                              child: Text('🐈', style: TextStyle(fontSize: 36)),
                            ),
                          ),

                          const SizedBox(width: 18),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        pet.nome,

                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    if (ehFavorito)
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                  ],
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  pet.descricao,

                                  maxLines: 2,

                                  overflow: TextOverflow.ellipsis,

                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  toggleFavorito(pet.id);
                                },

                                icon: Icon(
                                  ehFavorito ? Icons.star : Icons.star_border,

                                  color: ehFavorito
                                      ? Colors.amber
                                      : Colors.grey,
                                ),
                              ),

                              IconButton(
                                onPressed: () async {
                                  final atualizou = await Navigator.push<bool>(
                                    context,

                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditarPetScreen(pet: pet),
                                    ),
                                  );

                                  if (atualizou == true) {
                                    carregarPets();
                                  }
                                },

                                icon: const Icon(
                                  Icons.edit_outlined,

                                  color: Color(0xFFCBA6F7),
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  deletarPet(pet);
                                },

                                icon: const Icon(
                                  Icons.delete_outline,

                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
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
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Icon(icone, color: const Color(0xFFCBA6F7)),

          const SizedBox(height: 14),

          Text(
            valor,

            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Text(titulo, style: TextStyle(color: Colors.grey[400])),
        ],
      ),
    );
  }
}
