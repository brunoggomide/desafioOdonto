class StudentsModel {
  final String nome;
  final String email;
  final String cod;

  StudentsModel(this.nome, this.email, this.cod);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'nome': nome, 'email': email, 'cod': cod};
  }

  factory StudentsModel.fromJson(Map<String, dynamic> json) {
    return StudentsModel(
      json['nome'],
      json['email'],
      json['cod'],
    );
  }
}
