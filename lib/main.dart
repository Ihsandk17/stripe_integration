import 'package:ecom/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';

const String publichableKey = 'YOUR_PUBLIC_KEY';
const String secretKey = 'YOUR_SECRET_KEY';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publichableKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
