import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_teori/gamepopuler.dart';
import 'package:mobile_teori/gameterbaru.dart';
import 'package:mobile_teori/gamecategory.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kategori',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _menuItem(
                  const Color.fromARGB(255, 255, 68, 0),
                  'images/arcade.svg',
                  'Arcade',
                  context,
                ),
                _menuItem(
                  const Color(0xFFFFC77A6),
                  'images/racing.svg',
                  'Racing',
                  context,
                ),
                _menuItem(
                  const Color.fromARGB(255, 177, 5, 5),
                  'images/strategy.svg',
                  'Strategy',
                  context,
                ),
                _menuItem(
                  const Color.fromARGB(255, 224, 112, 112),
                  'images/more.svg',
                  'Lainnya',
                  context,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Game Populer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 280, // Tetapkan tinggi eksplisit
              child: GamePopuler(),
            ),
            const Text(
              'Game Terbaru',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250, // Tetapkan tinggi eksplisit
              child: GameTerbaru(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(
      Color bgColor, String icon, String title, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => GamesByCategoryScreen(category: title),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              icon,
              height: 40,
              width: 40,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
