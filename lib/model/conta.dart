class Conta {
  String id;
  String prato;
  String valor;

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
