import 'package:flutter/material.dart';
import 'package:toonflix/screen/fav_detail_screen.dart';

class FavWebtoon extends StatelessWidget {
  final String title, thumb, id;
  // FIXME: 풀 사이즈 썸네일 구할 수가 없음..
  final String full_thumb = '42';

  const FavWebtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FavDetailScreen(title: title, thumb: thumb, id: id),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 150,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 50,
                      offset: const Offset(1, 1),
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ]),
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
