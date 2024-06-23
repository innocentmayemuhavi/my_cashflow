import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_cashflow/models/transaction_model.dart';

class SavingsStreams {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _transactions =
      FirebaseFirestore.instance.collection('transactions');

  Stream<double> getSavingBalance(String userId) {
    return _firestore
        .collection('savings')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.exists
          ? (snapshot.data()!['balance'] as int).toDouble() ?? 0.0
          : 0.0;
    });
  }

  Stream<List<TransactionModel>> getSavings(String uid) {
    return _transactions
        .doc(uid)
        .collection('userTransactions')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return TransactionModel(
          amount: data['amount'],
          category: data['category'],
          timestamp: data['timestamp'],
        );
      }).toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
  }
}
