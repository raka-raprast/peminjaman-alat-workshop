// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peminjaman_alat_workshop/bloc/cart_hydrated_bloc.dart';
import 'package:peminjaman_alat_workshop/bloc/history_hydrated_bloc.dart';
import 'package:peminjaman_alat_workshop/bloc/processed_cart_hydrated_bloc.dart';
import 'package:peminjaman_alat_workshop/bloc/profile_hydrated_bloc.dart';
import 'package:peminjaman_alat_workshop/model/product.dart';
import 'package:peminjaman_alat_workshop/screens/home_screen.dart';
import 'package:peminjaman_alat_workshop/screens/main_scaffold.dart';
import 'package:peminjaman_alat_workshop/screens/product_transaction_screen.dart';
import 'package:peminjaman_alat_workshop/screens/sign_in_screen.dart';
import 'package:peminjaman_alat_workshop/style/colors.dart';
import 'package:peminjaman_alat_workshop/widget/custom_appbar.dart';
import 'package:peminjaman_alat_workshop/widget/product_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  HydratedBlocOverrides.runZoned(
    () => runApp(PeminjamanAlatWorkshop()),
    storage: storage,
  );
}

class PeminjamanAlatWorkshop extends StatelessWidget {
  const PeminjamanAlatWorkshop({Key? key}) : super(key: key);

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
        child: MaterialApp(
          title: 'Peminjaman Alat Workshop',
          home: BlocBuilder<ProfileHydratedBloc, ProfileState>(
            builder: (context, stateP) {
              if (stateP.profile.isNotEmpty) {
                return BlocBuilder<CartHydratedBloc, CartState>(
                    builder: (context, stateC) {
                  return BlocBuilder<ProcessedCartHydratedBloc,
                      ProcessedCartState>(builder: (context, statePC) {
                    return BlocBuilder<HistoryHydratedBloc, HistoryState>(
                        builder: (context, stateH) {
                      return MainScaffold(
                        profile: stateP.profile.first,
                        processedList: statePC.processedCart.isNotEmpty
                            ? statePC.processedCart
                            : [],
                        cartList: stateC.cart.isNotEmpty ? stateC.cart : [],
                        historyList:
                            stateH.history.isNotEmpty ? stateH.history : [],
                      );
                    });
                  });
                });
              }
              return SignInScreen();
            },
          ),
        ));
  }
}
