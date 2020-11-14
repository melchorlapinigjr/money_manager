import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:money_manager/utils.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  var amountController = MaskedTextController(mask: '000.000.00');
  String dropdownValue = "Income";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Add new transaction',
                      style: TextStyle(color: SemiBlackbg),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: itemListTitleStyle,
                  decoration: InputDecoration(
                      icon: Icon(Icons.title), labelText: 'Transaction Name:'),
                ),
                TextFormField(
                  style: itemListTitleStyle,
                  decoration: InputDecoration(
                      icon: Icon(Icons.description_sharp),
                      hintText: 'Transaction description.',
                      labelText: 'Description:'),
                ),
                DateTimePicker(
                  icon: Icon(Icons.calendar_today_sharp),
                  dateMask: 'd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date:',
                  onChanged: (val) => print(val),
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
                TextFormField(
                  style: itemListTitleStyle,
                  decoration: InputDecoration(
                      icon: Icon(Icons.attach_money_sharp),
                      hintText: 'Transaction amount.',
                      labelText: 'Amount:'),
                  controller: amountController,
                ),
                Row(
                  children: [
                    Text(
                      "Type: ",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 20,
                      style: TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['Income', 'Expense', 'Investment']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                RaisedButton.icon(
                  icon: Icon(Icons.save_alt_rounded, size: 18),
                  textColor: Colors.white,
                  color: Color(0xFF6200EE),
                  onPressed: () {
                    // Respond to button press
                  },
                  label: Text("Save Transaction"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
