import 'package:my_cashflow/models/transaction_model.dart';

class PlansModel {
  final String id;
  final String category;
  final String color;
  final String planName;
  final int amount;
  final int spent;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<TransactionModel> transactions;

  PlansModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.color,
    required this.description,
    required this.endDate,
    required this.planName,
    required this.startDate,
    required this.spent,
    required this.transactions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'color': color,
      'description': description,
      'endDate': endDate,
      'planName': planName,
      'startDate': startDate,
      'spent': spent,
      'transactions': transactions
    };
  }
}
