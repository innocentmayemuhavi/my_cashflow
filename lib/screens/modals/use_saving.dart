import 'package:flutter/material.dart';
import 'package:my_cashflow/shared/constans.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/utils/utils.dart';
import 'package:numpad_layout/widgets/numpad.dart';

class UseSaving extends StatefulWidget {
  const UseSaving({super.key});

  @override
  State<UseSaving> createState() => _UseSavingState();
}

class _UseSavingState extends State<UseSaving> {
  String number = '0';
  String? selectedCategory;
  Color? selectedColor;
  final int _limit = 5000;
  final TextEditingController _controller =
      TextEditingController(text: 'Ksh. 0.00');

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 01,
        width: MediaQuery.of(context).size.width,
        child: PageView(
          physics: int.parse(number.isNotEmpty ? number : '0') <= _limit &&
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
                          'Use saving',
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
                                          _limit
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
                        'Saving balance: KSH. 5000.00',
                        style: normalTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton(
                        onPressed: number.isNotEmpty && number != '0'
                            ? () {
                                if (int.parse(
                                            number.isNotEmpty ? number : '0') <=
                                        _limit &&
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
                            backgroundColor:
                                int.parse(number.isNotEmpty ? number : '0') <=
                                        _limit
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
                  onPressed: selectedCategory != null
                      ? () {
                          if (selectedCategory != null) {
                            Navigator.pop(context);
                          }
                        }
                      : null,
                  child: Text(
                    'Finish',
                    style: normalTextStyle.copyWith(color: selectedColor),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
