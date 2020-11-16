import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:money_manager/controller/home_controller.dart';
import 'package:money_manager/pages/home.dart';

import '../model/resources/transaction.dart';
import '../repository/transaction_repository.dart';

class AddTransactionController extends GetxController {
  final List<String> transactionType = <String>[
    'income',
    'expense',
    'investment'
  ];
  final MaskedTextController amountMaskController =
      MaskedTextController(mask: '000,000.00');

  final TransactionRepository repository = TransactionRepository();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime date = DateTime.now();

  /// Observable data
  ///
  ///
  RxString selectedType = 'income'.obs;

  /// get the instance of [HomeController]
  /// so that we can notify the [MoneyHomePage]
  /// if there is new data inserted/updated
  final HomeController c = Get.find();

  ///save [Transaction] to database
  ///
  ///
  void save() async {
    if (!_isValid()) {
      Get.snackbar(
        'Error',
        'All fields are required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Transaction transaction = Transaction(
      id: generateUniqueID(),
      name: nameController.text,
      description: nameController.text,
      amount: _getDoubleValue(amountController.text),
      date: date,
      type: selectedType.value,
    );

    try {
      await repository.upsert(transaction);
      //notify home controller so that data will be refresh
      c.getTransactions();
      //pop this widget
      Get.back();
    } catch (ex) {
      Get.snackbar(
        'Error',
        'Unexpected Error!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Validate data
  ///
  ///
  bool _isValid() {
    return nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        _getDoubleValue(amountController.text) > 0;
  }

  /// Convert value from [amountController] to double
  ///
  ///
  double _getDoubleValue(String val) {
    return double.tryParse(val.replaceAll(',', ''));
  }

  /// Dispose object
  ///
  ///
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
