import 'package:flutter/material.dart';
import '../services/currency_api.dart';

class CurrencyController extends ChangeNotifier {
  String fromCurrency = "USD";

  String toCurrency = "BDT";

  double rate = 0;

  double result = 0;

  bool loading = false;

  String error = "";

  Future<void> convert(double amount) async {
    try {
      loading = true;
      error = "";

      notifyListeners();

      rate = await CurrencyApi.getRate(fromCurrency, toCurrency);

      result = amount * rate;
    } catch (e) {
      error = "Unable to fetch exchange rate";
    }

    loading = false;

    notifyListeners();
  }

  void swap() {
    final temp = fromCurrency;

    fromCurrency = toCurrency;

    toCurrency = temp;

    notifyListeners();
  }

  void changeFrom(String value) {
    fromCurrency = value;

    notifyListeners();
  }

  void changeTo(String value) {
    toCurrency = value;

    notifyListeners();
  }
}
