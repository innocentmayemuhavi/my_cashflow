import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_cashflow/models/Incomes_model.dart';
import 'package:my_cashflow/models/transaction_model.dart';

class Walletstream {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _transactions =
      FirebaseFirestore.instance.collection('transactions');
  final CollectionReference _incomes =
      FirebaseFirestore.instance.collection('incomes');
  final CollectionReference _expenses =
      FirebaseFirestore.instance.collection('expenses');
  final CollectionReference _savings =
      FirebaseFirestore.instance.collection('savings');

  Stream<double> getBalance(String userId) {
    return _firestore
        .collection('wallets')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.exists
          ? (snapshot.data()!['balance'] as int).toDouble() ?? 0.0
          : 0.0;
    });
  }

  Stream<IncomesClass> getIncome(String userId) {
    return _incomes
        .doc(userId)
        .collection('userIncomes')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        double totalIncome = snapshot.docs
            .map((doc) => doc.data()['amount'])
            .reduce((a, b) => a + b);

        double getPercentageChange(List<dynamic> incomes) {
          if (incomes.length >= 2) {
            double lastIncome = incomes[incomes.length - 1]['amount'];
            double secondLastIncome = incomes[incomes.length - 2]['amount'];
            if (secondLastIncome != 0) {
              double percentageChange =
                  ((lastIncome - secondLastIncome) / secondLastIncome) * 100;
              return double.parse(percentageChange.toStringAsFixed(2));
            } else {
              return 0.0; // Return 0.0 if the second last income is 0
            }
          } else {
            return 0.0; // Return 0.0 if there are less than 2 incomes
          }
        }

        double percentageChange = getPercentageChange(snapshot.docs);
        print(percentageChange);
        return IncomesClass(total: totalIncome, percentage: percentageChange);
      }

      return IncomesClass(total: 0.0, percentage: 0.0);
    });
  }

  Stream<IncomesClass> getSpending(String userId) {
    return _expenses
        .doc(userId)
        .collection('userExpenses')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        double totalSpending = snapshot.docs
            .map((doc) => doc.data()['amount'])
            .reduce((a, b) => a + b);

        double getPercentageChange(List<dynamic> expenses) {
          if (expenses.length >= 2) {
            double lastexpence = expenses[expenses.length - 1]['amount'];
            double secondLastexpence = expenses[expenses.length - 2]['amount'];
            if (secondLastexpence != 0) {
              double percentageChange = ((lastexpence - secondLastexpence) /
                      (secondLastexpence + lastexpence)) *
                  100;
              return double.parse(percentageChange.toStringAsFixed(2));
            } else {
              return 1.0; // Return 0.0 if the second last income is 0
            }
          } else {
            return 1.0; // Return 0.0 if there are less than 2 expenses
          }
        }

        double percentageChange = getPercentageChange(snapshot.docs);
        return IncomesClass(total: totalSpending, percentage: percentageChange);
      }

      return IncomesClass(total: 0.0, percentage: 0.0);
    });
  }

  Stream<List<TransactionModel>> getTransactions(String uid) {
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

//get incomes
  Stream<List<TransactionModel>> getIncomes(String uid) {
    return _incomes
        .doc(uid)
        .collection('userIncomes')
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

  //get expences
  Stream<List<TransactionModel>> getExpences(String uid) {
    return _expenses
        .doc(uid)
        .collection('userExpenses')
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
