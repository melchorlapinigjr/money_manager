import 'package:flutter/material.dart';

class MyHeaderMenu extends StatefulWidget {
  @override
  _MyHeaderMenuState createState() => _MyHeaderMenuState();
}

class _MyHeaderMenuState extends State<MyHeaderMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
      height: 30,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              print('press');
            },
            icon: Icon(Icons.menu, color: Colors.white),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "Money Manager",
            style: TextStyle(color: Colors.white),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    print('press');
                  },
                  icon: Icon(Icons.more_vert, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
