import 'package:quiz/models/news_channels_headlines_model.dart';
import 'package:quiz/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi() async {
    final response = await _rep.fetchNewsChannelHeadlinesApi();
    return response;
  }
}
