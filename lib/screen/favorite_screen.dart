import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/service/api_service.dart';
import 'package:toonflix/widgets/fav_webtoon_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late SharedPreferences prefs;
  late List<String> likedToonIds;

  late Future<List<WebtoonDetailModel>> webtoons;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      setState(() {
        likedToonIds = likedToons;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
    webtoons = ApiService.getFavoritToons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2,
        title: const Text(
          'Favorite',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 40,
          crossAxisSpacing: 15,
        ),
        itemCount: likedToonIds.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: webtoons,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var webtoon = snapshot.data![index];
                return FavWebtoon(
                  title: webtoon.title,
                  thumb: webtoon.thumb,
                  id: webtoon.id,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
