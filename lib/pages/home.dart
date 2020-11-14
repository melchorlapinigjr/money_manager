import 'package:flutter/material.dart';
import 'package:money_manager/utils.dart';
import 'package:money_manager/widgets/footer_widget.dart';

class MoneyHomePage extends StatefulWidget {
  @override
  _MoneyHomePageState createState() => _MoneyHomePageState();
}

class _MoneyHomePageState extends State<MoneyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Money Manager'),
        backgroundColor: Blackbg,
        leading: Icon(Icons.menu),
      ),
      backgroundColor: Blackbg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 170,
                margin: EdgeInsets.all(5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _gradientHomeHeader(context),
                      _listContainer(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterWidget(),
    );
  }

  _gradientHomeHeader(BuildContext context) {
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

  _listContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: SemiBlackbg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today : Nov. 12, 2020", style: homePageTitleStyle),
          SizedBox(height: 10),
          _listTransaction(
            context,
            title: "Buy laptop",
            description: "Asus x100-21, 12gb Ram, 8gb Graphics, i7",
            icon: Icons.laptop,
            amount: "50,000",
            type: false,
          ),
          Divider(color: Colors.white30),
          _listTransaction(
            context,
            title: "Buy New Cellpon",
            description: "Huwaie Cellpon lang",
            icon: Icons.signal_cellular_alt_sharp,
            amount: "2,000",
            type: false,
          ),
          Divider(color: Colors.white30),
          _listTransaction(
            context,
            title: "Shoot sir Diaz",
            description: "Basic package photo and video",
            icon: Icons.money,
            amount: "10,000",
            type: true,
          ),
          Divider(color: Colors.white30),
          SizedBox(height: 10),
          Text("Yesterday : Nov. 20, 2020", style: homePageTitleStyle),
          Divider(color: Colors.white30),
          _listTransaction(
            context,
            title: "Buy Car",
            description: "Nisan Calibre 4x2",
            icon: Icons.bus_alert,
            amount: "100,000",
            type: false,
          ),
          Divider(color: Colors.white30),
          _listTransaction(
            context,
            title: "Shoot sir Rommel",
            description: "All in package",
            icon: Icons.money,
            amount: "45,000",
            type: false,
          ),
          Divider(color: Colors.white30),
          _listTransaction(
            context,
            title: "Buy Liquor",
            description: "Bahalina 1 container",
            icon: Icons.liquor,
            amount: "600",
            type: false,
          ),
          Divider(color: Colors.white30),
        ],
      ),
    );
  }

  _listTransaction(BuildContext context,
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
