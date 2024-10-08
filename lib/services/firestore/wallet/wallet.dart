import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_cashflow/models/expence_class.dart';

class WalletService {
  final CollectionReference _wallet =
      FirebaseFirestore.instance.collection('wallets');
  final CollectionReference _incomes =
      FirebaseFirestore.instance.collection('incomes');
  final CollectionReference _expenses =
      FirebaseFirestore.instance.collection('expenses');
  final CollectionReference _transactions =
      FirebaseFirestore.instance.collection('transactions');

  Future<void> addAmount(String userId, double amount) async {
    try {
      await _wallet.doc(userId).set({
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
        'category': 'Income',
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deductAmount(String userId, ExpenceClass expence) async {
    try {
      await _wallet.doc(userId).update({
        'balance': FieldValue.increment(-expence.amount.round()),
      });

      await _expenses.doc(userId).collection('userExpenses').add({
        'amount': expence.amount,
        'timestamp': Timestamp.now(),
        'category': expence.category,
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
