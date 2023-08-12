import 'package:flutter/material.dart';

import '../utils/colors.dart';

class StockInfoField extends StatelessWidget {
  const StockInfoField(
      {super.key,
      required this.title,
      required this.fullCompanyName,
      required this.stockPrice,
      required this.persentChange,
      required this.logo});
  final String title;
  final String fullCompanyName;
  final double stockPrice;
  final double persentChange;
  final String logo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: secondaryColor.withOpacity(0.5), width: 2))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              fullCompanyName,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                Text(
                  stockPrice.toString(),
                  style: const TextStyle(fontSize: 29, color: Colors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "$persentChange %",
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
