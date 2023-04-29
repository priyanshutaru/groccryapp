// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groccryapp/provider/app_provider.dart';
import 'package:groccryapp/screens/cart_screen/widget/singlecart_item.dart';
import 'package:groccryapp/screens/fav_screen/widget/singlefav_item.dart';
import 'package:provider/provider.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  // var qty = 0;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("My Fav Item"),
      ),
      body: appProvider.getFavouriteProductList.isEmpty
          ? Center(
              child: Text(
                "List Is Empty",
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            )
          : ListView.builder(
              itemCount: appProvider.getFavouriteProductList.length,
              itemBuilder: (context, index) {
                return SingleFavItem(
                  singleProduct: appProvider.getFavouriteProductList[index],
                );
              },
            ),
    );
  }
}
