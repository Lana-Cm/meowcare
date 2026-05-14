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

  final nomeController = TextEditingController();

  final descricaoController = TextEditingController();

  bool salvando = false;

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();

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
    );

    try {
      final novoPet = await ApiService.criarPet(pet);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('🐾 Pet cadastrado com sucesso!')),
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

      body: Padding(
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

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: descricaoController,

                maxLines: 4,

                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.notes),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe uma descrição';
                  }

                  return null;
                },
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
