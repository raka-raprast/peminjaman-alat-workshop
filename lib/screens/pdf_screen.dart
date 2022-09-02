// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:peminjaman_alat_workshop/bloc/cart_hydrated_bloc.dart';
import 'package:peminjaman_alat_workshop/bloc/history_hydrated_bloc.dart';
import 'package:peminjaman_alat_workshop/bloc/processed_cart_hydrated_bloc.dart';
import 'package:peminjaman_alat_workshop/bloc/profile_hydrated_bloc.dart';
import 'package:peminjaman_alat_workshop/model/history.dart';
import 'package:peminjaman_alat_workshop/screens/main_scaffold.dart';
import 'package:peminjaman_alat_workshop/style/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<void> saveAndLaunchFile(
    Function(String path) onLaunch, List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())!.path;

  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  onLaunch('$path/$fileName');
}

// ignore_for_file: avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, avoid_print

class PDFScreen extends StatefulWidget {
  final String? path;
  final String name;
  final PdfDocument document;
  final List<int> bytes;
  final History history;
  const PDFScreen(
      {Key? key,
      this.path,
      required this.document,
      required this.bytes,
      required this.name,
      required this.history})
      : super(key: key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  Future<void> downloadFile(PdfDocument document, List<int> bytes) async {
    const path = "/storage/emulated/0/Download";
    String fileName = widget.name;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
  }

  Future<void> shareFile(PdfDocument document, List<int> bytes) async {
    final path = (await getExternalStorageDirectory())!.path;

    final file = File('$path/${widget.name}');
    List<String>? files = [file.path];
    await Share.shareFiles(files);
  }

  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProfileHydratedBloc>(
              create: (_) => ProfileHydratedBloc()..add(ProfileCheckEvent())),
          BlocProvider<CartHydratedBloc>(
              create: (_) => CartHydratedBloc()..add(CartCheckEvent())),
          BlocProvider<ProcessedCartHydratedBloc>(
              create: (_) =>
                  ProcessedCartHydratedBloc()..add(ProcessedCartCheckEvent())),
          BlocProvider<HistoryHydratedBloc>(
              create: (_) => HistoryHydratedBloc()..add(HistoryCheckEvent()))
        ],
        child: Scaffold(
            backgroundColor: Colors.red,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .65,
                        child: PDFView(
                          filePath: widget.path,
                          onRender: (_pages) {
                            setState(() {
                              pages = _pages;
                              isReady = true;
                            });
                          },
                          onError: (error) {
                            setState(() {
                              errorMessage = error.toString();
                            });
                            print(error.toString());
                          },
                          onPageError: (page, error) {
                            setState(() {
                              errorMessage = '$page: ${error.toString()}';
                            });
                            print('$page: ${error.toString()}');
                          },
                          onViewCreated: (PDFViewController pdfViewController) {
                            _controller.complete(pdfViewController);
                          },
                        ),
                      ),
                      errorMessage.isEmpty
                          ? !isReady
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container()
                          : Center(
                              child: Text(errorMessage),
                            )
                    ],
                  ),
                ),
                OutlinedButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200,
                            color: lightBlue(),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      var status = Permission.storage.status;
                                      bool isGranted = await status.isGranted;
                                      if (isGranted) {
                                        downloadFile(
                                            widget.document, widget.bytes);
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            backgroundColor: lightBlue(),
                                            title: Text(
                                                'Pdf Telah di Download sebagai ${widget.name}'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Ok'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        Permission.storage.request();
                                      }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.all(30),
                                        padding: EdgeInsets.all(30),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: lightBlue()),
                                        child: Icon(
                                          Icons.download,
                                          size: 50,
                                          color: Colors.white,
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      shareFile(widget.document, widget.bytes);
                                    },
                                    child: Container(
                                        margin: EdgeInsets.all(30),
                                        padding: EdgeInsets.all(30),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: lightBlue()),
                                        child: Icon(
                                          Icons.share,
                                          size: 50,
                                          color: Colors.white,
                                        )),
                                  ),
                                ]),
                          );
                        },
                      );
                    },
                    child: Text(
                      "Share",
                      style: TextStyle(color: Colors.white),
                    )),
                BlocBuilder<ProfileHydratedBloc, ProfileState>(
                  builder: (context, stateProfile) {
                    BlocProvider.of<HistoryHydratedBloc>(context)
                        .add(HistoryUpdateEvent(widget.history));
                    return BlocBuilder<CartHydratedBloc, CartState>(
                      builder: ((context, stateC) {
                        return BlocBuilder<ProcessedCartHydratedBloc,
                            ProcessedCartState>(builder: (context, statePC) {
                          return BlocBuilder<HistoryHydratedBloc, HistoryState>(
                              builder: (context, stateH) {
                            return OutlinedButton(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text(
                                          'Back to the main screen?'),
                                      content: const Text(
                                          'Please make sure you have finished before going back'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MainScaffold(
                                                            profile:
                                                                stateProfile
                                                                    .profile
                                                                    .first,
                                                            cartList:
                                                                stateC.cart,
                                                            processedList: statePC
                                                                .processedCart,
                                                            historyList:
                                                                stateH.history,
                                                          ))),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Text(
                                  "Done",
                                  style: TextStyle(color: Colors.white),
                                ));
                          });
                        });
                      }),
                    );
                  },
                ),
              ],
            )));
  }
}
