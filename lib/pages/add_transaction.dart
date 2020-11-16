import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/controller/home_controller.dart';
import 'package:money_manager/utils.dart';

import '../controller/add_transaction_controller.dart';

class AddTransaction extends StatelessWidget {
  final AddTransactionController controller =
      Get.put(AddTransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              ..._buildTransactionName(),
              ..._buildDescription(),
              ..._buildDate(),
              ..._buildAmount(),
              ..._buildType(),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTransactionName() => <Widget>[
        const SizedBox(height: 10),
        TextFormField(
          controller: controller.nameController,
          style: itemListTitleStyleBlack,
          decoration: const InputDecoration(
              icon: Icon(Icons.title), labelText: 'Transaction Name:'),
        ),
      ];

  List<Widget> _buildDescription() => <Widget>[
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.descriptionController,
          style: itemListTitleStyleBlack,
          decoration: const InputDecoration(
              icon: Icon(Icons.description_sharp),
              hintText: 'Transaction description.',
              labelText: 'Description:'),
        ),
      ];

  List<Widget> _buildDate() => <Widget>[
        const SizedBox(height: 8),
        DateTimePicker(
          icon: Icon(Icons.calendar_today_sharp),
          dateMask: 'd MMM, yyyy',
          initialValue: DateTime.now().toString(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
          dateLabelText: 'Date:',
          onChanged: (val) => controller.date = DateTime.parse(val),
        ),
      ];

  List<Widget> _buildAmount() => <Widget>[
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.amountController,
          style: itemListTitleStyleBlack,
          decoration: const InputDecoration(
              icon: Icon(Icons.attach_money_sharp),
              hintText: 'Transaction amount.',
              labelText: 'Amount:'),
        ),
      ];

  List<Widget> _buildType() => <Widget>[
        const SizedBox(height: 14),
        Row(
          children: [
            Text(
              "Type: ",
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Obx(() => DropdownButton<String>(
                  value: controller.selectedType.value,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 20,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    controller.selectedType.value = newValue;
                  },
                  items: controller.transactionType
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
          ],
        ),
        const SizedBox(height: 50),
      ];

  Widget _buildButton() => RaisedButton.icon(
        icon: const Icon(Icons.save_alt_rounded, size: 18),
        textColor: Colors.white,
        color: Colors.blueAccent,
        onPressed: () => controller.save(),
        label: const Text("Save Transaction"),
      );
}
