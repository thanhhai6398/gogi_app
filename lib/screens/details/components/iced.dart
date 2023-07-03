import 'package:flutter/material.dart';

import '../../../enums.dart';

class Iced extends StatefulWidget {
  final Function(String) notifyParent;
  final String iced;

  Iced({super.key, required this.notifyParent, required this.iced});

  @override
  State<Iced> createState() => _IcedState();
}

class _IcedState extends State<Iced> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Radio(
                      value: '0',
                      groupValue: widget.iced,
                      onChanged: (value) {
                        widget.notifyParent(value!);
                      }),
                  const Expanded(
                    child: Text('Không đá'),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Radio(
                    value: '100%',
                    groupValue: widget.iced,
                    onChanged: (value) {
                      widget.notifyParent(value!);
                    },
                  ),
                  const Expanded(child: Text('100% đá'))
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              value: '50%',
              groupValue: widget.iced,
              onChanged: (value) {
                widget.notifyParent(value!);
              },
            ),
            const Expanded(child: Text('50% đá'))
          ],
        ),
      ],
    );
  }
}
