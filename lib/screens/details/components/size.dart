import 'package:flutter/material.dart';
import '../../../size_config.dart';

class Size extends StatefulWidget {
  @override
  State<Size> createState() => _SizeState();
}

enum size { s, m, l }

class _SizeState extends State<Size> {
  size? _size = size.s;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Radio(
                  value: size.s,
                  groupValue: _size,
                  onChanged: (size? value) {
                    setState(() {
                      _size = value;
                    });
                  },
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
                  value: size.m,
                  groupValue: _size,
                  onChanged: (size? value) {
                    setState(() {
                      _size = value;
                    });
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
                  value: size.l,
                  groupValue: _size,
                  onChanged: (size? value) {
                    setState(() {
                      _size = value;
                    });
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
