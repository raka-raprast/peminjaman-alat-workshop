// ignore_for_file: prefer_const_constructors, empty_statements, avoid_function_literals_in_foreach_calls

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:peminjaman_alat_workshop/data/fake_data.dart';
import 'package:peminjaman_alat_workshop/model/product.dart';
import 'package:peminjaman_alat_workshop/screens/product_transaction_screen.dart';
import 'package:peminjaman_alat_workshop/style/colors.dart';
import 'package:peminjaman_alat_workshop/style/sizes.dart';
import 'package:peminjaman_alat_workshop/widget/custom_appbar.dart';
import 'package:peminjaman_alat_workshop/widget/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.products, required this.onTap})
      : super(key: key);
  final List<Product> products;
  final Function(Product item, int qty, String remark) onTap;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> searchResult = [];
  List<String> categoryList = [
    "All",
    "Rack Measurement No 1",
    "Rack Handtools No 2",
    "Rack Handtools No 3",
    "Rack Consumable No 5",
    "Opened rack ToolRoom",
    "Utility asset",
    "Toolbox imperial",
    "Toolbox 07"
  ];
  String searchTerm = '';
  int selectedCategory = 0;
  bool initialized = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, false, []),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: halfGrey().withOpacity(.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidth(context) * .7,
                child: TextField(
                  onChanged: (s) {
                    searchResult.clear();
                    setState(() {
                      initialized = false;
                      searchTerm = s;
                      selectedCategory = 0;
                    });

                    widget.products.forEach((element) {
                      if (element.name
                          .toLowerCase()
                          .contains(s.toLowerCase())) {
                        searchResult.add(element);
                      }
                    });
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: Colors.black38, fontWeight: FontWeight.w500),
                      hintText: "Search Product Name"),
                ),
              ),
              Image.asset("lib/assets/search.png"),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: 10,
          ),
          height: screenHeight(context) * .025,
          width: screenWidth(context),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    selectedCategory = i;
                    searchResult.clear();
                    widget.products.forEach((e) {
                      if (e.category == categoryList[selectedCategory] ||
                          categoryList[selectedCategory] == "All") {
                        searchResult.add(e);
                      }
                    });
                    initialized = false;
                    log(searchResult.length.toString());
                    log(widget.products.length.toString());
                    setState(() {});
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: selectedCategory == i
                              ? Colors.grey
                              : Colors.transparent,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        categoryList[i],
                        style: TextStyle(
                            color: selectedCategory == i
                                ? Colors.white
                                : Colors.black),
                      )),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            categoryList[selectedCategory],
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.525,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              crossAxisCount: 2,
            ),
            itemCount:
                initialized ? widget.products.length : searchResult.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(
                product:
                    initialized ? widget.products[index] : searchResult[index],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductTransactionScreen(
                                product: initialized
                                    ? widget.products[index]
                                    : searchResult[index],
                                onTap: (p, q, s) {
                                  widget.onTap(p, q, s);
                                },
                              )));
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
