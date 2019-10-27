class Conta {
  String id;
  String prato;
  static String pratoId;
  static int quantidade;
  String valor;

  static setPratoId(String pratoId) {
    Conta.pratoId = pratoId;
  }

  static setQuantidade(int quantidade) {
    Conta.quantidade = quantidade;
  }

  Conta({this.id, this.prato, this.valor});

  Conta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prato = json['prato'];
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prato'] = this.prato;
    data['valor'] = this.valor;
    return data;
  }
}
