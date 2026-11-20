
import 'package:flutter/material.dart';

void main() {
  runApp(const RidoyShop());
}

class RidoyShop extends StatelessWidget {
  const RidoyShop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ridoy Shop BD',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> products = [
    {'name': 'টি-শার্ট', 'price': 350, 'icon': '👕'},
    {'name': 'জুতা', 'price': 850, 'icon': '👟'},
    {'name': 'ঘড়ি', 'price': 650, 'icon': '⌚'},
    {'name': 'ব্যাগ', 'price': 550, 'icon': '🎒'},
    {'name': 'হেডফোন', 'price': 450, 'icon': '🎧'},
    {'name': 'চশমা', 'price': 250, 'icon': '🕶️'},
  ];

  final Map<int, int> cart = {};

  int get total {
    int sum = 0;
    cart.forEach((index, quantity) {
      sum += products[index]['price'] as int * quantity;
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text('Ridoy Shop BD'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: showCart,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            color: Colors.green.shade50,
            child: const Column(
              children: [
                Text(
                  'স্বাগতম Ridoy Shop BD-তে!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('আপনার পছন্দের পণ্য কিনুন সহজেই'),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'আমাদের পণ্যসমূহ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: products.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product['icon'],
                          style: const TextStyle(fontSize: 48),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('৳${product['price']}'),
                        const SizedBox(height: 8),
                        FilledButton(
                          onPressed: () {
                            setState(() {
                              cart[index] = (cart[index] ?? 0) + 1;
                            });
                          },
                          child: const Text('কার্টে যোগ করুন'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showCart() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'আপনার শপিং কার্ট',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (cart.isEmpty)
                    const Text('কার্ট খালি'),
                  ...cart.entries.map((item) {
                    final product = products[item.key];

                    return ListTile(
                      title: Text(product['name']),
                      subtitle: Text(
                        '৳${product['price']} × ${item.value}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          setState(() {
                            if (cart[item.key] == 1) {
                              cart.remove(item.key);
                            } else {
                              cart[item.key] =
                                  cart[item.key]! - 1;
                            }
                          });
                          setSheetState(() {});
                        },
                      ),
                    );
                  }),
                  Text(
                    'মোট: ৳$total',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
