import 'dart:convert';

import 'package:ecom/main.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeServices {
  static Future<Map<String, dynamic>> createPaymentIntent(double amount) async {
    try {
      final body = {
        'amount': (amount * 100).toInt().toString(),
        'currency': 'usd',
      };

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),

        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('$e');
    }
  }

  static Future<void> makePayment(double amount) async {
    try {
      final paymentIntent = await createPaymentIntent(amount);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Ihsan Store',
          paymentIntentClientSecret: paymentIntent['client_secret'],
        ),
      );
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      throw Exception('$e');
    }
  }
}
