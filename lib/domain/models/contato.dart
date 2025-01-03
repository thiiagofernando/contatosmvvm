class Contato {
  final int? id;
  final String nome;
  final String email;
  final String telefone;

  Contato({
    this.id,
    required this.nome,
    required this.email,
    required this.telefone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
    };
  }

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
    );
  }
}