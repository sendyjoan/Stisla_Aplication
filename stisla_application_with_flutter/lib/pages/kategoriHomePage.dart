import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stisla_application_with_flutter/api/crud_helper.dart';
import 'package:stisla_application_with_flutter/model/kategori_model.dart';

class MainKategori extends StatefulWidget {
  const MainKategori({
    super.key,
  });

  @override
  State<MainKategori> createState() => _MainKategoriState();
}

class _MainKategoriState extends State<MainKategori> {
  List listCategory = [];
  String name = '';
  List<String> user = [];
  List<Category> categories = [];
  int selectedIndex = 0;
  int currentPage = 1;
  int lastPage = 0;
  bool isLoading = true;
  final ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  fetchData() {
    CrudHelper.getCategories(currentPage.toString()).then((resultList) {
      setState(() {
        categories = resultList[0];
        lastPage = resultList[1];
        isLoading = false;
      });
    });
  }

  addMoreData() {
    CrudHelper.getCategories(currentPage.toString()).then((resultList) {
      setState(() {
        categories.addAll(resultList[0]);
        lastPage = resultList[1];
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (currentPage < lastPage) {
          setState(() {
            isLoading = true;
            currentPage++;
            addMoreData();
          });
        }
      }
    });

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Kategori',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        automaticallyImplyLeading: false,
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color(0xFF6777EE),
      //   onPressed: () {
      //     showDialog(
      //         context: context,
      //         builder: (context) {
      //           return const TambahKategori();
      //         });
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     size: 40,
      //     color: Colors.black,
      //   ),
      // ),
      body: Container(
        color: Colors.black,
        child: <Widget>[
          ListView.builder(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 25.0,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.yellow,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: const <Widget>[
                          Icon(Icons.create_rounded, color: Colors.white),
                          Text('Edit',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Icon(Icons.delete, color: Colors.white),
                          Text('Hapus',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  // onDismissed: (DismissDirection direction) {
                  //   if (direction == DismissDirection.startToEnd) {
                  //     showDialog(
                  //         context: context,
                  //         builder: (context) {
                  //           return EditKategori(category: categories[index]);
                  //         });
                  //   } else {
                  //     showDialog(
                  //         context: context,
                  //         builder: (context) {
                  //           return DeleteCategori(category: categories[index]);
                  //         });
                  //   }
                  // },
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 1,
                    )),
                    child: ListTile(
                      title: Text(
                        categories[index].name,
                        style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }),
        ][currentPageIndex],
      ),
    );
  }
}

int currentPageIndex = 0;
