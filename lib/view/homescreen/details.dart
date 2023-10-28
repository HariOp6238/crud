import 'package:crud/model/useremodels.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key, required this.newarticle});
  final Article newarticle;

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          label: const Text("Read More"),
          onPressed: () {
            launchUrl(Uri.parse(widget.newarticle.url.toString()),
                mode: LaunchMode.externalApplication);
          }),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 1,
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          NetworkImage(widget.newarticle.urlToImage.toString()),
                      fit: BoxFit.fill)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 290),
                    child: Container(
                      width: 350,
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          widget.newarticle.title.toString(),
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 190,
                        height: 50,
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            widget.newarticle.author.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: 190,
                        height: 50,
                        color: Colors.transparent,
                        child: Center(
                            child: Text(
                          widget.newarticle.publishedAt.toString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 1,
              height: 500,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: widget.newarticle.content.toString(),
                      style: TextStyle(fontSize: 18))
                ])),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
