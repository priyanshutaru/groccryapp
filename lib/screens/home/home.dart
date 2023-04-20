// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:groccryapp/models/products_model.dart';
import 'package:groccryapp/widgets/welcomepage/toptext.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kToolbarHeight + 12,
              ),
              WelcomeTitle(title: "E Commerce ", subtitle: ""),
              TextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: "Search your item here....."),
              ),
              WelcomeTitle(title: "", subtitle: "Category"),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categaroyList
                      .map(
                        (image) => Container(
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey,
                              ),
                              child: Image.network(image),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              WelcomeTitle(title: "", subtitle: "Trending Products"),
              GridView.builder(
                itemCount: bestProducts.length,
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (BuildContext context, int index) {
                  ProductModel singleProduct = bestProducts[index];
                  return Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: Colors.red.withOpacity(.5),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Image.network(
                          singleProduct.image,
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(singleProduct.name),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Price"),
                            Text("RS ${singleProduct.price}"),
                          ],
                        ),
                        Container(
                          width: 120,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.black),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Buy",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> categaroyList = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
  // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4LnmXwyPH1kgVq1qVrdELjQFpSwOldBdtpA",
  // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd6Be_eu1ChKiiq4Fb76x44wVpaxSyPpclLQ",
  // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgTyy_wx14b59N4sM6g7N8_L5XO-thX0A6ZA",
  // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2r8eRpNS-WzNa1rJylvAaJ7G8Rzps0fgXbA",
];

List<ProductModel> bestProducts = [
  ProductModel(
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
    id: "1",
    name: "aalu",
    price: 5,
    description: "This is aalu",
    isFavourite: false,
  ),
  ProductModel(
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
    id: "2",
    name: "kalu",
    price: 10,
    description: "This is kalu",
    isFavourite: true,
  ),
  ProductModel(
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
    id: "3",
    name: "malu",
    price: 15,
    description: "This is malu",
    isFavourite: false,
  ),
  ProductModel(
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
    id: "4",
    name: "bhalu",
    price: 20,
    description: "This is bhalu",
    isFavourite: true,
  ),
];
