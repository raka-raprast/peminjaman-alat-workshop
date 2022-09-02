// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:peminjaman_alat_workshop/model/processed_cart.dart';
import 'package:peminjaman_alat_workshop/model/profile.dart';
import 'package:peminjaman_alat_workshop/screens/borrowed_item_detail_screen.dart';
import 'package:peminjaman_alat_workshop/widget/custom_appbar.dart';

import '../model/history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen(
      {Key? key,
      required this.histories,
      required this.processedCart,
      required this.profile})
      : super(key: key);
  final List<History> histories;
  final List<ProcessedCart> processedCart;
  final Profile profile;
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, false, []),
      body: widget.histories.isEmpty
          ? Center(child: Text("No history yet"))
          : ListView.builder(
              itemCount: widget.histories.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BorrowedItemDetail(
                              item: widget.processedCart
                                  .where((element) =>
                                      element.id == widget.histories[i].id)
                                  .toList(),
                              status: widget.histories[i].status,
                              profile: widget.profile,
                              history: widget.histories[i],
                            )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${DateTime.parse(widget.histories[i].borrowTime).day}-${DateTime.parse(widget.histories[i].borrowTime).month}-${DateTime.parse(widget.histories[i].borrowTime).year} (${DateTime.parse(widget.histories[i].borrowTime).hour}:${DateTime.parse(widget.histories[i].borrowTime).minute})"),
                                  Text(
                                      "Borrowed item: ${widget.histories[i].borrowedItemQty}")
                                ],
                              ),
                            ],
                          ),
                          Text(widget.histories[i].status)
                        ]),
                  ),
                );
              }),
    );
  }
}
