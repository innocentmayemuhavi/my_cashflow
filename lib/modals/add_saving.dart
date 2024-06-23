import 'package:flutter/material.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/services/firestore/savings/savings.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/utils/utils.dart';
import 'package:numpad_layout/widgets/numpad.dart';
import 'package:provider/provider.dart';

class AddSaving extends StatefulWidget {
  const AddSaving({super.key, required this.balance});
  final double balance;

  @override
  State<AddSaving> createState() => _AddSavingState();
}

class _AddSavingState extends State<AddSaving> {
  String number = '0';
  String? selectedCategory;
  Color? selectedColor;
  bool _isLoading = false;

  final TextEditingController _controller =
      TextEditingController(text: 'Ksh. 0.00');

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    User_Class user = Provider.of<User_Class>(context);
    return SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
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
                          'Add Saving',
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
                            color: Colors.green,
                          ),
                          // int.parse(number.isNotEmpty ? number : '0') <=
                          //         _limit
                          //     ? Colors.green
                          //     : Colors.red),
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
                        'Savings Balance: KSH. ${widget.balance}',
                        style: normalTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : number.isNotEmpty && number != '0'
                                ? () async {
                                    if (number != '0' && number.isNotEmpty) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      Savings()
                                          .AddSaving(
                                              user.uid, double.parse(number))
                                          .then((value) => {
                                                setState(() {
                                                  _isLoading = false;
                                                }),
                                                Navigator.pop(context)
                                              })
                                          .catchError((error) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      });
                                    }
                                  }
                                : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.75, 35),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          _isLoading ? 'Depositing...' : 'Deposit',
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
