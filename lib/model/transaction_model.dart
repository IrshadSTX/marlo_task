class TransactionModel {
  String? errorFlag;
  String? message;
  List<Transaction>? data;

  TransactionModel({
    this.errorFlag,
    this.message,
    this.data,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> dataList = json['data'];
    List<Transaction> transactions =
        dataList.map((item) => Transaction.fromJson(item)).toList();

    return TransactionModel(
      errorFlag: json['error_flag'],
      message: json['message'],
      data: transactions,
    );
  }
}

class Transaction {
  String? id;
  String? amount;
  String? status;
  String? sourceId;
  String? sourceType;
  String? transactionType;
  String? currency;
  String? createdAt;
  String? fee;
  String? description;
  String? settledAt;
  String? estimatedSettledAt;
  String? currency1;

  Transaction({
    this.id,
    this.amount,
    this.status,
    this.sourceId,
    this.sourceType,
    this.transactionType,
    this.currency,
    this.createdAt,
    this.fee,
    this.description,
    this.settledAt,
    this.estimatedSettledAt,
    this.currency1,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: json['amount'],
      status: json['status'],
      sourceId: json['sourceId'],
      sourceType: json['sourceType'],
      transactionType: json['transactionType'],
      currency: json['currency'],
      createdAt: json['createdAt'],
      fee: json['fee'],
      description: json['description'],
      settledAt: json['settledAt'],
      estimatedSettledAt: json['estimatedSettledAt'],
      currency1: json['currency1'],
    );
  }
}
