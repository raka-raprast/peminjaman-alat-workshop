// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:peminjaman_alat_workshop/model/product.dart';
import 'package:peminjaman_alat_workshop/style/colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product, required this.onTap})
      : super(key: key);
  final Product product;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: halfGrey().withOpacity(.5)),
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 140,
                  height: 140,
                  color: halfGrey(),
                  child: product.image.isEmpty
                      ? Icon(
                          Icons.settings_outlined,
                          size: 50,
                        )
                      : Image.network(product.image),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                product.name,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              Text(
                product.brand,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pinjam Alat",
                    style: TextStyle(color: blue()),
                  ),
                  Icon(
                    Icons.more_vert,
                    color: Colors.black45,
                  )
                ],
              )
            ]),
      ),
    );
  }
}
