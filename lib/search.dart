import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          const SizedBox(height: 6),
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search_outlined,
              ),
              hintText: 'Cari game',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors
                  .grey[200], // Latar belakang input agar terlihat lebih jelas
            ),
          ),
          Positioned(
            bottom: 6,
            right: 12,
            child: IconButton(
              icon: const Icon(Icons.mic_outlined),
              onPressed: () {
                // Tambahkan logika saat ikon mikrofon ditekan
              },
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
