import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quiz/models/news_channels_headlines_model.dart';
import 'package:quiz/screens/categories_screen.dart';
import 'package:quiz/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbc, cnn, aryNews, independent, aljazeera, reuters }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;

  final format = DateFormat('MMMM dd, yyyy');
  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()));
          },
          icon: const Icon(
            Icons.menu,
            size: 40,
          ),
        ),
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [
          PopupMenuButton<FilterList>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (FilterList item) {
              if (FilterList.bbc.name == item) {
                name = 'bbc-news';
              }
              if (FilterList.aryNews.name == item) {
                name = 'ary-news';
              }
              setState(() {
                selectedMenu = item;
              });
            },
            initialValue: selectedMenu,
            itemBuilder: (BuildContext context) => <PopupMenuItem<FilterList>>[
              const PopupMenuItem<FilterList>(
                  value: FilterList.bbc, child: Text('BBC News')),
              const PopupMenuItem<FilterList>(
                  value: FilterList.aryNews, child: Text('Ary News')),
              // const PopupMenuItem<FilterList>(
              //     value: FilterList.bbc, child: Text('CNN')),
              // const PopupMenuItem<FilterList>(
              //     value: FilterList.bbc, child: Text('Independent')),
              // const PopupMenuItem<FilterList>(
              //     value: FilterList.bbc, child: Text('Reuters')),
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadlinesApi(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      size: 40,
                      color: Colors.amber,
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * 0.9,
                                padding: EdgeInsets.symmetric(
                                    horizontal: height * 0.02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  // child: CachedNetworkImage(
                                  //   imageUrl: snapshot
                                  //       .data!.articles![index].urlToImage
                                  //       .toString(),
                                  //   fit: BoxFit.cover,
                                  //   placeholder: (context, url) =>
                                  //       const SizedBox(child: spinKit2),
                                  //   errorWidget: (context, url, error) =>
                                  //       const Icon(
                                  //     Icons.error_outline,
                                  //     color: Colors.red,
                                  //   ),
                                  // ),
                                  child: Image.asset(
                                    'assets/images/flower.png',
                                  ),

                                  // child: ExtendedImage.network(
                                  //   snapshot.data!.articles![index].urlToImage
                                  //       .toString(),
                                  //   fit: BoxFit.fill,
                                  // ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  color:
                                      const Color.fromARGB(255, 252, 233, 233),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: const EdgeInsets.all(15),
                                    height: height * .22,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: width * 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
