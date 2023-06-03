import 'package:flutter/material.dart';

class Sugar extends StatefulWidget {
  final Function(String) notifyParent;
  final String sugar;

  Sugar({super.key, required this.notifyParent, required this.sugar});

  @override
  State<Sugar> createState() => _SugarState();
}

class _SugarState extends State<Sugar> {
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
                      groupValue: widget.sugar,
                      onChanged: (value) {
                        widget.notifyParent(value!);
                      }),
                  const Expanded(
                    child: Text('Không đường'),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Radio(
                    value: '70%',
                    groupValue: widget.sugar,
                    onChanged: (value) {
                      widget.notifyParent(value!);
                    },
                  ),
                  const Expanded(child: Text('70% đường'))
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Radio(
                    value: '30%',
                    groupValue: widget.sugar,
                    onChanged: (value) {
                      widget.notifyParent(value!);
                    },
                  ),
                  const Expanded(child: Text('30% đường'))
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Radio(
                    value: '100%',
                    groupValue: widget.sugar,
                    onChanged: (value) {
                      widget.notifyParent(value!);
                    },
                  ),
                  const Expanded(child: Text('100% đường'))
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              value: '50%',
              groupValue: widget.sugar,
              onChanged: (value) {
                widget.notifyParent(value!);
              },
            ),
            const Expanded(child: Text('50% đường'))
          ],
        ),
      ],
    );
  }
}
