import 'package:flutter/material.dart';
import '../../../size_config.dart';

class Size extends StatefulWidget {
  final Function(String) notifyParent;
  Size({super.key, required this.notifyParent});

  @override
  State<Size> createState() => _SizeState();
}

enum SIZE { s, m, l }

class _SizeState extends State<Size> {
  SIZE? _size = SIZE.s;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Radio(
                  value: SIZE.s,
                  groupValue: _size,
                  onChanged: (SIZE? value) {
                    setState(() {
                      _size = value;
                    });
                    widget.notifyParent(SIZE.s.name);
                  }
                ),
                const Expanded(
                  child: Text('Nhỏ 0đ'),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Radio(
                  value: SIZE.m,
                  groupValue: _size,
                  onChanged: (SIZE? value) {
                    setState(() {
                      _size = value;
                    });
                    widget.notifyParent(SIZE.m.name);
                  },
                ),
                const Expanded(child: Text('Vừa 6.000đ'))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Radio(
                  value: SIZE.l,
                  groupValue: _size,
                  onChanged: (SIZE? value) {
                    setState(() {
                      _size = value;
                    });
                    widget.notifyParent(SIZE.l.name);
                  },
                ),
                const Expanded(child: Text('Lớn 10.000đ'))
              ],
            ),
          ),
        ],
    );
  }
}
