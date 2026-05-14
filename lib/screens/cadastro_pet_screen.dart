import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../services/api_service.dart';

class CadastroPetScreen extends StatefulWidget {
  const CadastroPetScreen({super.key});

  @override
  State<CadastroPetScreen> createState() => _CadastroPetScreenState();
}

class _CadastroPetScreenState extends State<CadastroPetScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores existentes
  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();

  // NOVOS controladores
  final idadeController = TextEditingController();
  final pesoController = TextEditingController();
  final racaController = TextEditingController();
  final humorController = TextEditingController();

  bool salvando = false;

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();
    idadeController.dispose();
    pesoController.dispose();
    racaController.dispose();
    humorController.dispose();
    super.dispose();
  }

  Future<void> salvarPet() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      salvando = true;
    });

    final pet = Pet(
      id: 0,
      nome: nomeController.text,
      descricao: descricaoController.text,
      idade: idadeController.text,
      peso: pesoController.text,
      raca: racaController.text,
      humor: humorController.text,
    );

    try {
      final novoPet = await ApiService.criarPet(pet);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🐾 Pet cadastrado com sucesso!'),
          backgroundColor: Colors.purple,
        ),
      );

      Navigator.pop(context, novoPet);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao cadastrar: $e')));
    } finally {
      if (mounted) {
        setState(() {
          salvando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Pet')),
      body: SingleChildScrollView(
        // Evita erro de layout com o teclado
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do pet',
                  prefixIcon: Icon(Icons.pets),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Informe o nome'
                    : null,
              ),
              const SizedBox(height: 15),

              // Linha com Idade e Peso lado a lado
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: idadeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Idade',
                        prefixIcon: Icon(Icons.cake),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextFormField(
                      controller: pesoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Peso (kg)',
                        prefixIcon: Icon(Icons.monitor_weight),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: racaController,
                decoration: const InputDecoration(
                  labelText: 'Raça',
                  prefixIcon: Icon(Icons.category),
                ),
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: humorController,
                decoration: const InputDecoration(
                  labelText: 'Como ele está hoje? (Humor)',
                  prefixIcon: Icon(Icons.mood),
                ),
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: descricaoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.notes),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Informe uma descrição'
                    : null,
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: salvando ? null : salvarPet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCBA6F7),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    salvando ? 'Salvando...' : '✨ Salvar pet',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}