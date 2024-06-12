import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_cashflow/models/plan_finance_model.dart';
import 'package:my_cashflow/models/plans_model.dart';
import 'package:my_cashflow/models/transaction_model.dart';

class PlansStreams {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List> getPlans(String userId) {
    return _firestore
        .collection('plans')
        .doc(userId)
        .collection('userPlans')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

//fetching plan transactions
  Stream<List<TransactionModel>> getTransactionsForPlan(
      String userId, String planId) {
    return _firestore
        .collection('plans')
        .doc(userId)
        .collection('userPlans')
        .doc(planId)
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      var data = snapshot.data() as Map<String, dynamic>?; // Safely cast to Map
      if (data == null || !snapshot.exists)
        return []; // Return empty list if no data or snapshot doesn't exist
      var transactionsData =
          data['transactions'] as List<dynamic>?; // Extract transactions
      if (transactionsData == null)
        return []; // Return empty list if no transactions
      return transactionsData.map((transaction) {
        return TransactionModel(
          amount: transaction['amount'],
          category: transaction['category'],
          timestamp: transaction['timestamp'],
        );
      }).toList()
        ..sort((b, a) => a.timestamp.compareTo(b.timestamp));
    });
  }

  Stream getPlanFinance(String uid, String planId) {
    return _firestore
        .collection('plans')
        .doc(uid)
        .collection('userPlans')
        .doc(planId)
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      var data = snapshot.data() as Map<String, dynamic>?; // Safely cast to Map
      return {
        'amount': data!['amount'],
        'spent': data['spent'],
      };
    });
  }
}
