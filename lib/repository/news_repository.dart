import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz/models/news_channels_headlines_model.dart';

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=5c5afad730af41eca231d3cf266ec413';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
