import 'package:flutter/material.dart';

import '../models/pet.dart';
import '../services/api_service.dart';

class EditarPetScreen extends StatefulWidget {
  final Pet pet;

  const EditarPetScreen({super.key, required this.pet});

  @override
  State<EditarPetScreen> createState() => _EditarPetScreenState();
}

class _EditarPetScreenState extends State<EditarPetScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nomeController;

  late TextEditingController descricaoController;

  bool salvando = false;

  @override
  void initState() {
    super.initState();

    nomeController = TextEditingController(text: widget.pet.nome);

    descricaoController = TextEditingController(text: widget.pet.descricao);
  }

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();

    super.dispose();
  }

  Future<void> atualizarPet() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      salvando = true;
    });

    final petAtualizado = Pet(
      id: widget.pet.id,
      nome: nomeController.text,
      descricao: descricaoController.text,
    );

    try {
      await ApiService.atualizarPet(petAtualizado);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('✨ Pet atualizado!')));

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao atualizar: $e')));
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
      appBar: AppBar(title: const Text('Editar Pet')),

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
                    return 'Informe a descrição';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                height: 58,

                child: ElevatedButton(
                  onPressed: salvando ? null : atualizarPet,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCBA6F7),

                    foregroundColor: Colors.black,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  child: Text(
                    salvando ? 'Salvando...' : '💜 Atualizar pet',

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
