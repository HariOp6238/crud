import 'package:carousel_slider/carousel_slider.dart';
import 'package:crud/controll/controller.dart';
import 'package:crud/view/homescreen/details.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<Screencontroller>(context, listen: false).fetchdata();

    super.initState();
  }

  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final homeprovider = Provider.of<Screencontroller>(context);
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     homeprovider.isloading = true;

      //     homeprovider.fetchdata();

      //     await Future.delayed(const Duration(seconds: 2))
      //         .then((value) => homeprovider.isloading = false);

      //   },
      //   child: const Icon(Icons.search),
      // ),
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await homeprovider.fetchdata();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (value) {
                    homeprovider.fetchdata(searchquery: searchcontroller.text);
                  },
                  controller: searchcontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Search news..."),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 120, bottom: 10),
                child: Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: Text(
                      "Top trending News",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              CarouselSlider(
                  items: List.generate(
                      homeprovider.responsedata?.articles?.length ?? 0,

                      // ignore: sized_box_for_whitespace
                      (index) => Container(
                            height: 100,
                            child: Stack(children: [
                              Image.network(
                                homeprovider.responsedata?.articles?[index]
                                        .urlToImage
                                        .toString() ??
                                    "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png",
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                bottom: 25,
                                child: Text(
                                  homeprovider
                                          .responsedata?.articles?[index].title
                                          .toString() ??
                                      "",
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                              )
                            ]),
                          )),
                  options: CarouselOptions(
                    height: 250,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  )),
              homeprovider.isloading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          homeprovider.responsedata?.articles?.length ?? 0,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            if (homeprovider.responsedata?.articles?[index] !=
                                null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Screen2(
                                        newarticle: homeprovider
                                            .responsedata!.articles![index]),
                                  ));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            width: double.infinity,
                            height: 350,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    homeprovider.responsedata?.articles?[index]
                                            .title
                                            .toString() ??
                                        "",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      width: 150,
                                      child: Image.network(
                                        homeprovider.responsedata
                                                ?.articles?[index].urlToImage
                                                .toString() ??
                                            "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                .4,
                                        child: Text(
                                          homeprovider.responsedata
                                                  ?.articles?[index].description
                                                  .toString() ??
                                              "",
                                          maxLines: 10,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ]),
          ),
        ),
      ),
    );
  }
}
