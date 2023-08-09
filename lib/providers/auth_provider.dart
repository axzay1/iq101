import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../model/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User? userDetails;

  void setUserDetails(User? userData) {
    userDetails = userData;
    if (kDebugMode) {
      print(userDetails?.id);
    }
    notifyListeners();
  }

  void resetUserDetails() {
    userDetails = null;
    print(userDetails);
    notifyListeners();
  }
}