import 'package:flutter/cupertino.dart';

// Navigates to the given router page
void navigate(BuildContext context, String routeName, {Object? args}) {
  Navigator.pushNamed(context, routeName, arguments: args);
}

// Extract arguments when navigating
class Arguments {
  late String? arg;

  factory Arguments.from(BuildContext context) {
    var data = (ModalRoute.of(context)!.settings.arguments ??
        <String, dynamic>{}) as Map<String, dynamic>;

    return Arguments(data.containsKey("arg") ? data["arg"] : null);
  }

  Arguments(this.arg);
}


//navigate(context, "/tohere", args: {"symbol": "whatever"})

//Arguments.from(context).symbol