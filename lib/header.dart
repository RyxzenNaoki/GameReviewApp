import 'package:flutter/material.dart';
import 'package:mobile_teori/search.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color:
            Color.fromARGB(255, 90, 24, 14), // Warna background biru keunguan
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      // Menambahkan warna latar belakang biru
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Selamat Datang',
                style: TextStyle(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 239, 235, 235),
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 10), // Beri jarak antar elemen
              CircleAvatar(
                child: Image.asset('images/gamer.png', fit: BoxFit.cover),
                radius: 20,
              ),
            ],
          ),
          const SizedBox(height: 10), // Beri jarak antar elemen
          const Text(
            'Kamu akan main game apa?',
            style: TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 10,
          ),
          const Search(),
        ],
      ),
    );
  }
}
