import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_cashflow/models/expence_class.dart';

class Savings {
  final CollectionReference _savings =
      FirebaseFirestore.instance.collection('savings');
  final CollectionReference _incomes =
      FirebaseFirestore.instance.collection('incomes');
  final CollectionReference _expenses =
      FirebaseFirestore.instance.collection('expenses');
  final CollectionReference _transactions =
      FirebaseFirestore.instance.collection('transactions');

  Future<void> AddSaving(String userId, double amount) async {
    try {
      await _savings.doc(userId).set({
        'balance': FieldValue.increment(amount.round()),
      }, SetOptions(merge: true));
      await _incomes.doc(userId).collection('userIncomes').add({
        'amount': amount,
        'timestamp': Timestamp.now(),
        'category': 'Income',
      });
      await _transactions.doc(userId).collection('userTransactions').add({
        'amount': amount,
        'timestamp': Timestamp.now(),
        'category': 'Saving',
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deductAmount(String userId, ExpenceClass expence) async {
    try {
      await _savings.doc(userId).update({
        'balance': FieldValue.increment(-expence.amount.round()),
      });

      await _transactions.doc(userId).collection('userTransactions').add({
        'amount': expence.amount,
        'timestamp': Timestamp.now(),
        'category': expence.category,
      });
    } catch (e) {
      print(e);
    }
  }
}
