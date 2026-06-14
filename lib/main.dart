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
        primaryColor: const Color(0xFF517DA2), // Синий цвет TG
        scaffoldBackgroundColor: const Color(0xFFEFF3F6), // Светло-серый фон для настроек
        appBarTheme: const AppBarTheme(
          backgroundColor: const Color(0xFF517DA2),
          elevation: 0,
        ),
      ),
      home: const MainHomeScreen(),
    );
  }
}

// Главный экран (пустой, с рабочим боковым меню)
class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Telegram',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21, color: Colors.white),
        ),
        // Теперь кнопка меню автоматически открывает Drawer (шторку)
      ),
      // Боковое меню как в ТГ
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
                'Твой Профиль',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: const Text('@username'),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline, color: Colors.grey),
              title: const Text('Мой Профиль', style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.pop(context); // Закрываем меню
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelegramProfileScreen()),
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
          'Чаты удалены.\nОткрой меню слева, чтобы перейти в Профиль!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
    );
  }
}

// Настоящий экран профиля в стиле Telegram
class TelegramProfileScreen extends StatelessWidget {
  const TelegramProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Кнопка назад теперь работает!
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Верхний блок профиля (Аватарка и Имя)
            Container(
              color: const Color(0xFF517DA2),
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white24,
                    child: Text(
                      'U',
                      style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Разработчик',
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'в сети',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Блок «Аккаунт»
            Container(
              color: Colors.white,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 12, bottom: 4),
                    child: Text(
                      'Аккаунт',
                      style: TextStyle(color: Color(0xFF517DA2), fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  ListTile(
                    title: Text('+380 99 123 4567'),
                    subtitle: Text('Нажмите, чтобы изменить номер телефона'),
                  ),
                  Divider(height: 1, indent: 16),
                  ListTile(
                    title: Text('@my_telegram_dev'),
                    subtitle: Text('Имя пользователя'),
                  ),
                  Divider(height: 1, indent: 16),
                  ListTile(
                    title: Text('О себе'),
                    subtitle: Text('Создаю свой собственный Telegram на Flutter 🚀'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Блок «Настройки»
            Container(
              color: Colors.white,
              child: const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.notifications_none, color: Colors.grey),
                    title: Text('Уведомления и звуки'),
                  ),
                  Divider(height: 1, indent: 64),
                  ListTile(
                    leading: Icon(Icons.lock_outline, color: Colors.grey),
                    title: Text('Конфиденциальность'),
                  ),
                  Divider(height: 1, indent: 64),
                  ListTile(
                    leading: Icon(Icons.pie_chart_outline, color: Colors.grey),
                    title: Text('Данные и память'),
                  ),
                  Divider(height: 1, indent: 64),
                  ListTile(
                    leading: Icon(Icons.chat_bubble_outline, color: Colors.grey),
                    title: Text('Настройки чатов'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
