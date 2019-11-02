class Conta {
  String id;
  String prato;
  String pedidoId;
  static int quantidade;
  int qtd;
  String valor;
  String status;
  double total = 0;

  static setQuantidade(int quantidade) {
    Conta.quantidade = quantidade;
  }

  Conta({this.id, this.prato, this.valor, this.qtd, this.status, this.pedidoId});

  Conta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prato = json['prato'];
    valor = json['valor'];
    qtd = json['quantidade'];
    status = json['status'];
    pedidoId = json['pedidoId'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prato'] = this.prato;
    data['valor'] = this.valor;
    data['quantidade'] = this.qtd;
    data['status'] = this.status;
    data['pedidoId'] = this.pedidoId;
    data['total'] = this.total;
    return data;
  }
}
