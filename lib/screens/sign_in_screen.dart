// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peminjaman_alat_workshop/bloc/profile_hydrated_bloc.dart';
import 'package:peminjaman_alat_workshop/screens/main_scaffold.dart';
import 'package:peminjaman_alat_workshop/style/colors.dart';

import '../model/profile.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController id = TextEditingController();
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileHydratedBloc>(
      create: (_) => ProfileHydratedBloc(),
      child: BlocBuilder<ProfileHydratedBloc, ProfileState>(
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text("Name"),
                ),
                Container(
                    height: 45,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      controller: username,
                      decoration: InputDecoration(border: InputBorder.none),
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text("Id"),
                ),
                Container(
                    height: 45,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      controller: id,
                      decoration: InputDecoration(border: InputBorder.none),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: check,
                            onChanged: (v) {
                              setState(() {
                                check = !check;
                              });
                            },
                            checkColor: Colors.black,
                            activeColor: deepOcean(),
                          ),
                          Text(
                            "Remember me",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    if (username.text.isNotEmpty && id.text.isNotEmpty) {
                      if (check) {
                        BlocProvider.of<ProfileHydratedBloc>(context).add(
                            ProfileAddEvent(
                                Profile(name: username.text, id: id.text)));
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScaffold(
                                  profile: Profile(
                                      name: username.text, id: id.text))));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: deepOcean(),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Text(
                        "Log In",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
