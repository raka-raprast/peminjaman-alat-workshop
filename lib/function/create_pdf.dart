// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peminjaman_alat_workshop/model/cart.dart';
import 'package:peminjaman_alat_workshop/model/history.dart';
import 'package:peminjaman_alat_workshop/model/processed_cart.dart';
import 'package:peminjaman_alat_workshop/model/profile.dart';
import 'package:peminjaman_alat_workshop/screens/pdf_screen.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<void> createPDF(BuildContext context, List<ProcessedCart> carts,
    Profile profile, History history) async {
  DateTime time = DateTime.now();
  PdfDocument document = PdfDocument();

  document.pageSettings.size = Size(550, 530);
  document.pageSettings.margins.all = 0;
  final firstPage = document.pages.add();

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('lib/assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  var logo = await getImageFileFromAssets("logo_ksb.png");
  final logoBytes = logo.readAsBytesSync();
  firstPage.graphics.drawImage(
      PdfBitmap.fromBase64String(base64Encode(logoBytes)),
      Rect.fromLTRB(410, 10, 510, 50));
  if (carts.length > 27) {
    final sp = document.pages.add();
    sp.graphics.drawRectangle(
        pen: PdfPens.black, bounds: Rect.fromLTRB(5, 50, 525, 440));
    sp.graphics.drawLine(PdfPens.black, Offset(25, 50), Offset(25, 455));
    sp.graphics.drawLine(PdfPens.black, Offset(80, 50), Offset(80, 455));
    sp.graphics.drawLine(PdfPens.black, Offset(250, 50), Offset(250, 455));
    sp.graphics.drawLine(PdfPens.black, Offset(270, 50), Offset(270, 455));
    sp.graphics.drawLine(PdfPens.black, Offset(350, 50), Offset(350, 455));
    sp.graphics.drawLine(PdfPens.black, Offset(415, 50), Offset(415, 455));
    sp.graphics.drawLine(PdfPens.black, Offset(440, 50), Offset(440, 455));
    sp.graphics.drawString("DAILY WORKSHOP TOOLS CONTROL",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(175, 10, 0, 0));
    sp.graphics.drawString("No",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(10, 52.5, 0, 0));
    sp.graphics.drawString("DATE : ${time.day}-${time.month}-${time.year}",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(10, 22.5, 0, 0));
    sp.graphics.drawString("LOCATION : TOOL ROOM KSB BPN",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(10, 37.5, 0, 0));
    sp.graphics.drawString("PIC",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(45, 52.5, 0, 0));
    sp.graphics.drawString("Tools Description",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(125, 52.5, 0, 0));
    sp.graphics.drawString("Qty",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(252.5, 52.5, 0, 0));
    sp.graphics.drawString("Borrowed Time",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(280, 52.5, 0, 0));
    sp.graphics.drawString("Return Time",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(355, 52.5, 0, 0));

    sp.graphics.drawString("Sign",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(417.5, 52.5, 0, 0));
    sp.graphics.drawString("Remarks",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(470, 52.5, 0, 0));
    var no = 55;
    double noStart = 67.5;
    for (var i = 27; i < 54; i++) {
      if (i != 54) {
        no = no + 1;
        noStart = noStart + 15;
      }
      sp.graphics.drawString(no.toString(),
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          bounds: Rect.fromLTRB(10, noStart, 0, 0));
    }
    var borrowTime = DateTime.parse(history.borrowTime);
    var cartHeightStart = 67.5;
    for (var i = 0; i < carts.length; i++) {
      if (i != 0) {
        cartHeightStart = cartHeightStart + 15;
      }
      sp.graphics.drawString(profile.name,
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          bounds: Rect.fromLTRB(30, 67.5, 0, 0));
      sp.graphics.drawString(carts[i].name,
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          bounds: Rect.fromLTRB(85, cartHeightStart, 0, 0));
      sp.graphics.drawString(carts[i].qty.toString(),
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          bounds: Rect.fromLTRB(255, cartHeightStart, 0, 0));
      sp.graphics.drawString(
          "${borrowTime.day}-${borrowTime.month}-${borrowTime.year} ${borrowTime.hour}:${borrowTime.minute}",
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          bounds: Rect.fromLTRB(275, cartHeightStart, 0, 0));
      sp.graphics.drawString(carts[i].remark!,
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          bounds: Rect.fromLTRB(450, cartHeightStart, 0, 0));
      sp.graphics.drawString(
          "${time.day}-${time.month}-${time.year} ${time.hour}:${time.minute}",
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          bounds: Rect.fromLTRB(355, cartHeightStart, 0, 0));
    }
    double rowPage = 50;
    for (var i = 27; i < 54; i++) {
      if (i != 54) {
        rowPage = rowPage + 15;
      }
      sp.graphics.drawRectangle(
          pen: PdfPens.black,
          bounds: Rect.fromLTRB(5, rowPage, 525, rowPage + 15));
    }
  }
  if (carts.length > 81) {
    final sp = document.pages.add();
    sp.graphics.drawRectangle(
        pen: PdfPens.black, bounds: Rect.fromLTRB(5, 50, 525, 440));
    sp.graphics.drawLine(PdfPens.black, Offset(25, 50), Offset(25, 455));
    sp.graphics.drawLine(PdfPens.black, Offset(80, 50), Offset(80, 455));
    sp.graphics.drawLine(PdfPens.black, Offset(250, 50), Offset(250, 455));
    sp.graphics.drawLine(PdfPens.black, Offset(270, 50), Offset(270, 455));
    sp.graphics.drawLine(PdfPens.black, Offset(350, 50), Offset(350, 455));
    sp.graphics.drawLine(PdfPens.black, Offset(415, 50), Offset(415, 455));
    sp.graphics.drawLine(PdfPens.black, Offset(440, 50), Offset(440, 455));
    sp.graphics.drawString("DAILY WORKSHOP TOOLS CONTROL",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(175, 10, 0, 0));
    sp.graphics.drawString("No",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(10, 52.5, 0, 0));
    sp.graphics.drawString("DATE : ${time.day}-${time.month}-${time.year}",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(10, 22.5, 0, 0));
    sp.graphics.drawString("LOCATION : TOOL ROOM KSB BPN",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(10, 37.5, 0, 0));
    sp.graphics.drawString("PIC",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(45, 52.5, 0, 0));
    sp.graphics.drawString("Tools Description",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(125, 52.5, 0, 0));
    sp.graphics.drawString("Qty",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(252.5, 52.5, 0, 0));
    sp.graphics.drawString("Borrowed Time",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(280, 52.5, 0, 0));
    sp.graphics.drawString("Return Time",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(355, 52.5, 0, 0));

    sp.graphics.drawString("Sign",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(417.5, 52.5, 0, 0));
    sp.graphics.drawString("Remarks",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(470, 52.5, 0, 0));
    var no = 82;
    double noStart = 67.5;
    for (var i = 54; i < 81; i++) {
      if (i != 27) {
        no = no + 1;
        noStart = noStart + 15;
      }
      sp.graphics.drawString(no.toString(),
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          bounds: Rect.fromLTRB(10, noStart, 0, 0));
    }
    var borrowTime = DateTime.parse(history.borrowTime);
    var cartHeightStart = 67.5;
    for (var i = 54; i < carts.length; i++) {
      if (i != 54) {
        cartHeightStart = cartHeightStart + 15;
      }
      sp.graphics.drawString(profile.name,
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          bounds: Rect.fromLTRB(30, 67.5, 0, 0));
      sp.graphics.drawString(carts[i].name,
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          bounds: Rect.fromLTRB(85, cartHeightStart, 0, 0));
      sp.graphics.drawString(carts[i].qty.toString(),
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          bounds: Rect.fromLTRB(255, cartHeightStart, 0, 0));
      sp.graphics.drawString(
          "${borrowTime.day}-${borrowTime.month}-${borrowTime.year} ${borrowTime.hour}:${borrowTime.minute}",
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          bounds: Rect.fromLTRB(275, cartHeightStart, 0, 0));
      sp.graphics.drawString(carts[i].remark!,
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          bounds: Rect.fromLTRB(450, cartHeightStart, 0, 0));
      sp.graphics.drawString(
          "${time.day}-${time.month}-${time.year} ${time.hour}:${time.minute}",
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
          bounds: Rect.fromLTRB(355, cartHeightStart, 0, 0));
    }
    double rowPage = 50;
    for (var i = 54; i < 81; i++) {
      if (i != 54) {
        rowPage = rowPage + 15;
      }
      sp.graphics.drawRectangle(
          pen: PdfPens.black,
          bounds: Rect.fromLTRB(5, rowPage, 525, rowPage + 15));
    }
  }

  firstPage.graphics.drawRectangle(
      pen: PdfPens.black, bounds: Rect.fromLTRB(5, 50, 525, 440));
  firstPage.graphics.drawLine(PdfPens.black, Offset(25, 50), Offset(25, 455));
  firstPage.graphics.drawLine(PdfPens.black, Offset(80, 50), Offset(80, 455));
  firstPage.graphics.drawLine(PdfPens.black, Offset(250, 50), Offset(250, 455));
  firstPage.graphics.drawLine(PdfPens.black, Offset(270, 50), Offset(270, 455));
  firstPage.graphics.drawLine(PdfPens.black, Offset(350, 50), Offset(350, 455));
  firstPage.graphics.drawLine(PdfPens.black, Offset(415, 50), Offset(415, 455));
  firstPage.graphics.drawLine(PdfPens.black, Offset(440, 50), Offset(440, 455));
  firstPage.graphics.drawString("DAILY WORKSHOP TOOLS CONTROL",
      PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
      bounds: Rect.fromLTRB(175, 10, 0, 0));
  firstPage.graphics.drawString("No",
      PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
      bounds: Rect.fromLTRB(10, 52.5, 0, 0));
  firstPage.graphics.drawString("DATE : ${time.day}-${time.month}-${time.year}",
      PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
      bounds: Rect.fromLTRB(10, 22.5, 0, 0));
  firstPage.graphics.drawString("LOCATION : TOOL ROOM KSB BPN",
      PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
      bounds: Rect.fromLTRB(10, 37.5, 0, 0));
  firstPage.graphics.drawString("PIC",
      PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
      bounds: Rect.fromLTRB(45, 52.5, 0, 0));
  firstPage.graphics.drawString("Tools Description",
      PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
      bounds: Rect.fromLTRB(125, 52.5, 0, 0));
  firstPage.graphics.drawString("Qty",
      PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
      bounds: Rect.fromLTRB(252.5, 52.5, 0, 0));
  firstPage.graphics.drawString("Borrowed Time",
      PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
      bounds: Rect.fromLTRB(280, 52.5, 0, 0));
  firstPage.graphics.drawString("Return Time",
      PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
      bounds: Rect.fromLTRB(355, 52.5, 0, 0));

  firstPage.graphics.drawString("Sign",
      PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
      bounds: Rect.fromLTRB(417.5, 52.5, 0, 0));
  firstPage.graphics.drawString("Remarks",
      PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
      bounds: Rect.fromLTRB(470, 52.5, 0, 0));
  var no = 1;
  double noStart = 67.5;
  for (var i = 0; i < 26; i++) {
    if (i != 0) {
      no = no + 1;
      noStart = noStart + 15;
    }
    firstPage.graphics.drawString(no.toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(10, noStart, 0, 0));
  }
  var borrowTime = DateTime.parse(history.borrowTime);
  var cartHeightStart = 67.5;
  for (var i = 0; i < carts.length; i++) {
    if (i != 0) {
      cartHeightStart = cartHeightStart + 15;
    }
    firstPage.graphics.drawString(profile.name,
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(30, 67.5, 0, 0));
    firstPage.graphics.drawString(carts[i].name,
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(85, cartHeightStart, 0, 0));
    firstPage.graphics.drawString(carts[i].qty.toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(255, cartHeightStart, 0, 0));
    firstPage.graphics.drawString(
        "${borrowTime.day}-${borrowTime.month}-${borrowTime.year} ${borrowTime.hour}:${borrowTime.minute}",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(275, cartHeightStart, 0, 0));
    firstPage.graphics.drawString(carts[i].remark!,
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(450, cartHeightStart, 0, 0));
    firstPage.graphics.drawString(
        "${time.day}-${time.month}-${time.year} ${time.hour}:${time.minute}",
        PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold),
        bounds: Rect.fromLTRB(355, cartHeightStart, 0, 0));
  }
  double rowPage = 50;
  for (var i = 0; i < 27; i++) {
    if (i != 0) {
      rowPage = rowPage + 15;
    }
    firstPage.graphics.drawRectangle(
        pen: PdfPens.black,
        bounds: Rect.fromLTRB(5, rowPage, 525, rowPage + 15));
  }
  List<int> bytes = await document.save();

  // 26 row

  document.dispose();
  String fileName =
      "PAW_${time.day}${time.month}${time.year}${time.hour}${time.minute}.pdf";
  saveAndLaunchFile((path) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFScreen(
          history: history,
          name: fileName,
          path: path,
          document: document,
          bytes: bytes,
        ),
      ),
    );
  }, bytes, fileName);
}
