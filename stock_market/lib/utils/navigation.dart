import 'package:flutter/cupertino.dart';

// Navigates to the given router page
void navigate(BuildContext context, String routeName, {Object? args}) {
  Navigator.pushNamed(context, routeName, arguments: args);
}

// Extract arguments when navigating
class Arguments {
  final List? arg;
  final String? symbol;

  factory Arguments.from(BuildContext context) {
    var data = (ModalRoute.of(context)!.settings.arguments ?? <String, List>{})
        as Map<String, dynamic>;

    return Arguments(
      data.containsKey("arg") ? data["arg"] : null,
      data.containsKey("symbol") ? data["symbol"] : null,
    );
  }

  Arguments(this.arg, this.symbol);
}


//navigate(context, "/tohere", args: {"symbol": "whatever"})

//Arguments.from(context).symbol