class Prato {
  int id;
  String tipo;
  String nome;
  String fotoUrl;

  Prato({this.tipo, this.nome, this.fotoUrl});

  Prato.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipo = json['tipo'];
    nome = json['nome'];
    fotoUrl = json['urlFoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo'] = this.tipo;
    data['nome'] = this.nome;
    data['urlfoto'] = this.fotoUrl;
    return data;
  }
}
