// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:peminjaman_alat_workshop/style/colors.dart';
import 'package:peminjaman_alat_workshop/widget/custom_appbar.dart';

import '../model/cart.dart';
import '../model/product.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key, required this.listCart, required this.onTap})
      : super(key: key);
  final List<Cart> listCart;
  final Function() onTap;
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, false, [
        GestureDetector(
            onTap: () {
              widget.onTap();
            },
            child: Icon(
              Icons.output_rounded,
              color: blue(),
            )),
        SizedBox(
          width: 15,
        )
      ]),
      body: widget.listCart.isEmpty
          ? Center(child: Text("Order is empty"))
          : ListView.builder(
              itemCount: widget.listCart.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.listCart[i].name),
                      Text("${widget.listCart[i].qty}x")
                    ],
                  ),
                );
              }),
    );
  }
}
