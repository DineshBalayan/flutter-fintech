// @dart=2.10
class GetDropDownDataResponse {
  DropDownData data;
  int code;
  String message;
  bool success;

  GetDropDownDataResponse({this.data, this.code, this.message, this.success});

  factory GetDropDownDataResponse.fromJson(Map<String, dynamic> json) {
    return GetDropDownDataResponse(
      data: json['data'] != null ? DropDownData.fromJson(json['data']) : null,
      code: json['code'],
      message: json['message'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DropDownData {
  List<Bank> banks;
  List<FinProduct> fin_products;
  List<PosIncome> pos_incomes;
  List<StateData> states;

  DropDownData({this.banks, this.fin_products, this.pos_incomes, this.states});

  factory DropDownData.fromJson(Map<String, dynamic> json) {
    return DropDownData(
      banks: json['banks'] != null
          ? (json['banks'] as List).map((i) => Bank.fromJson(i)).toList()
          : null,
      fin_products: json['fin_products'] != null
          ? (json['fin_products'] as List)
              .map((i) => FinProduct.fromJson(i))
              .toList()
          : null,
      pos_incomes: json['pos_incomes'] != null
          ? (json['pos_incomes'] as List)
              .map((i) => PosIncome.fromJson(i))
              .toList()
          : null,
      states: json['states'] != null
          ? (json['states'] as List).map((i) => StateData.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banks != null) {
      data['banks'] = this.banks.map((v) => v.toJson()).toList();
    }
    if (this.fin_products != null) {
      data['fin_products'] = this.fin_products.map((v) => v.toJson()).toList();
    }
    if (this.pos_incomes != null) {
      data['pos_incomes'] = this.pos_incomes.map((v) => v.toJson()).toList();
    }
    if (this.states != null) {
      data['states'] = this.states.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bank {
  String bank_title;
  int id;

  Bank({this.bank_title, this.id});

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      bank_title: json['bank_title'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_title'] = this.bank_title;
    data['id'] = this.id;
    return data;
  }

  @override
  String toString() {
    return this.bank_title;
  }
}

class FinProduct {
  int id;
  String product_name;

  FinProduct({this.id, this.product_name});

  factory FinProduct.fromJson(Map<String, dynamic> json) {
    return FinProduct(
      id: json['id'],
      product_name: json['product_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.product_name;
    return data;
  }
}

class StateData {
  int id;
  String state_name;

  StateData({this.id, this.state_name});

  factory StateData.fromJson(Map<String, dynamic> json) {
    return StateData(
      id: json['id'],
      state_name: json['state_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_name'] = this.state_name;
    return data;
  }
}

class PosIncome {
  int id;
  String title;

  PosIncome({this.id, this.title});

  factory PosIncome.fromJson(Map<String, dynamic> json) {
    return PosIncome(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
