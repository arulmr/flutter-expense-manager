import 'package:expense_manager/widgets/chart.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrainsts) {
      return Column(
        children: <Widget>[
          Container(
            height: constrainsts.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                '₹${spendingAmount.toStringAsFixed(2)}',
              ),
            ),
          ),
          SizedBox(
            height: constrainsts.maxHeight * 0.05,
          ),
          Container(
            height: constrainsts.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constrainsts.maxHeight * 0.05,
          ),
          Container(
            height: constrainsts.maxHeight * 0.15,
            child: Text(label),
          ),
        ],
      );
    });
  }
}
