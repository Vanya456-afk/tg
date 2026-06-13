import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CustomTelegramApp(),
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
  ));
}

class CustomTelegramApp extends StatefulWidget {
  @override
  _CustomTelegramAppState createState() => _CustomTelegramAppState();
}

class _CustomTelegramAppState extends State<CustomTelegramApp> {
  // Данные приложения
  int starsBalance = 150;
  List<String> myGifts = ["🔥 Статус"];
  List<String> vladsGifts = ["🎈 Шарик"];
  final TextEditingController _promoController = TextEditingController();

  // Логика промокода
  void activatePromo() {
    String code = _promoController.text.trim();
    if (code == "only2026") {
      setState(() {
        starsBalance += 500;
      });
      _promoController.clear();
    }
  }

  // Логика покупки
  void buyGift(String icon, String name, int price) {
    if (starsBalance >= price) {
      setState(() {
        starsBalance -= price;
        myGifts.add("$icon $name");
      });
    }
  }

  // Логика отправки другу
  void sendToVlad(String gift) {
    if (myGifts.contains(gift)) {
      setState(() {
        myGifts.remove(gift);
        vladsGifts.add(gift);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1621),
      appBar: AppBar(
        title: const Text("Custom Telegram 2026"),
        backgroundColor: const Color(0xFF17212B),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Виджет профиля
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF17212B),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.blue,
                      child: Text("DEV", style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 10),
                    Text("Баланс: $starsBalance ⭐️", style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.amber)),
                    const SizedBox(height: 15),
                    const Text("Твоя витрина подарков:", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    Text(myGifts.isEmpty ? "Пусто" : myGifts.join("   "), style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Поле ввода промокода
              const Text(" Активация промокода:", style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _promoController,
                      decoration: InputDecoration(
                        hintText: "Введите код...",
                        filled: true,
                        fillColor: const Color(0xFF17212B),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
                    onPressed: activatePromo,
                    child: const Text("OK"),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Витрина магазина
              const Text(" Магазин кастомных подарков:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              buildGiftRow("👑", "Корона", 100),
              buildGiftRow("🏆", "Кубок", 50),
              buildGiftRow("💻", "Скрипт", 15),
              const SizedBox(height: 25),

              // Кнопки отправки подарка другу
              const Text(" Отправить подарок другу (Влад):", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              myGifts.isEmpty 
                ? const Text("У тебя нет подарков для отправки", style
