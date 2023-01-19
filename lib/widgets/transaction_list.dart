import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: transactions.isEmpty
            ? Container(
                child: Column(
                  children: [
                    Text('No transactions added yet!',
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 20),
                    Container(
                      height: 330,
                      child: Image.asset(
                        'assets/images/noexpense.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 40,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text(
                            '\$${transactions[index].amount}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontFamily: 'OpenSans.bold',
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[index].id),
                          icon: Icon(Icons.delete)),
                    ),
                  );
                }
                // Card(
                //     child: Row(
                //   children: <Widget>[
                //     Container(
                //       margin: EdgeInsets.symmetric(
                //         vertical: 10,
                //         horizontal: 15,
                //       ),
                //       decoration: BoxDecoration(
                //           border: Border.all(
                //               color: Theme.of(context).primaryColor,
                //               width: 2)),
                //       padding: EdgeInsets.all(10),
                //       child: Text(
                //           '\$${transactions[index].amount.toStringAsFixed(2)}',
                //           style: TextStyle(
                //               color: Theme.of(context).primaryColor,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 18)),
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: <Widget>[
                //         Container(
                //           margin: EdgeInsets.all(5),
                //         ),
                //         Text(
                //           transactions[index].title,
                //           style: TextStyle(
                //               color: Theme.of(context).primaryColor,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 16),
                //         ),
                //         Text(
                //           DateFormat.yMMMd().format(transactions[index].date),
                //           style: TextStyle(
                //               color: Theme.of(context).primaryColor,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 14),
                //         )
                //       ],
                //     ),
                //   ],
                // )
                // );
                ,
                itemCount: transactions.length,
              ));
  }
}
