import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  DateTime _selectedDate;
  final amountController = TextEditingController();

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                // onChanged: (value) => titleInput = value,
                controller: titleController,
                onSubmitted: (value) => submitData()),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (value) => submitData(),
              // onChanged: (value) {
              //   amountInput = value;
              // },
              controller: amountController,
            ),
            Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No chosen date!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _presentDatePicker,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                )),
            // ignore: deprecated_member_use
            RaisedButton(
                onPressed: () => submitData(),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
