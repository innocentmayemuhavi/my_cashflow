import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/models/transaction_model.dart';
import 'package:my_cashflow/services/firestore/plans/plans.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/utils/utils.dart';
import 'package:numpad_layout/widgets/numpad.dart';

class PlanDeposit extends StatefulWidget {
  const PlanDeposit(
      {super.key,
      required this.uid,
      required this.planId,
      required this.budget});

  final String uid;
  final String planId;
  final double budget;

  @override
  State<PlanDeposit> createState() => _PlanDepositState();
}

class _PlanDepositState extends State<PlanDeposit> {
  String number = '0';
  String? selectedCategory;
  Color? selectedColor;
  bool _isLoading = false;

  final TextEditingController _controller =
      TextEditingController(text: 'Ksh. 0.00');

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 01,
        width: MediaQuery.of(context).size.width,
        child: PageView(
          physics:
              int.parse(number.isNotEmpty ? number : '0') <= widget.budget &&
                      number != '0' &&
                      number.isNotEmpty
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          size: 12,
                        ),
                        Text(
                          'Back',
                          style: normalTextStyle.copyWith(fontSize: 12),
                        )
                      ],
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * .2),
                Expanded(
                  child: Form(
                      child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Add Deposit',
                          style: normalTextStyle.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        'Amount',
                        style: normalTextStyle.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      IgnorePointer(
                        ignoring: true,
                        child: TextFormField(
                          mouseCursor: MouseCursor.uncontrolled,
                          controller: _controller,
                          style: normalTextStyle.copyWith(
                              fontSize: 35,
                              color:
                                  int.parse(number.isNotEmpty ? number : '0') <=
                                          widget.budget
                                      ? Colors.green
                                      : Colors.red),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.green,
                          decoration: const InputDecoration(
                            prefixStyle: TextStyle(),
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Wallet Balance: KSH. ${widget.budget.toStringAsFixed(2)}',
                        style: normalTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton(
                        onPressed: number.isNotEmpty &&
                                number != '0' &&
                                !_isLoading
                            ? () {
                                if (int.parse(
                                            number.isNotEmpty ? number : '0') <=
                                        widget.budget &&
                                    number != '0' &&
                                    number.isNotEmpty) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  PlansServices()
                                      .AddPlanBudget(
                                          widget.uid,
                                          widget.planId,
                                          TransactionModel(
                                              amount: double.parse(number),
                                              category: 'Deposit',
                                              timestamp: Timestamp.now()))
                                      .then((_) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Navigator.pop(context);
                                  }).catchError((e) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    print(e);
                                  });
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                int.parse(number.isNotEmpty ? number : '0') <=
                                        widget.budget
                                    ? Colors.green
                                    : Colors.red,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.75, 35),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          _isLoading ? 'Depositing ...' : 'Deposit',
                          style: normalTextStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      NumPad(
                        arabicDigits: false,
                        highlightColor: Colors.green,
                        numberStyle: const TextStyle(
                            color: Colors.green,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                        onType: (value) {
                          number += value;
                          var formattedNumber = curencyFommater(number);
                          setState(() {
                            _controller.text = 'Ksh. $formattedNumber';
                          });
                        },
                        rightWidget: IconButton(
                          icon: const Icon(Icons.backspace),
                          onPressed: () {
                            if (number.isNotEmpty) {
                              number = number.substring(0, number.length - 1);
                              var formattedNumber = curencyFommater(number);
                              setState(() {
                                _controller.text = 'Ksh. $formattedNumber';
                              });
                            }
                          },
                        ),
                      )
                    ],
                  )),
                )
              ],
            ),
          ],
        ));
  }
}
