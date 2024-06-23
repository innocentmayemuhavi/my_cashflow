import 'package:cloud_firestore/cloud_firestore.dart';
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
        return PlansModel(
          id: doc.data()['id'],
          amount: doc.data()['amount'],
          category: doc.data()['category'],
          color: doc.data()['color'],
          description: doc.data()['description'],
          endDate: (doc.data()['endDate'] as Timestamp).toDate(),
          planName: doc.data()['planName'],
          startDate: (doc.data()['startDate'] as Timestamp).toDate(),
          spent: doc.data()['spent'],
        );
      }).toList()
        ..sort((a, b) {
          return b.startDate.compareTo(a.startDate);
        });
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
        .collection('transactions')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return TransactionModel(
          amount: doc.data()['amount'],
          category: doc.data()['category'],
          timestamp: doc.data()['timestamp'],
        );
      }).toList();
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
