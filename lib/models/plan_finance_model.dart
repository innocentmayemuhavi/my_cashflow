class PlanFinanceModel {
  final int amount;
  final int spent;

  PlanFinanceModel({required this.amount, required this.spent});

  Map<String, dynamic> toMap() {
    return {'amount': amount, 'spent': spent};
  }
}
