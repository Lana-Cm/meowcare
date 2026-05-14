class Pet {
  final int id;
  final String nome;
  final String descricao;

  Pet({
    required this.id,
    required this.nome,
    required this.descricao,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      nome: json['title'] ?? '',
      descricao: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': nome,
      'body': descricao,
    };
  }
}