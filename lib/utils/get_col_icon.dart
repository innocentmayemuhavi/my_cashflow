import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/models/expe_category.dart';
import 'package:my_cashflow/shared/constans.dart';

ExpeCategory getCategoryDetails(String categoryName) {
  for (ExpeCategory category in expeCategory) {
    if (category.name == categoryName) {
      return category;
    }
  }

  // Return a default category if the category name doesn't match any category
  return ExpeCategory(
    id: '0',
    name: 'Unknown',
    color: Colors.green,
    icon: const Icon(
      CupertinoIcons.arrow_up_right_circle,
    ),
  );
}
