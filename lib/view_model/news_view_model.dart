import 'package:quiz/models/news_channels_headlines_model.dart';
import 'package:quiz/models/category_news_model.dart';
import 'package:quiz/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi() async {
    final response = await _rep.fetchNewsChannelHeadlinesApi();
    return response;
  }

  Future<CategoryNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}
