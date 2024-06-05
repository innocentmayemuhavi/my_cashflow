import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_cashflow/models/Incomes_model.dart';
import 'package:my_cashflow/models/transaction_model.dart';

class Walletstream {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<double> getBalance(String userId) {
    return _firestore
        .collection('wallets')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.exists ? snapshot.data()!['balance'] ?? 0.0 : 0.0;
    });
  }

  Stream<IncomesClass> getIncome(String userId) {
    return _firestore
        .collection('wallets')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        List<dynamic> incomes = snapshot.data()!['incomes'];
        double totalIncome = snapshot.exists
            ? (snapshot.data()!['incomes'] as List)
                .map((item) => item['amount'])
                .reduce((a, b) => a + b)
            : 0.0;

        double getPercentageChange(List<dynamic> incomes) {
          if (incomes.length >= 2) {
            double lastIncome = incomes[incomes.length - 1]['amount'];
            double secondLastIncome = incomes[incomes.length - 2]['amount'];
            if (secondLastIncome != 0) {
              double percentageChange = ((lastIncome - secondLastIncome) /
                      (secondLastIncome + lastIncome)) *
                  100;
              return double.parse(percentageChange.toStringAsFixed(2));
            } else {
              return 0.0; // Return 0.0 if the second last income is 0
            }
          } else {
            return 0.0; // Return 0.0 if there are less than 2 incomes
          }
        }

        double percentageChange = getPercentageChange(incomes);
        return IncomesClass(total: totalIncome, percentage: percentageChange);
      }

      return IncomesClass(total: 0.0, percentage: 0.0);
    });
  }

  Stream<IncomesClass> getSpending(String userId) {
    return _firestore
        .collection('wallets')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        List<dynamic> expenses = snapshot.data()!['expenses'];
        double totalIncome = snapshot.exists
            ? (snapshot.data()!['expenses'] as List)
                .map((item) => item['amount'])
                .reduce((a, b) => a + b)
            : 0.0;

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
              return 0.0; // Return 0.0 if the second last income is 0
            }
          } else {
            return 0.0; // Return 0.0 if there are less than 2 expenses
          }
        }

        double percentageChange = getPercentageChange(expenses);
        return IncomesClass(total: totalIncome, percentage: percentageChange);
      }

      return IncomesClass(total: 0.0, percentage: 0.0);
    });
  }

  Stream<List<TransactionModel>> getTransactions(String userId) {
    return _firestore
        .collection('wallets')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        List<dynamic> transactions = snapshot.data()!['transactions'];
        return transactions
            .map((transaction) => TransactionModel(
                  amount: transaction['amount'],
                  category: transaction['category'],
                  timestamp: transaction['timestamp'],
                ))
            .toList()
          ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      } else {
        return [];
      }
    });
  }
}
