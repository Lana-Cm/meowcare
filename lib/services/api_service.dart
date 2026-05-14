import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pet.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // GET
  static Future<List<Pet>> buscarPets() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((json) => Pet.fromJson(json)).toList();
    }

    throw Exception('Erro ao carregar pets');
  }

  // POST
  static Future<Pet> criarPet(Pet pet) async {
    final response = await http.post(
      Uri.parse(baseUrl),

      headers: {'Content-Type': 'application/json'},

      body: jsonEncode(pet.toJson()),
    );

    if (response.statusCode == 201) {
      return Pet.fromJson(jsonDecode(response.body));
    }

    throw Exception('Erro ao criar pet: ${response.statusCode}');
  }

  // DELETE
  static Future<void> deletarPet(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar pet');
    }
  }

  // PUT
  static Future<Pet> atualizarPet(Pet pet) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${pet.id}'),

      headers: {'Content-Type': 'application/json'},

      body: jsonEncode(pet.toJson()),
    );

    if (response.statusCode == 200) {
      return Pet.fromJson(jsonDecode(response.body));
    }

    throw Exception('Erro ao atualizar pet');
  }
}
