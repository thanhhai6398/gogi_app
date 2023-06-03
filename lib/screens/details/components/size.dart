import 'package:flutter/material.dart';

import '../../../enums.dart';

class Size extends StatefulWidget {
  final Function(SIZE) notifyParent;
  final SIZE size;

  Size({super.key, required this.notifyParent, required this.size});

  @override
  State<Size> createState() => _SizeState();
}

class _SizeState extends State<Size> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio(
                value: SIZE.s,
                groupValue: widget.size,
                onChanged: (SIZE? value) {
                  widget.notifyParent(value!);
                }),
            const Expanded(
              child: Text('Nhỏ 0đ'),
            )
          ],
        ),
        Row(
          children: [
            Radio(
              value: SIZE.m,
              groupValue: widget.size,
              onChanged: (SIZE? value) {
                widget.notifyParent(value!);
              },
            ),
            const Expanded(child: Text('Vừa 6.000đ'))
          ],
        ),
        Row(
          children: [
            Radio(
              value: SIZE.l,
              groupValue: widget.size,
              onChanged: (SIZE? value) {
                widget.notifyParent(value!);
              },
            ),
            const Expanded(child: Text('Lớn 10.000đ'))
          ],
        ),
      ],
    );
  }
}
