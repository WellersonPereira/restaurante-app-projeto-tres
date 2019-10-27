class Prato {
  String id;
  String nome;
  String tipo;
  String descricao;
  bool disponivel;
  String valor;
  static int qtd;
  String urlFoto;

  static setQuantidade(int quantidade) {
    Prato.qtd = quantidade;
  }

  Prato({this.id, this.nome, this.tipo, this.descricao, this.disponivel,
      this.valor, this.urlFoto});

  Prato.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    tipo = json['tipo'];
    descricao = json['descricao'];
    disponivel = json['disponivel'];
    valor = json['valor'];
    //qtd = json['quantidade'];
    urlFoto = json['urlFoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['tipo'] = this.tipo;
    data['descricao'] = this.descricao;
    data['disponivel'] = this.disponivel;
    data['valor'] = this.valor;
    //data['quantidade'] = this.qtd;
    data['urlfoto'] = this.urlFoto;
    return data;
  }
}
