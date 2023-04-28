// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groccryapp/constants/constants.dart';
import 'package:groccryapp/constants/routes.dart';
import 'package:groccryapp/models/products_model.dart';
import 'package:groccryapp/provider/app_provider.dart';
import 'package:groccryapp/screens/cart_screen/cart_screen.dart';
import 'package:groccryapp/screens/fav_screen/fav_screen.dart';
import 'package:provider/provider.dart';

class ProductsDeatials extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductsDeatials({super.key, required this.singleProduct});

  @override
  State<ProductsDeatials> createState() => _ProductsDeatialsState();
}

class _ProductsDeatialsState extends State<ProductsDeatials> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        //iconTheme: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance.push(widget: AddToCardScreen(), context: context);
            },
            icon: Icon(
              Icons.shopping_cart,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Image.network(
              widget.singleProduct.image.toString(),
              height: 300,
              width: 300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.singleProduct.name),
                IconButton(
                  onPressed: () {
                    setState(
                      () {
                        widget.singleProduct.isFavourite =
                            !widget.singleProduct.isFavourite;
                      },
                    );
                    if (widget.singleProduct.isFavourite) {
                      appProvider.addFavouriteProduct(widget.singleProduct);
                    } else {
                      appProvider.removeFavouriteProduct(widget.singleProduct);
                    }
                  },
                  icon: Icon(
                    appProvider.getFavouriteProductList
                            .contains(widget.singleProduct)
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                ),
              ],
            ),
            Text(widget.singleProduct.description),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                CupertinoButton(
                  onPressed: () {
                    setState(() {
                      if (qty >= 2) {
                        qty--;
                      }
                    });
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.remove),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  qty.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                CupertinoButton(
                  onPressed: () {
                    setState(() {
                      qty++;
                    });
                  },
                  child: CircleAvatar(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 45,
                  width: 150,
                  child: OutlinedButton(
                    onPressed: () {
                      ProductModel productModel =
                          widget.singleProduct.copyWith(qty: qty);
                      appProvider.addCartProduct(productModel);
                      toastMessage("Item Added");
                    },
                    child: Text(
                      "Add To Cart",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                    height: 45,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Routes.instance
                            .push(widget: FavScreen(), context: context);
                      },
                      child: Text("Buy"),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
