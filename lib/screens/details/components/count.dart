import 'package:flutter/material.dart';
import '../../../size_config.dart';

class Count extends StatefulWidget {
  final Function(int) notifyParent;
  final int quantity;
  Count({super.key, required this.notifyParent, required this.quantity});

  @override
  State<Count> createState() => _StateCount();
}

class _StateCount extends State<Count>{
  void add() {
    widget.notifyParent(widget.quantity+1);
  }
  void minus() {
    setState(() {
      if (widget.quantity != 0)
        widget.notifyParent(widget.quantity - 1);
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
          '${widget.quantity}',
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
