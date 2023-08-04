import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/user.dart';
import 'user_provider.dart';

class ProviderManager {
  User getUser(BuildContext context) {
    return Provider.of<UserDataProvider>(context, listen: false).user;
  }

  void setUser(BuildContext context, User user) {
    Provider.of<UserDataProvider>(context, listen: false).user = user;
  }
}
