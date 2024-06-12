import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final double amount;
  final String category;
  final Timestamp timestamp;

  TransactionModel({
    required this.amount,
    required this.category,
    required this.timestamp,
  });

  toMap() {
    return {
      'amount': amount,
      'category': category,
      'timestamp': timestamp,
    };
  }
}
