import 'package:cloud_firestore/cloud_firestore.dart';

class PlansModel {
  final String id;
  final String category;
  final String color;
  final String planName;
  final int amount;
  final int spent;
  final String description;
  final DateTime startDate; // Changed to DateTime
  final DateTime endDate; // Changed to DateTime

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
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'color': color,
      'description': description,
      'endDate':
          Timestamp.fromDate(endDate), // Convert DateTime back to Timestamp
      'planName': planName,
      'startDate':
          Timestamp.fromDate(startDate), // Convert DateTime back to Timestamp
      'spent': spent,
      // Ensure transactions are properly serialized
    };
  }
}
