class Pet {
  final int id;
  final String nome;
  final String descricao;
  final String idade;
  final String peso;
  final String raca;
  final String humor;
  bool
  isFavorite; // 1. Adicionamos essa variável (sem o 'final' para podermos mudar)

  Pet({
    required this.id,
    required this.nome,
    required this.descricao,
    this.idade = '',
    this.peso = '',
    this.raca = '',
    this.humor = '',
    this.isFavorite = false, // 2. Por padrão, o pet não nasce favorito
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      nome: json['title'] ?? '',
      descricao: json['body'] ?? '',
      idade: json['idade'] ?? '',
      peso: json['peso'] ?? '',
      raca: json['raca'] ?? '',
      humor: json['humor'] ?? '',
      // 3. Lê do JSON se é favorito, se não vier nada, coloca falso
      isFavorite: json['isFavorite'] ?? false,
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
      'isFavorite': isFavorite, // 4. Salva o status do favorito no JSON
    };
  }
}
