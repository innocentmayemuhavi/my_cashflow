import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenceClass {
  double amount;
  Timestamp timestamp;
  String category;

  ExpenceClass(
      {required this.amount, required this.timestamp, required this.category});

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'timestamp': timestamp,
      'category': category,
    };
  }
}
