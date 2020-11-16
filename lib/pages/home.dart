import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/controller/home_controller.dart';
import 'package:money_manager/model/resources/transaction.dart';
import 'package:money_manager/utils.dart';
import 'package:money_manager/widgets/footer_widget.dart';

class MoneyHomePage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Manager'),
        backgroundColor: Blackbg,
        leading: const Icon(Icons.menu),
      ),
      backgroundColor: Blackbg,
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              _gradientHomeHeader(context),
              _buildTransactions(homeController.transactions.toList(), context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FooterWidget(),
    );
  }

  Widget _gradientHomeHeader(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: <Color>[StartBlue, MidBlue, EndBlue],
          stops: [0.0, 1.0, 1.5],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: Icon(
                    Icons.attach_money_rounded,
                    color: Colors.orange[200],
                    size: 32,
                  ),
                  title: Text(
                    "Income",
                    style: homePageTitleStyle,
                  ),
                  subtitle: Text("200,670.00", style: homePageSubTitleStyle),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Icon(
                    Icons.money_off_rounded,
                    color: Colors.red[200],
                    size: 32,
                  ),
                  title: Text(
                    "Expense",
                    style: homePageTitleStyle,
                  ),
                  subtitle: Text("70,000.00", style: homePageSubTitleStyle),
                ),
              ),
            ],
          ),
          Divider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.dashboard_rounded,
                color: Colors.green[200],
                size: 32,
              ),
              Text(
                "Balance",
                style: homePageTitleStyle,
              ),
              Text("129,030.00", style: homePageSubTitleStyle),
            ],
          ),
        ],
      ),
    );
  }

  ///build list of transaction
  ///
  ///
  Widget _buildTransactions(
      List<Transaction> transactions, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .50,
      child: transactions.length == 0
          ? Center(
              child: Text(
                'No Data!',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                Transaction transaction = transactions[index];
                return _listTransaction(
                  title: transaction.name,
                  description: transaction.description,
                  amount: transaction.amount.toString(),
                  icon: Icons.extension,
                  type: true,
                );
              },
            ),
    );
  }

  ///build transaction widget
  ///
  ///
  Widget _listTransaction(
      {String title,
      String description,
      String amount,
      IconData icon,
      bool type}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white10),
      title: Text(title, style: itemListTitleStyle),
      subtitle: Text(description, style: itemListSubTitleStyle),
      trailing: Text(amount,
          style: type ? itemListPriceIncomeStyle : itemListPriceExpenseStyle),
    );
  }
}
