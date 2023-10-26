import 'dart:convert';

import 'package:crud/model/useremodels.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    fetchdata();
    setState(() {});
    super.initState();
  }

  Publicapiresponse? responsedata;
  bool isloading = false;
  fetchdata({String? searchquery = "trending"}) async {
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$searchquery&apiKey=2669d1f8cd1c4eb8b75812820b7c120e");
    var response = await http.get(url);

    print(response.statusCode);

    responsedata = Publicapiresponse.fromJson(jsonDecode(response.body));
  }

  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          isloading = true;
          setState(() {});
          fetchdata();

          await Future.delayed(const Duration(seconds: 2))
              .then((value) => isloading = false);

          setState(() {});
        },
        child: const Icon(Icons.search),
      ),
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchdata();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (value) {
                    fetchdata(searchquery: searchcontroller.text);
                  },
                  controller: searchcontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Search news..."),
                ),
              ),
              isloading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: responsedata?.articles?.length ?? 0,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(10.0),
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
                                  responsedata?.articles?[index].title
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
                                      responsedata?.articles?[index].urlToImage
                                              .toString() ??
                                          "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: SizedBox(
                                      width:
                                          MediaQuery.sizeOf(context).width * .4,
                                      child: Text(
                                        responsedata
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
            ]),
          ),
        ),
      ),
    );
  }
}
