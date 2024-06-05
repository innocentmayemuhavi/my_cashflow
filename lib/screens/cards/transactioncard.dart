import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_cashflow/models/transaction_model.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/utils/get_col_icon.dart';
import 'package:my_cashflow/utils/utils.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border.all(
            color: getCategoryDetails(widget.transaction.category).color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: getCategoryDetails(widget.transaction.category)
                          .color),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.transaction.category == 'Income'
                      ? CupertinoIcons.arrow_down_left_circle
                      : widget.transaction.category == 'Food'
                          ? Icons.food_bank
                          : widget.transaction.category == 'Shopping'
                              ? CupertinoIcons.shopping_cart
                              : widget.transaction.category == 'Transport'
                                  ? CupertinoIcons.car_detailed
                                  : widget.transaction.category ==
                                          'Entertainment'
                                      ? CupertinoIcons.music_mic
                                      : Icons.more_horiz,
                  color: getCategoryDetails(widget.transaction.category).color,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.transaction.category,
                    style: normalTextStyle.copyWith(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Ksh ${doublecurrencyFormatter(widget.transaction.amount)}',
                    style: boldTextStyle.copyWith(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('MMM dd, yyyy')
                    .format(widget.transaction.timestamp.toDate()),
                style:
                    normalTextStyle.copyWith(fontSize: 15, color: Colors.grey),
              ),
              Text(
                DateFormat('hh:mm a')
                    .format(widget.transaction.timestamp.toDate()),
                style:
                    normalTextStyle.copyWith(fontSize: 15, color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}
