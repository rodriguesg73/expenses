// ignore_for_file: prefer_const_constructors

import 'package:expenses/components/transaction_char_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TransactionChart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const TransactionChart(this.recentTransactions, {super.key});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMOnth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMOnth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    });
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: Row(
        children: groupedTransactions.map((tr) {
          return TransactionChartBar(
            label: tr['day'].toString(),
            value: (tr['value'] as double),
            percentage: (tr['value'] as double) / _weekTotalValue,
          );
        }).toList(),
      ),
    );
  }
}
