// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:peminjaman_alat_workshop/model/product.dart';
import 'package:peminjaman_alat_workshop/style/colors.dart';
import 'package:peminjaman_alat_workshop/style/sizes.dart';
import 'package:peminjaman_alat_workshop/widget/custom_appbar.dart';

class ProductTransactionScreen extends StatefulWidget {
  const ProductTransactionScreen(
      {Key? key, required this.product, required this.onTap})
      : super(key: key);
  final Product product;
  final Function(Product product, int qty, String remark) onTap;
  @override
  State<ProductTransactionScreen> createState() =>
      _ProductTransactionScreenState();
}

class _ProductTransactionScreenState extends State<ProductTransactionScreen> {
  int qty = 0;
  bool validator = false;
  TextEditingController controllerRemark = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, true, []),
      body: ListView(
        children: [
          Column(children: [
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.close)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Quantity",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (qty > 0) {
                            setState(() {
                              qty = qty - 1;
                            });
                            if (qty == 0) {
                              setState(() {
                                validator = false;
                              });
                            }
                          }
                        },
                        child: Text(
                          "-",
                          style: TextStyle(fontSize: 20, color: halfGrey()),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        qty.toString(),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            validator = true;
                            qty = qty + 1;
                          });
                        },
                        child: Text(
                          "+",
                          style: TextStyle(
                            color: blue(),
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 80,
              width: screenWidth(context) * .8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Remark"),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: controllerRemark,
                        decoration: InputDecoration(border: InputBorder.none),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: screenWidth(context) * .65,
              height: screenHeight(context) * .2,
              decoration: BoxDecoration(
                  color: halfGrey(), border: Border.all(color: halfGrey())),
              child: widget.product.image.isEmpty
                  ? Icon(
                      Icons.settings_outlined,
                      size: 50,
                    )
                  : Image.network(
                      widget.product.image,
                      fit: BoxFit.fitWidth,
                    ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                if (qty != 0) {
                  widget.onTap(widget.product, qty, controllerRemark.text);
                  Navigator.pop(context);
                }
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                  decoration: BoxDecoration(
                      color: validator ? blue() : deepOcean().withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "Pinjam Alat",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  )),
            )
          ]),
        ],
      ),
    );
  }
}
