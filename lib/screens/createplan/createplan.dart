import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:intl/intl.dart';
import 'package:my_cashflow/shared/constans.dart';
import 'package:my_cashflow/utils/utils.dart';
import 'package:my_cashflow/shared/styles.dart';

class CreatePlan extends StatefulWidget {
  const CreatePlan({super.key});

  @override
  State<CreatePlan> createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  String _category = 'Food';
  String _color = 'Blue';
  String? _planName;
  String? _amount;
  String? _description;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          leadingWidth: 100,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 17,
                ),
                Text('Back')
              ],
            ),
          ),
          title: Text(
            'Add new plan',
            style: appbarTitleStyle,
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Plan name', style: normalTextStyle),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter plan name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _planName = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter plan name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Amount', style: normalTextStyle),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter amount';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _amount = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Category', style: normalTextStyle),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        underline: Container(),
                        padding: const EdgeInsets.all(3),
                        value: _category,
                        hint: const Text('Select category'),
                        elevation: 0,
                        isDense: true,
                        isExpanded: true,
                        icon: const Icon(
                          CupertinoIcons.chevron_down,
                          color: Colors.grey,
                          size: 15,
                        ),
                        items: categories
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _category = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Theme Color', style: normalTextStyle),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: getColor(_color.toLowerCase()), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        hint: const Text('Select Color'),
                        elevation: 0,
                        dropdownColor: getColor(_color.toLowerCase()),
                        isDense: true,
                        isExpanded: true,
                        icon: const Icon(
                          CupertinoIcons.chevron_down,
                          size: 15,
                          color: Colors.grey,
                        ),
                        underline: Container(), // This removes the underline
                        value: _color,
                        items: colors
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _color = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Start date', style: normalTextStyle),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          _startDateController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        }
                      },
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter start date';
                          }
                          return null;
                        },
                        ignorePointers: true,
                        controller: _startDateController,
                        decoration: InputDecoration(
                          hintText: 'Enter start date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('End date', style: normalTextStyle),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        _endDateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate!);
                      },
                      child: IgnorePointer(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter end date';
                            }
                            return null;
                          },
                          controller: _endDateController,
                          decoration: InputDecoration(
                            hintText: 'Enter end date',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Description', style: normalTextStyle),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                      maxLines: 5,
                      maxLength: 200,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {
                        _description = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              style: elevatedButtonStyle.copyWith(
                backgroundColor:
                    WidgetStateProperty.all(getColor(_color.toLowerCase())),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('cool');
                }
              },
              child: Text(
                'Create plan',
                style: normalTextStyle.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
