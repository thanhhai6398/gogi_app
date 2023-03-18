import 'package:flutter/material.dart';

class Customer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: const [
                Text ("Name:"),
                Spacer(),
                Text ("Thanh Hai"),
              ]
            ),
            const SizedBox(height: 5.0,),
            Row(
                children: const [
                  Text ("Phone:"),
                  Spacer(),
                  Text ("0914276398"),
                ]
            ),
            const SizedBox(height: 5.0,),
            Row(
                children: const [
                  Text ("Address:"),
                  Spacer(),
                  Text ("1332 Kha Van Can, Linh Trung"),
                ]
            ),
          ],
        )
    );
  }

}