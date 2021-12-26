import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      for (var txn in recentTransactions) {
        if (txn.date.day == weekDay.day &&
            txn.date.month == weekDay.month &&
            txn.date.year == weekDay.year) {
          totalSum += txn.amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay).substring(0, 1), 'amount': totalSum};
    }).reversed.toList();
  }

  double get weekTotalSpendings {
    return groupedTransactionValues.fold(
        0.0, (sum, transactionValue) => sum + transactionValue['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  data['day'],
                  data['amount'],
                  weekTotalSpendings == 0.0 ? 0.0 : (data['amount'] as double) / weekTotalSpendings,
                ),
              );
            }).toList(),
          ),
        ));
  }
}