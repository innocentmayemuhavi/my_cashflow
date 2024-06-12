import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/models/expence_class.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/services/firestore/wallet/wallet.dart';
import 'package:my_cashflow/shared/constans.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/utils/utils.dart';
import 'package:numpad_layout/widgets/numpad.dart';
import 'package:provider/provider.dart';

class Addexpence extends StatefulWidget {
  const Addexpence({super.key, required this.balance});
  final double balance;

  @override
  State<Addexpence> createState() => _AddexpenceState();
}

class _AddexpenceState extends State<Addexpence> {
  String number = '0';
  bool _isLoading = false;
  String? selectedCategory;
  Color? selectedColor;
  final TextEditingController _controller =
      TextEditingController(text: 'Ksh. 0.00');

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    User_Class user = Provider.of<User_Class>(context);
    return SizedBox(
        height: MediaQuery.of(context).size.height * 01,
        width: MediaQuery.of(context).size.width,
        child: PageView(
          physics: double.parse(number.isNotEmpty ? number : '0') <=
                      widget.balance &&
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
                          'Add Expense',
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
                              color: double.parse(
                                          number.isNotEmpty ? number : '0.0') <=
                                      widget.balance
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
                        'Wallet Balance: KSH. ${widget.balance.toStringAsFixed(2)}',
                        style: normalTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton(
                        onPressed: number.isNotEmpty && number != '0'
                            ? () {
                                if (double.parse(
                                            number.isNotEmpty ? number : '0') <=
                                        widget.balance &&
                                    number != '0' &&
                                    number.isNotEmpty) {
                                  _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: double.parse(
                                        number.isNotEmpty ? number : '0.0') <=
                                    widget.balance
                                ? Colors.green
                                : Colors.red,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.75, 35),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          'Continue',
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
            Column(
              children: [
                IconButton(
                    onPressed: () {
                      _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
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
                Text(
                  'Select Category',
                  style: normalTextStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: expeCategory.map((category) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedCategory = category.name;
                            selectedColor = category.color;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              height:
                                  selectedCategory == category.name ? 70 : 50,
                              width:
                                  selectedCategory == category.name ? 70 : 50,
                              decoration: BoxDecoration(
                                  color: category.color,
                                  borderRadius: BorderRadius.circular(10)),
                              child: category.icon,
                            ),
                            Text(
                              category.name,
                              style: normalTextStyle.copyWith(
                                  fontSize: selectedCategory == category.name
                                      ? 18
                                      : 12,
                                  fontWeight: selectedCategory == category.name
                                      ? FontWeight.bold
                                      : FontWeight.w600),
                            )
                          ],
                        ),
                      );
                    }).toList()),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.75, 35),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 2),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: selectedColor ?? Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: selectedCategory != null && !_isLoading
                      ? () async {
                          if (selectedCategory != null) {
                            setState(() {
                              _isLoading = true;
                            });

                            await WalletService()
                                .deductAmount(
                                    user.uid,
                                    ExpenceClass(
                                        amount: double.parse(number),
                                        timestamp: Timestamp.now(),
                                        category: selectedCategory!))
                                .then((_) => {
                                      setState(() => _isLoading = false),
                                      Navigator.pop(context)
                                    })
                                .catchError((e) => {
                                      setState(() => _isLoading = false),
                                      print(e)
                                    });
                          }
                        }
                      : null,
                  child: Text(
                    _isLoading ? 'Please Wait...' : 'Finish',
                    style: normalTextStyle.copyWith(color: selectedColor),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
