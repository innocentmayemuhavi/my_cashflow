import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/models/plans_model.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/services/firestore/plans/plans.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:my_cashflow/shared/constans.dart';
import 'package:my_cashflow/utils/utils.dart';
import 'package:nanoid/nanoid.dart';
import 'package:provider/provider.dart';

class CreatePlan extends StatefulWidget {
  const CreatePlan({super.key});

  @override
  State<CreatePlan> createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {
  bool _isLoading = false;
  String _category = 'Food';

  String _color = 'Blue';
  String? _planName;
  String? _amount;
  String? _description;
  DateTime? _startDate;
  DateTime? _endDate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    User_Class user = Provider.of<User_Class>(context);

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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DatePicker(
                          monthTextStyle:
                              normalTextStyle.copyWith(fontSize: 10),
                          dayTextStyle: normalTextStyle.copyWith(fontSize: 10),
                          dateTextStyle: normalTextStyle.copyWith(fontSize: 20),
                          DateTime.now(),
                          initialSelectedDate: DateTime.now(),
                          selectionColor:
                              Theme.of(context).colorScheme.secondary,
                          selectedTextColor: Colors.white,
                          onDateChange: (date) {
                            // New date selected
                            setState(() {
                              _startDate = date;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('End date', style: normalTextStyle),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DatePicker(
                          monthTextStyle:
                              normalTextStyle.copyWith(fontSize: 10),
                          dayTextStyle: normalTextStyle.copyWith(fontSize: 10),
                          dateTextStyle: normalTextStyle.copyWith(fontSize: 20),
                          DateTime.now(),
                          initialSelectedDate:
                              DateTime.now().add(const Duration(days: 3)),
                          selectionColor:
                              Theme.of(context).colorScheme.secondary,
                          selectedTextColor: Colors.white,
                          onDateChange: (date) {
                            // New date selected
                            setState(() {
                              _endDate = date;
                            });
                          },
                        ),
                      ],
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
              onPressed: _isLoading
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });

                        PlansServices()
                            .addPlan(
                                user.uid,
                                PlansModel(
                                  id: nanoid(20),
                                  amount: int.parse(_amount!),
                                  spent: 0,
                                  category: _category,
                                  color: _color,
                                  description: _description!,
                                  endDate: _endDate ??
                                      DateTime.now()
                                          .add(const Duration(days: 3)),
                                  planName: _planName!,
                                  startDate: _startDate ?? DateTime.now(),
                                ))
                            .then((_) => {
                                  setState(() {
                                    _isLoading = false;
                                  }),
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor:
                                            getColor(_color.toLowerCase()),
                                        content: const Text(
                                            'Plan added successfully!')),
                                  ),
                                })
                            .then((_) => Navigator.pop(context))
                            .catchError((e) {
                          print(e.toString());
                        });

                        // Navigator.pop(context);
                      }
                    },
              child: Text(
                _isLoading ? 'Saving...' : 'Save plan',
                style: normalTextStyle.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
