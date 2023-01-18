import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lesson3/domain/api_client/account_api_client.dart';
import 'package:lesson3/domain/api_client/api_client_exteption.dart';
import 'package:lesson3/domain/api_client/auth_api_client.dart';
import 'package:lesson3/domain/data_providers/session_data_provider.dart';
import 'package:lesson3/ui/navigator/main_navigator.dart';

class AuthModel extends ChangeNotifier {
  final _authApiClient = AuthApiClient();
  final _accountApiClient = AccountApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль!';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();

    String? sessionId;
    int? accountId;
    try {
      sessionId =
          await _authApiClient.auth(username: login, password: password);
      accountId = await _accountApiClient.getAccountInfo(sessionId);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _errorMessage =
              'Сервер не доступен, проверьте подключение к интернету!';
          break;
        case ApiClientExceptionType.auth:
          _errorMessage = 'Неверный логин или пароль!';
          break;
        case ApiClientExceptionType.other:
          _errorMessage = 'Произошла ошибка, попробуйте ещё!';
          break;
        case ApiClientExceptionType.sessionExpired:
          _errorMessage = 'Произошла ошибка, попробуйте ещё!';
          break;
      }
    }

    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
    }

    if (sessionId == null || accountId == null) {
      _errorMessage = 'Неизвестная ошибка, повторите попытку!';
      notifyListeners();
      return;
    }

    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);

    unawaited(Navigator.of(context)
        .pushReplacementNamed(MainNavigationRoutesName.mainScreen));
  }
}
