import 'package:flutter/material.dart';
import 'package:stock_market/provider/wallet_provider.dart';

import '../components/stock_portfolio_field.dart';
import '../provider/provider_manager.dart';
import '../utils/colors.dart';
import '../utils/stock/user_stock.dart';
import '../utils/user.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  late User user;
  late WalletProvider wallet;
  String errorMSg = "Stocks not found!";
  List<UserStock> allStocks = [];

  @override
  void initState() {
    user = ProviderManager().getUser(context);
    wallet = ProviderManager().getWallet(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Column(
        children: [
          _title,
          Expanded(
              child: !wallet.hasInit
                  ? const CircularProgressIndicator()
                  : wallet.holding.isEmpty
                      ? const Text("You have to spend some to make some.")
                      : _portfolioView)
        ],
      ),
    );
  }

  Widget get _title {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: primeColorTrans, width: 2))),
      child: ListTile(
        onTap: null,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _titleStyle("Assets"),
              _titleStyle("Units"),
              _titleStyle("Avg. Open \$"),
              _titleStyle("Value \$"),
            ]),
      ),
    );
  }

  Widget get _portfolioView {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        if (allStocks.isNotEmpty)
          for (var stock in allStocks)
            StockPortfolioField(
              companyTitle: stock.symbol,
              amount: stock.amount,
              sellPrice: stock.price[0],
            )
        else
          _setInfoWidget
      ],
    );
  }

  Widget _titleStyle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w600, color: primeColor, fontSize: 15),
    );
  }

  Widget get _setInfoWidget {
    return Center(
        child: Text(
      errorMSg,
      style: const TextStyle(
        color: primeColorTrans,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    ));
  }
}
