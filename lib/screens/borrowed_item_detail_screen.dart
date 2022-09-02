// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:peminjaman_alat_workshop/function/create_pdf.dart';
import 'package:peminjaman_alat_workshop/model/history.dart';
import 'package:peminjaman_alat_workshop/model/processed_cart.dart';
import 'package:peminjaman_alat_workshop/model/profile.dart';
import 'package:peminjaman_alat_workshop/style/colors.dart';

class BorrowedItemDetail extends StatelessWidget {
  const BorrowedItemDetail(
      {Key? key,
      required this.item,
      required this.status,
      required this.profile,
      required this.history})
      : super(key: key);
  final List<ProcessedCart> item;
  final String status;
  final Profile profile;
  final History history;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue(),
        actions: [
          if (status == "Borrowed")
            GestureDetector(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Checkout'),
                      content: const Text(
                          'You are about to make an order. Please check again before making an order'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            createPDF(context, item, profile, history);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: Center(child: Text("Return"))),
          if (status == "Borrowed")
            SizedBox(
              width: 15,
            )
        ],
      ),
      body: ListView.builder(
          itemCount: item.length,
          itemBuilder: (context, i) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(item[i].name),
                        if (item[i].remark!.isNotEmpty) Text(item[i].remark!)
                      ],
                    ),
                    Text("${item[i].qty}x")
                  ]),
            );
          }),
    );
  }
}
