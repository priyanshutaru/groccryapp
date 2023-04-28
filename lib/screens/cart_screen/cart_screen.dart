// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groccryapp/provider/app_provider.dart';
import 'package:groccryapp/screens/cart_screen/widget/singlecart_item.dart';
import 'package:provider/provider.dart';

class AddToCardScreen extends StatefulWidget {
  const AddToCardScreen({super.key});

  @override
  State<AddToCardScreen> createState() => _AddToCardScreenState();
}

class _AddToCardScreenState extends State<AddToCardScreen> {
  // var qty = 0;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: appProvider.getCartProductList.isEmpty
          ? Center(
              child: Text(
                "Cart is Empty",
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            )
          : ListView.builder(
              itemCount: appProvider.getCartProductList.length,
              itemBuilder: (context, index) {
                return SignleCartItem(
                  singleProduct: appProvider.getCartProductList[index],
                );
              },
            ),
    );
  }
}
