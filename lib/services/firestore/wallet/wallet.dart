import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_cashflow/models/expence_class.dart';

class WalletService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAmount(String userId, double amount) async {
    DocumentReference docRef = _firestore.collection('wallets').doc(userId);
    try {
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.update({
          'incomes': FieldValue.arrayUnion([
            {
              'amount': amount,
              'timestamp': Timestamp.now(),
              'category': 'Income',
            }
          ]),
          'balance': FieldValue.increment(amount),
          'transactions': FieldValue.arrayUnion([
            {
              'amount': amount,
              'timestamp': Timestamp.now(),
              'category': 'Income',
            }
          ])
        });
      } else {
        await docRef.set({'balance': amount});
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deductAmount(String userId, ExpenceClass expence) async {
    DocumentReference docRef = _firestore.collection('wallets').doc(userId);
    try {
      await docRef.update({
        'balance': FieldValue.increment(-expence.amount),
      });

      await docRef.update({
        'expenses': FieldValue.arrayUnion([expence.toMap()])
      });

      await docRef.update({
        'transactions': FieldValue.arrayUnion([expence.toMap()])
      });
    } catch (e) {
      print(e);
    }
  }
}
