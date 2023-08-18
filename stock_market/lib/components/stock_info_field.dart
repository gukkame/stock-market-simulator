import 'package:flutter/material.dart';

import '../provider/provider_manager.dart';
import '../utils/stock/market_stock.dart';

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
  @override
  Widget build(BuildContext context) {
    MarketStock? stock = ProviderManager().getStock(context, widget.title);

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
            stock == null ? "Loading..." : widget.title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            stock == null ? "Loading..." : stock.name,
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
                stock == null
                    ? "Loading..."
                    : "${stock.buyPrice.toString()} ${stock.currency}",
                // stockPrice.toString(),
                style: const TextStyle(fontSize: 29, color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
              // Text(
              //   "$presentChange %",
              //   style: const TextStyle(fontSize: 14, color: Colors.white),
              // ),
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
