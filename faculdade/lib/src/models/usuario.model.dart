class User {
  final String nome;
  final String email;
  final String senha;

  User(this.nome, this.email, this.senha);

  static fromJson(data) {
    return User(data['nome'], data['email'], data['senha']);
  }
}
