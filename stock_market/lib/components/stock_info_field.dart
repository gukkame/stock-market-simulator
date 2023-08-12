import 'package:flutter/material.dart';

class StockInfoField extends StatefulWidget {
  const StockInfoField({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<StockInfoField> createState() => _StockInfoFieldState();
}

class _StockInfoFieldState extends State<StockInfoField> {
  var fullCompanyName = "NVIDIA Corporation";
  var stockPrice = 234.23;
  var persentChange = -2.22;
  var logo = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Colors.white.withOpacity(0.3), width: 2))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
    );
  }

  void getStockInfo() {
    //! Get only this stock info from db
  }
}
