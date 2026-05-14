class Pet {
  final int id;
  final String nome;
  final String descricao;
  // Novos campos adicionados:
  final String idade;
  final String peso;
  final String raca;
  final String humor;

  Pet({
    required this.id,
    required this.nome,
    required this.descricao,
    this.idade = '',
    this.peso = '',
    this.raca = '',
    this.humor = '',
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      nome: json['title'] ?? '',
      descricao: json['body'] ?? '',
      // Mapeando os novos campos do JSON
      // O ?? '' garante que o app não quebre se o campo vier vazio
      idade: json['idade'] ?? '',
      peso: json['peso'] ?? '',
      raca: json['raca'] ?? '',
      humor: json['humor'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': nome,
      'body': descricao,
      'idade': idade,
      'peso': peso,
      'raca': raca,
      'humor': humor,
    };
  }
}