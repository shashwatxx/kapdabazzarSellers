import 'package:flutter/material.dart';

import '../const.dart';

class StatDisplayROw extends StatelessWidget {
  const StatDisplayROw(
      {@required this.mysize,
      this.heading = "",
      this.icon,
      this.stat1 = "",
      this.stat1Detail = "",
      this.stat2 = "",
      this.stat2Detail = "",
      this.sizedBoxwidth = 0});

  final Size mysize;
  final String heading;
  final IconData icon;
  final String stat1;
  final String stat1Detail;
  final String stat2;
  final String stat2Detail;
  final double sizedBoxwidth;
  @override
  Widget build(BuildContext context) {
    final TextStyle mystyle = TextStyle(fontSize: mysize.width * 0.05);

    return Container(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    heading,
                    style: mystyle,
                  ),
                  Icon(
                    icon,
                    size: mysize.width * 0.09,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: <Widget>[
                Text(
                  stat1,
                  style:
                      TextStyle(fontSize: mysize.width * 0.09, color: mycolor),
                ),
                Text(stat1Detail),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              children: <Widget>[
                Text(
                  stat2,
                  style:
                      TextStyle(fontSize: mysize.width * 0.09, color: mycolor),
                ),
                Text(stat2Detail),
              ],
            ),
          )
        ],
      ),
    );
  }
}
