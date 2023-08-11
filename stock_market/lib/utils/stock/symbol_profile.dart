
class SymbolProfile {
  final String country;
  final String currency;
  final String exchange;
  final String ipo;
  final double marketCapitalization;
  final String name;
  final String phone;
  final double shareOutstanding;
  final String ticker;
  final String webUrl;
  final String logo;
  final String finnhubIndustry;

  SymbolProfile({
    this.country = "",
    this.currency = "",
    this.exchange = "",
    this.ipo = "",
    this.marketCapitalization = 0,
    this.name = "",
    this.phone = "",
    this.shareOutstanding = 0,
    this.ticker = "",
    this.webUrl = "",
    this.logo = "",
    this.finnhubIndustry = "",
  });

  factory SymbolProfile.fromJson(Map<String, dynamic> json) {
    return SymbolProfile(
      country: json['country'],
      currency: json['currency'],
      exchange: json['exchange'],
      ipo: json['ipo'],
      marketCapitalization: json['marketCapitalization'],
      name: json['name'],
      phone: "${json['phone']}",
      shareOutstanding: double.parse("${json['shareOutstanding']}"),
      ticker: json['ticker'],
      webUrl: json['weburl'],
      logo: json['logo'],
      finnhubIndustry: json['finnhubIndustry'],
    );
  }

  @override
  String toString() {
    return "name: $name, image: $logo.";
  }
}
