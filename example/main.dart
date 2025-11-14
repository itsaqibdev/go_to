import 'package:flutter/material.dart';
import 'package:go_to/go_to.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GO_TO Package Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/second': (context) => const SecondScreen(),
        '/third': (context) => const ThirdScreen(),
        '/product': (context) {
          // Extract arguments for parameterized route
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return ProductDetailsScreen(
            productId: args?['id'] ?? 0,
            productName: args?['name'] ?? 'Unknown Product',
            price: args?['price'] ?? 0.0,
          );
        },
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Simple navigation
                GoTo.screen(context, const SecondScreen());
              },
              child: const Text('Go to Second Screen (Simple)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Named route navigation
                GoTo.named(context, '/second');
              },
              child: const Text('Go to Second Screen (Named)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigation with transition
                GoTo.transition(
                  context,
                  const SecondScreen(),
                  transition: PageTransition.slideFromRight(),
                );
              },
              child: const Text('Go to Second Screen (Slide Right)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Using extension method
                context.goTo(const SecondScreen());
              },
              child: const Text('Go to Second Screen (Extension)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate with parameters using named route
                GoTo.named(context, '/product', arguments: {
                  'id': 123,
                  'name': 'Premium Widget',
                  'price': 29.99,
                });
              },
              child: const Text('Go to Product Details (with parameters)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate with parameters using direct widget
                context.goTo(ProductDetailsScreen(
                  productId: 456,
                  productName: 'Standard Widget',
                  price: 19.99,
                ));
              },
              child: const Text('Go to Product Details (direct widget)'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                GoTo.screen(context, const ThirdScreen());
              },
              child: const Text('Go to Third Screen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                GoTo.back(context);
              },
              child: const Text('Go Back'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                GoTo.back(context, times: 2);
              },
              child: const Text('Go Back 2 Screens'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                GoTo.first(context);
              },
              child: const Text('Go to First Screen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                GoTo.back(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// Example of a parameterized screen
class ProductDetailsScreen extends StatelessWidget {
  final int productId;
  final String productName;
  final double price;
  
  const ProductDetailsScreen({
    super.key,
    required this.productId,
    required this.productName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              productName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text('Product ID: $productId'),
            const SizedBox(height: 10),
            Text('Price: \$${price.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                GoTo.back(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}