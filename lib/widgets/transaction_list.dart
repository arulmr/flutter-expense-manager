import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTxn;

  TransactionList(this.transactions, this.deleteTxn);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No transactions found!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              // Aprroach 1
              return Card(
                elevation: 6,
                margin: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 3,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FittedBox(
                        child: Text(
                          '₹${transactions[index].amount.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat('dd/MM/yyyy').format(transactions[index].date),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          onPressed: () => deleteTxn(transactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete Expense'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          onPressed: () => deleteTxn(transactions[index].id),
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
              // Approach 2
              // return Card(
              //   elevation: 3,
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         child: Text(
              //           // txn.amount.toString(),
              //           // '\$${txn.amount}',
              //           '₹${transactions[index].amount.toStringAsFixed(2)}',
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20,
              //             color: Theme.of(context).primaryColor,
              //           ),
              //         ),
              //         margin: const EdgeInsets.symmetric(
              //           vertical: 10,
              //           horizontal: 15,
              //         ),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Theme.of(context).primaryColor,
              //             width: 2,
              //           ),
              //         ),
              //         padding: EdgeInsets.all(10),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             transactions[index].title,
              //             style: Theme.of(context).textTheme.headline6,
              //           ),
              //           Text(
              //             DateFormat('dd/MM/yyyy')
              //                 .format(transactions[index].date),
              //             style: const TextStyle(
              //               fontSize: 15,
              //               color: Colors.black54,
              //             ),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // );
            },
          );
  }
}
