import 'package:flutter/material.dart';

void main() {
  runApp(const TelegramApp());
}

class TelegramApp extends StatelessWidget {
  const TelegramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF517DA2),
        scaffoldBackgroundColor: const Color(0xFFEFF3F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: const Color(0xFF517DA2),
          elevation: 0,
        ),
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int telegramStars = 500;

  void buyGift(int price, String giftName) {
    if (telegramStars >= price) {
      setState(() {
        telegramStars -= price;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Вы успешно купили "$giftName" за $price ⭐️!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Недостаточно звёзд ⭐️!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Telegram',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21, color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF517DA2)),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'Я',
                  style: TextStyle(fontSize: 28, color: Color(0xFF517DA2), fontWeight: FontWeight.bold),
                ),
              ),
              accountName: const Text(
                'Разработчик',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text('⭐️ Баланс: $telegramStars звёзд'),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline, color: Colors.grey),
              title: const Text('Мой Профиль', style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelegramProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.card_giftcard, color: Colors.purple),
              title: const Text('Подарки', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('NEW', style: TextStyle(color: Colors.purple, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelegramGiftsScreen(
                      starsBalance: telegramStars,
                      onBuyGift: buyGift,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined, color: Colors.grey),
              title: const Text('Настройки', style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelegramProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Открой меню слева,\nчтобы посмотреть Подарки или Профиль!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
    );
  }
}

class TelegramGiftsScreen extends StatelessWidget {
  final int starsBalance;
  final Function(int, String) onBuyGift;

  const TelegramGiftsScreen({
    super.key,
    required this.starsBalance,
    required this.onBuyGift,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gifts = [
      {"name": "Обычный подарок", "emoji": "🎁", "price": 15, "color": Colors.blue.shade50},
      {"name": "Редкий подарок", "emoji": "🎨", "price": 25, "color": Colors.green.shade50},
      {"name": "Эпический подарок", "emoji": "⚡", "price": 50, "color": Colors.orange.shade50},
      {"name": "Легендарный подарок", "emoji": "👑", "price": 100, "color": Colors.purple.shade50},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Подарки', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF517DA2),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Ваш баланс',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('⭐️ ', style: TextStyle(fontSize: 26)),
                    Text(
                      '$starsBalance',
                      style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const Text(' звёзд', style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Доступные подарки:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black80),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemCount: gifts.length,
                itemBuilder: (context, index) {
                  final gift = gifts[index];
                  return Card(
                    color: gift["color"],
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            gift["emoji"],
                            style: const TextStyle(fontSize: 45),
                          ),
                          Text(
                            gift["name"],
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF517DA2),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            onPressed: () {
                              onBuyGift(gift["price"], gift["name"]);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('⭐️ ', style: TextStyle(fontSize: 12)),
                                Text('${gift["price"]}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TelegramProfileScreen extends StatelessWidget {
  const TelegramProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0xFF517DA2),
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white24,
                    child: Text('U', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Разработчик', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('в сети', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              color: Colors.white,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 12, bottom: 4),
                    child: Text('Аккаунт', style: TextStyle(color: Color(0xFF517DA2), fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  ListTile(title: Text('+380 99 123 4567'), subtitle: Text('Нажмите, чтобы изменить номер телефона')),
                  Divider(height: 1, indent: 16),
                  ListTile(title: Text('@my_telegram_dev'), subtitle: Text('Имя пользователя')),
                  Divider(height: 1, indent: 16),
                  ListTile(title: Text('О себе'), subtitle: Text('Создаю свой собственный Telegram на Flutter 🚀')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
