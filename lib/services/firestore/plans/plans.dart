import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_cashflow/models/plans_model.dart';
import 'package:my_cashflow/models/transaction_model.dart';

class PlansServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _transactions =
      FirebaseFirestore.instance.collection('transactions');
  final CollectionReference _plans =
      FirebaseFirestore.instance.collection('plans');

  Future<void> addPlan(String userId, PlansModel plan) async {
    await _firestore
        .collection('plans')
        .doc(userId)
        .collection('userPlans')
        .doc(plan.id)
        .set(
          plan.toMap(),
        );
  }

  Future<void> AddPlanTransaction(
      String userId, String planId, TransactionModel transaction) async {
    print(transaction.amount.round().runtimeType);
    await _firestore
        .collection('plans')
        .doc(userId)
        .collection('userPlans')
        .doc(planId)
        .update({
      'spent': FieldValue.increment(transaction.amount.round()),
    });
    await _plans
        .doc(userId)
        .collection('userPlans')
        .doc(planId)
        .collection('transactions')
        .add(transaction.toMap());
    await _firestore
        .collection('transactions')
        .doc(userId)
        .collection('userTransactions')
        .add(transaction.toMap());
  }

  Future<void> AddPlanBudget(
      String userId, String planId, TransactionModel transaction) async {
    print(transaction.amount.round().runtimeType);
    await _firestore
        .collection('plans')
        .doc(userId)
        .collection('userPlans')
        .doc(planId)
        .set({
      'amount': FieldValue.increment(transaction.amount.round()),
    }, SetOptions(merge: true));
    await _plans
        .doc(userId)
        .collection('userPlans')
        .doc(planId)
        .collection('transactions')
        .add(transaction.toMap());

    await _firestore.collection('wallets').doc(userId).update({
      'balance': FieldValue.increment(-transaction.amount),
    });
    await _transactions
        .doc(userId)
        .collection('userTransactions')
        .add(transaction.toMap());
  }

  Future<void> deletePlan(String userId, String planId) async {
    await _firestore
        .collection('plans')
        .doc(userId)
        .collection('userPlans')
        .doc(planId)
        .delete();
  }
}
