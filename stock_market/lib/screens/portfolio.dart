import 'package:flutter/material.dart';
import 'package:stock_market/provider/wallet_provider.dart';

import '../components/stock_portfolio_field.dart';
import '../provider/provider_manager.dart';
import '../utils/colors.dart';
import '../utils/user.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  late User user;
  late WalletProvider wallet;
  String errorMSg = "";

  @override
  void initState() {
    user = ProviderManager().getUser(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    wallet = ProviderManager().getWallet(context, listen: true);
    super.didChangeDependencies();
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
                      ? const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text("You have to spend some to make some."))
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
              _titleStyle("Open \$"),
              _titleStyle("Value \$"),
            ]),
      ),
    );
  }

  Widget get _portfolioView {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        if (wallet.holding.isNotEmpty) ...[
          for (var stock in wallet.holding)
            StockPortfolioField(
              companyTitle: stock.symbol,
              stock: stock,
            ),
            const SizedBox(height: 20,),
          _setInfoWidget("Click on stock to close the trade"),
        ] else
          _setInfoWidget("Stocks not found!")
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

  Widget _setInfoWidget(String text) {
    return Center(
        child: Text(
      text,
      style: const TextStyle(
        color: primeColorTrans,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    ));
  }
}
