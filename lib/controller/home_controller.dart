import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:money_manager/repository/db_repository.dart';

import '../model/resources/transaction.dart';
import '../repository/transaction_repository.dart';

class HomeController extends GetxController {

  HomeController(){
    _init();
  }

  final TransactionRepository repository = TransactionRepository();

  ///Observable list of [Transaction]
  ///
  ///
  RxList<Transaction> transactions = <Transaction>[].obs;

  ///Initialize Database and retrieve list of [Transaction]
  ///
  ///
  Future<void> _init() async{
    await DBRepository.instance.init();
    getTransactions();
  }

  ///Get List of [Transaction] from database
  ///and notify listeners of [transactions]
  ///
  Future<void> getTransactions()async{
    List<Transaction> transactions =await repository.getAll();
    this.transactions.addAll(transactions);
  }

}
