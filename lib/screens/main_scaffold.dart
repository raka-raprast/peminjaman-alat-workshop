// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peminjaman_alat_workshop/bloc/cart_hydrated_bloc.dart';
import 'package:peminjaman_alat_workshop/bloc/history_hydrated_bloc.dart';
import 'package:peminjaman_alat_workshop/bloc/processed_cart_hydrated_bloc.dart';
import 'package:peminjaman_alat_workshop/data/data.dart';
import 'package:peminjaman_alat_workshop/data/fake_data.dart';
import 'package:peminjaman_alat_workshop/function/create_pdf.dart';
import 'package:peminjaman_alat_workshop/model/history.dart';
import 'package:peminjaman_alat_workshop/model/processed_cart.dart';
import 'package:peminjaman_alat_workshop/model/product.dart';
import 'package:peminjaman_alat_workshop/screens/history_screen.dart';
import 'package:peminjaman_alat_workshop/screens/home_screen.dart';
import 'package:peminjaman_alat_workshop/screens/order_screen.dart';
import 'package:peminjaman_alat_workshop/style/colors.dart';

import '../model/cart.dart';
import '../model/profile.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({
    Key? key,
    this.profile,
    this.cartList,
    this.processedList,
    this.historyList,
  }) : super(key: key);
  final Profile? profile;
  final List<Cart>? cartList;
  final List<ProcessedCart>? processedList;
  final List<History>? historyList;
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Cart> cart = [];
  List<History> history = [];
  List<ProcessedCart> processedCart = [];
  @override
  void initState() {
    setState(() {
      if (widget.cartList != null) {
        cart = widget.cartList!;
      }
      if (widget.historyList != null) {
        history = widget.historyList!;
      }
      if (widget.processedList != null) {
        processedCart = widget.processedList!;
      }
    });
    super.initState();
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<CartHydratedBloc>(
                create: (_) => CartHydratedBloc()..add(CartCheckEvent()))
          ],
          child: BlocBuilder<CartHydratedBloc, CartState>(
              builder: (context, stateC) {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                unselectedFontSize: 15,
                selectedFontSize: 15,
                showUnselectedLabels: true,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "lib/assets/ic_menu_home.png",
                      color: _selectedIndex == 0 ? blue() : Colors.black,
                    ),
                    label: 'HOME',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "lib/assets/ic_menu_bag.png",
                      color: _selectedIndex == 1 ? blue() : Colors.black,
                    ),
                    label: 'ORDER',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "lib/assets/history.png",
                      color: _selectedIndex == 2 ? blue() : Colors.black,
                    ),
                    label: 'HISTORY',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: blue(),
                unselectedItemColor: Colors.black,
                selectedLabelStyle:
                    TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                unselectedLabelStyle:
                    TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                onTap: _onItemTapped,
              ),
              body: _selectedIndex == 0
                  ? HomeScreen(
                      products: data,
                      onTap: (item, qty, remark) {
                        cart.add(Cart(
                            name: item.name,
                            image: item.image,
                            qty: qty,
                            remark: remark));

                        BlocProvider.of<CartHydratedBloc>(context)
                            .add(CartAddEvent(cart));
                      },
                    )
                  : _selectedIndex == 1
                      ? OrderScreen(
                          listCart: stateC.cart,
                          onTap: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Checkout'),
                                content: const Text(
                                    'You are about to make an order. Please check again before making an order'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      var dateTime = DateTime.now();
                                      var uid = dateTime.millisecondsSinceEpoch;
                                      List<int> listQty = [];
                                      cart.forEach((element) {
                                        listQty.add(element.qty);
                                      });
                                      int totalQty = 0;
                                      for (int e in listQty) {
                                        totalQty += e;
                                      }
                                      processedCart.addAll(cart.map((e) =>
                                          ProcessedCart(
                                              name: e.name,
                                              image: e.image,
                                              qty: e.qty,
                                              remark: e.remark,
                                              id: uid.toString())));
                                      history.add(History(
                                          borrowTime: dateTime.toString(),
                                          status: "Borrowed",
                                          borrowedItemQty: totalQty,
                                          id: uid.toString()));
                                      log(dateTime.toString());
                                      BlocProvider.of<
                                                  ProcessedCartHydratedBloc>(
                                              context)
                                          .add(ProcessedCartAddEvent(
                                              processedCart));
                                      BlocProvider.of<HistoryHydratedBloc>(
                                              context)
                                          .add(HistoryAddEvent(history));
                                      BlocProvider.of<CartHydratedBloc>(context)
                                          .add(CartClearEvent());
                                      cart.clear();
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : HistoryScreen(
                          processedCart: processedCart,
                          histories: history,
                          profile: widget.profile!,
                        ),
            );
          }),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
