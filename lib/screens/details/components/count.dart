import 'package:flutter/material.dart';
import '../../../size_config.dart';

class Count extends StatefulWidget {
  @override
  State<Count> createState() => _StateCount();
}

class _StateCount extends State<Count>{
  int _n = 0;
  void add() {
    setState(() {
      _n++;
    });
  }
  void minus() {
    setState(() {
      if (_n != 0)
        _n--;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(children: [
        ElevatedButton(
          onPressed: minus,
          child: Icon(Icons.remove, color: Colors.deepOrange),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(10),
            primary: Colors.white,
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        Text(
          '${_n}',
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        ElevatedButton(
            onPressed: add,
            child: Icon(Icons.add, color: Colors.deepOrange),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(10),
              primary: Colors.white,
            ),
        ),
      ]
    );
  }
}
