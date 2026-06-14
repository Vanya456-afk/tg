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
      // Задаем фирменную тему Telegram
      theme: ThemeData(
        primaryColor: const Color(0xFF517DA2), // Классический синий цвет Telegram
        appBarTheme: const AppBarTheme(
          backgroundColor: const Color(0xFF517DA2),
          elevation: 1,
        ),
      ),
      home: const ChatListScreen(),
    );
  }
}

// Экран со списком чатов
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Список фейковых чатов для красивого дизайна
    final List<Map<String, String>> chats = [
      {"name": "Влад", "message": "Го в Бравл? Скины новые вышли!", "time": "12:40", "unread": "2"},
      {"name": "Аня", "message": "Привет! Ты написал код для бота? 😊", "time": "11:15", "unread": "0"},
      {"name": "Telegram Bot", "message": "Твоё приложение успешно собрано!", "time": "Вчера", "unread": "0"},
      {"name": "Команда Разработки", "message": "Обновление дизайна до версии 2026.1", "time": "Пятница", "unread": "5"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Telegram',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white), // Кнопка меню слева
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white), // Поиск справа
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: chats.length,
        separatorBuilder: (context, index) => const Divider(height: 1, indent: 72), // Тонкая линия между чатами
        itemBuilder: (context, index) {
          final chat = chats[index];
          final hasUnread = chat["unread"] != "0";

          return ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.blueAccent.shade100,
              child: Text(
                chat["name"]![0], // Первая буква имени на аватарке
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              chat["name"]!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              chat["message"]!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // Скрывает длинный текст под троеточие
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat["time"]!,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
                const SizedBox(height: 6),
                if (hasUnread)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFF52BE80), // Зеленый кружок непрочитанных сообщений
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      chat["unread"]!,
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  )
                else
                  const SizedBox(height: 20),
              ],
            ),
            onTap: () {
              // Здесь будет переход в сам чат
            },
          );
        },
      ),
      // Фирменная круглая плавающая кнопка карандаша, как в ТГ
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF517DA2),
        child: const Icon(Icons.edit, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}
