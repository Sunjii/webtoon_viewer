import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoon = json.decode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonModel>> getToonByIds(List<String> ids) async {
    List<WebtoonModel> webtoonInstances = [];

    for (var id in ids) {
      var url = Uri.parse('$baseUrl/$id');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final WebtoonModel webtoon = jsonDecode(response.body);
        print(webtoon);
      }
    }

    return webtoonInstances;

    // List<WebtoonModel> webtoons = [];

    // for (var id in ids) {
    //   final url = Uri.parse('$baseUrl/$id');
    //   print(url);
    //   final response = await http.get(url);
    //   if (response.statusCode == 200) {
    //     final webtoon = json.decode(response.body);
    //     print(webtoon);
    //     webtoons.add(webtoon);
    //     print(webtoons);
    //   }
    // }
    // return webtoons;
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodeById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final episodes = json.decode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }

      return episodesInstances;
    }
    throw Error();
  }
}
