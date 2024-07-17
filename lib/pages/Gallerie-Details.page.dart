import 'package:flutter/material.dart';
import '../menu/drawer.widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GallerieDetailsPage extends StatefulWidget {
  final String keyword;

  GallerieDetailsPage(this.keyword);

  @override
  State<GallerieDetailsPage> createState() => _GallerieDetailsPageState();
}

class _GallerieDetailsPageState extends State<GallerieDetailsPage> {
  int currentPage = 1;
  int size = 10;
  late int totalPages;
  ScrollController _scrollController = ScrollController();
  List<dynamic> hits = [];
  var galleryData;

  @override
  void initState() {
    super.initState();
    getGalleryData(widget.keyword);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getGalleryData(widget.keyword);
        }
      }
    });
  }

  void getGalleryData(String keyword) {
    print("Gallerie de $keyword");
    String url = "https://pixabay.com/api/?key=15646595-375eb91b3408e352760ee72c8&q=$keyword&page=$currentPage&per_page=$size";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.galleryData = json.decode(resp.body);
        hits.addAll(galleryData['hits']);
        totalPages = (galleryData['totalHits'] / size).ceil();
        print(hits);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: totalPages == 0
            ? Text('Pas de résultats')
            : Text("${widget.keyword} Page $currentPage/$totalPages", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: Stack(
        children: [
          // Background container
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [ Colors.white ,Colors.white,Colors.purple],
              ),
            ),
          ),
          // Content with appropriate padding
          Padding(
            padding: const EdgeInsets.all(16.0), // Adjust padding as needed
            child: (galleryData == null)
                ? Center(child: CircularProgressIndicator(color: Colors.blueAccent))
                : ListView.builder(
              itemCount: hits.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              hits[index]['tags'],
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        color: Colors.purple,
                      ),
                    ),
                    Container(
                      child: Card(
                        child: Image.network(
                          hits[index]['webformatURL'],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
