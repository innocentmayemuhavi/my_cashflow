import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_cashflow/models/plans_model.dart';
import 'package:my_cashflow/models/transaction_model.dart';

class PlansServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    await _firestore
        .collection('plans')
        .doc(userId)
        .collection('userPlans')
        .doc(planId)
        .update({
      'spent': FieldValue.increment(transaction.amount),
      'transactions': FieldValue.arrayUnion([transaction.toMap()])
    });
    await _firestore.collection('wallets').doc(userId).update({
      'transactions': FieldValue.arrayUnion([transaction.toMap()])
    });
  }

  Future<void> AddPlanBudget(
      String userId, String planId, TransactionModel transaction) async {
    await _firestore
        .collection('plans')
        .doc(userId)
        .collection('userPlans')
        .doc(planId)
        .update({
      'amount': FieldValue.increment(transaction.amount),
      'transactions': FieldValue.arrayUnion([transaction.toMap()])
    });

    await _firestore.collection('wallets').doc(userId).update({
      'balance': FieldValue.increment(transaction.amount),
      'transactions': FieldValue.arrayUnion([transaction.toMap()])
    });
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
