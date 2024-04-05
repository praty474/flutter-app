import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quiz/models/category_news_model.dart';
import 'package:quiz/models/news_channels_headlines_model.dart';
import 'package:quiz/screens/home_screen.dart';
import 'package:quiz/screens/news_detail_screen.dart';
import 'package:quiz/view_model/news_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;

  final format = DateFormat('MMMM dd, yyyy');
  String category = 'general';

  List<String> categoriesList = [
    'general',
    'entertainment',
    'health',
    'sports',
    'technology',
    'business'
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        category = categoriesList[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15),
                            color: category == categoriesList[index]
                                ? Colors.blue
                                : Colors.grey,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                                child: Text(
                              categoriesList[index].toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            )),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
                child: FutureBuilder<CategoryNewsModel>(
                    future: newsViewModel.fetchCategoriesNewsApi(category),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitCircle(
                            size: 40,
                            color: Colors.amber,
                          ),
                        );
                      }

                      return Container(
                        padding: const EdgeInsets.all(10),
                        height: height * 0.5,
                        child: FutureBuilder<NewsChannelsHeadlinesModel>(
                            future:
                                newsViewModel.fetchNewsChannelHeadlinesApi(),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: SpinKitCircle(
                                    size: 40,
                                    color: Colors.amber,
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                    itemCount: snapshot.data!.articles!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      DateTime dateTime = DateTime.parse(
                                          snapshot.data!.articles![index]
                                              .publishedAt
                                              .toString());
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    NewsDetailsScreen(
                                                  newImage: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .urlToImage
                                                      .toString(),
                                                  newsTitle: snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  newsDate: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .publishedAt
                                                      .toString(),
                                                  author: snapshot.data!
                                                      .articles![index].author
                                                      .toString(),
                                                  description: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .description
                                                      .toString(),
                                                  content: snapshot.data!
                                                      .articles![index].content
                                                      .toString(),
                                                  source: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                ),
                                              ));
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    height: height * 0.2,
                                                    width: width * 0.3,
                                                    imageUrl: snapshot
                                                        .data!
                                                        .articles![index]
                                                        .urlToImage
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
                                                        const SizedBox(
                                                            child: spinKit2),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                      Icons.error_outline,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      right: 10),
                                                  height: height * 0.2,
                                                  width: width * .6,
                                                  child: Expanded(
                                                    child: Container(
                                                      child: Column(children: [
                                                        Text(
                                                          snapshot
                                                              .data!
                                                              .articles![index]
                                                              .title
                                                              .toString(),
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        Spacer(),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                snapshot
                                                                    .data!
                                                                    .articles![
                                                                        index]
                                                                    .source!
                                                                    .name
                                                                    .toString(),
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ),
                                                            Text(
                                                              format.format(
                                                                  dateTime),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              }
                            }),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
