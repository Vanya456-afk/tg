import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vasanin Brawl App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _starsBalance = 500;
  final TextEditingController _promoController = TextEditingController();
  bool _isPromoUsed = false;

  final List<Map<String, dynamic>> _gifts = [
    {'name': 'Обычный ящик', 'price': 100, 'icon': Icons.card_giftcard},
    {'name': 'Большой ящик', 'price': 250, 'icon': Icons.shopping_bag},
    {'name': 'Мегаящик', 'price': 500, 'icon': Icons.workspace_premium},
  ];

  void _checkPromo() {
    if (_promoController.text.trim() == 'only2026') {
      if (!_isPromoUsed) {
        setState(() {
          _starsBalance += 1000;
          _isPromoUsed = true;
        });
        _showSnackBar('Промокод успешно активирован! +1000 Звёзд 🌟', Colors.green);
      } else {
        _showSnackBar('Вы уже активировали этот промокод!', Colors.orange);
      }
    } else {
      _showSnackBar('Неверный промокод!', Colors.red);
    }
    _promoController.clear();
  }

  void _buyGift(String name, int price) {
    if (_starsBalance >= price) {
      setState(() {
        _starsBalance -= price;
      });
      _showSnackBar('Вы успешно приобрели "$name"! 🎉', Colors.green);
    } else {
      _showSnackBar('Недостаточно звёзд для покупки!', Colors.red);
    }
  }

  void _showSnackBar(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, style: const TextStyle(fontSize: 16)),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vasanin Brawl Profile'),
        backgroundColor: Colors.deepPurple,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 28),
                const SizedBox(width: 4),
                Text(
                  '$_starsBalance',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Colors.deepPurple.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: Colors.deepPurple),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.deepPurple,
                        child: Icon(Icons.person, size: 40, color: Colors.white),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Разработчик',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Статус: В сети',
                            style: TextStyle(color: Colors.greenAccent),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Активация промокода',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _promoController,
                      decoration: InputDecoration(
                        hintText: 'Введите промокод',
                        filled: true,
                        fillColor: Colors.grey[900],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _checkPromo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('ОК', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Магазин подарков',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _gifts.length,
                itemBuilder: (context, index) {
                  final gift = _gifts[index];
                  return Card(
                    color: Colors.grey[900],
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Icon(gift['icon'], color: Colors.amber, size: 30),
                      title: Text(gift['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${gift['price']} Звёзд'),
                      trailing: ElevatedButton(
                        onPressed: () => _buyGift(gift['name'], gift['price']),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text('Купить'),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
