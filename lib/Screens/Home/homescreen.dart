import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:news_app/Back-End/api.dart';
import 'package:news_app/Models/news_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsData> news = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  bool isLoading = true;

  setloading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void fetchData() async {
    final requestData = await API.getNews();

    print("status is = ${requestData.status}");

    if (requestData.status == "ok") {
      for (var data in requestData.articles) {
        news.add(NewsData.fromJson(data));
      }
      setloading();
    } else {
      setloading();
      print("something happened ${requestData.status}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Trending News",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.red),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: isLoading
              ? SizedBox()
              : news.isEmpty
                  ? const Center(
                      child: Text(
                        "No data found ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 26),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return HomeDetailPage(item: item);
                              //     },
                              //   ),
                              // );
                            },
                            child: ListTile(
                              title: Text(
                                news[index].title!,
                                style: TextStyle(fontSize: 15),
                              ),
                              leading: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(news[index].urlToImage!),
                                  ),
                                ),
                              ),
                            ));
                      },
                    ),
        ),
      ),
    );
  }
}
