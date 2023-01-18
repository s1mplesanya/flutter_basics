import 'package:flutter/material.dart';
import 'package:lesson3/domain/data_providers/session_data_provider.dart';
import 'package:lesson3/ui/navigator/main_navigator.dart';

class MyAppModel {
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;

  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    _isAuth = sessionId != null;
  }

  Future<void> resetSession(BuildContext context) async {
    await _sessionDataProvider.setSessionId(null);
    await _sessionDataProvider.setAccountId(null);
    await Navigator.of(context)
        .pushNamedAndRemoveUntil(MainNavigationRoutesName.auth, (_) => false);
  }
}
