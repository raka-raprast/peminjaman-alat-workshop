// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:peminjaman_alat_workshop/style/colors.dart';

PreferredSizeWidget customAppBar(
    BuildContext context, bool canBack, List<Widget>? actions) {
  return AppBar(
    leading: canBack
        ? GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: blue(),
            ),
          )
        : null,
    centerTitle: true,
    title: Text(
      "PT KSB INDONESIA BRANCH BALIKPAPAN",
      style:
          TextStyle(color: blue(), fontWeight: FontWeight.w600, fontSize: 14),
    ),
    actions: actions,
    backgroundColor: pureWhite(),
    shadowColor: Colors.white,
  );
}
