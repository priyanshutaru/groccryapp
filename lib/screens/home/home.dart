// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groccryapp/constants/routes.dart';

import 'package:groccryapp/firebase_helper/firebase_firestore.dart';
import 'package:groccryapp/models/category_model.dart';
import 'package:groccryapp/models/products_model.dart';
import 'package:groccryapp/provider/app_provider.dart';
import 'package:groccryapp/screens/category_view/category_view.dart';
import 'package:groccryapp/screens/product_details/product_details.dart';
import 'package:groccryapp/widgets/welcomepage/toptext.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categoryList = [];
  List<ProductModel> bestproductsList = [];

  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    categoryList = await FirebaseFirestoreHelper.instance.getCategories();
    bestproductsList = await FirebaseFirestoreHelper.instance.getBestProducts();
    bestproductsList.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];
  void searchProducts(String value) {
    searchList = bestproductsList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const WelcomeTitle(subtitle: "", title: "E Commerce"),
                        TextFormField(
                          controller: search,
                          onChanged: (String value) {
                            searchProducts(value);
                          },
                          decoration:
                              const InputDecoration(hintText: "Search...."),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        const Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  categoryList.isEmpty
                      ? const Center(
                          child: Text("Categories is empty"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoryList
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Routes.instance.push(
                                            widget:
                                                CategoryView(categoryModel: e),
                                            context: context);
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 3.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(e.image),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  !isSearched()
                      ? const Padding(
                          padding: EdgeInsets.only(top: 12.0, left: 12.0),
                          child: Text(
                            "Best Products",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : SizedBox.fromSize(),
                  const SizedBox(
                    height: 12.0,
                  ),
                  search.text.isNotEmpty && searchList.isEmpty
                      ? const Center(
                          child: Text("No Product Found"),
                        )
                      : searchList.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GridView.builder(
                                  padding: const EdgeInsets.only(bottom: 50),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: searchList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 20,
                                          crossAxisSpacing: 20,
                                          childAspectRatio: 0.7,
                                          crossAxisCount: 2),
                                  itemBuilder: (ctx, index) {
                                    ProductModel singleProduct =
                                        searchList[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 12.0,
                                          ),
                                          Image.network(
                                            singleProduct.image,
                                            height: 100,
                                            width: 100,
                                          ),
                                          const SizedBox(
                                            height: 12.0,
                                          ),
                                          Text(
                                            singleProduct.name,
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                              "Price: \$${singleProduct.price}"),
                                          const SizedBox(
                                            height: 30.0,
                                          ),
                                          SizedBox(
                                            height: 45,
                                            width: 140,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                Routes.instance.push(
                                                    widget: ProductsDeatials(
                                                        singleProduct:
                                                            singleProduct),
                                                    context: context);
                                              },
                                              child: const Text(
                                                "Buy",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          : bestproductsList.isEmpty
                              ? const Center(
                                  child: Text("Best Product is empty"),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GridView.builder(
                                      padding:
                                          const EdgeInsets.only(bottom: 50),
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: bestproductsList.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 20,
                                              crossAxisSpacing: 20,
                                              childAspectRatio: 0.7,
                                              crossAxisCount: 2),
                                      itemBuilder: (ctx, index) {
                                        ProductModel singleProduct =
                                            bestproductsList[index];
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Image.network(
                                                singleProduct.image,
                                                height: 100,
                                                width: 100,
                                              ),
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Text(
                                                singleProduct.name,
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                  "Price: \$${singleProduct.price}"),
                                              const SizedBox(
                                                height: 30.0,
                                              ),
                                              SizedBox(
                                                height: 45,
                                                width: 140,
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    Routes.instance.push(
                                                        widget: ProductsDeatials(
                                                            singleProduct:
                                                                singleProduct),
                                                        context: context);
                                                  },
                                                  child: const Text(
                                                    "Buy",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
    );

    // return Scaffold(
    //   // appBar: AppBar(),
    //   body: isLoading
    //       ? Center(
    //           child: Container(
    //           height: 100,
    //           width: 100,
    //           alignment: Alignment.center,
    //           child: CircularProgressIndicator(),
    //         ))
    //       : Padding(
    //           padding: const EdgeInsets.all(12.0),
    //           child: SingleChildScrollView(
    //             scrollDirection: Axis.vertical,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 SizedBox(
    //                   height: kToolbarHeight + 12,
    //                 ),
    //                 WelcomeTitle(title: "E Commerce ", subtitle: ""),
    //                 TextField(
    //                   decoration: InputDecoration(
    //                       focusedBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(10),
    //                         ),
    //                       ),
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(10),
    //                         ),
    //                       ),
    //                       prefixIcon: Icon(
    //                         Icons.search,
    //                         color: Colors.grey,
    //                       ),
    //                       hintText: "Search your item here....."),
    //                 ),
    //                 WelcomeTitle(title: "", subtitle: "Category"),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 categoryList.isEmpty
    //                     ? Center(child: Text("List is Empty"))
    //                     : SingleChildScrollView(
    //                         scrollDirection: Axis.horizontal,
    //                         child: Row(
    //                           children: categoryList
    //                               .map(
    //                                 (e) => GestureDetector(
    //                                   onTap: () {
    //                                     Routes.instance.push(
    //                                         widget: CategoryView(
    //                                           categoryModel: e,
    //                                         ),
    //                                         context: context);
    //                                   },
    //                                   child: Card(
    //                                     elevation: 10,
    //                                     child: Container(
    //                                       height: 80,
    //                                       width: 80,
    //                                       decoration: BoxDecoration(
    //                                         borderRadius:
    //                                             BorderRadius.circular(30),
    //                                         color: Colors.grey,
    //                                       ),
    //                                       child: Image.network(
    //                                         e.image,
    //                                         fit: BoxFit.fill,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               )
    //                               .toList(),
    //                         ),
    //                       ),
    //                 WelcomeTitle(title: "", subtitle: " Best Products"),
    //                 bestproductsList.isEmpty
    //                     ? Text("List is Empty")
    //                     : GridView.builder(
    //                         padding: EdgeInsets.only(bottom: 70),
    //                         itemCount: bestproductsList.length,
    //                         shrinkWrap: true,
    //                         primary: false,
    //                         gridDelegate:
    //                             SliverGridDelegateWithFixedCrossAxisCount(
    //                           crossAxisCount: 2,
    //                           mainAxisSpacing: 20,
    //                           crossAxisSpacing: 20,
    //                           childAspectRatio: 0.7,
    //                         ),
    //                         itemBuilder: (BuildContext context, int index) {
    //                           ProductModel singleProduct =
    //                               bestproductsList[index];
    //                           return Container(
    //                             height: 100,
    //                             width: 100,
    //                             decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.only(
    //                                 topLeft: Radius.circular(20),
    //                                 bottomRight: Radius.circular(20),
    //                               ),
    //                               color: Colors.red.withOpacity(.5),
    //                             ),
    //                             child: Column(
    //                               children: [
    //                                 SizedBox(
    //                                   height: 20,
    //                                 ),
    //                                 Image.network(
    //                                   singleProduct.image,
    //                                   height: 100,
    //                                   width: 100,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 20,
    //                                 ),
    //                                 Text(singleProduct.name),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceAround,
    //                                   children: [
    //                                     Text("Price"),
    //                                     Text("RS ${singleProduct.price}"),
    //                                   ],
    //                                 ),
    //                                 Container(
    //                                   width: 120,
    //                                   child: OutlinedButton(
    //                                     style: OutlinedButton.styleFrom(
    //                                       side: BorderSide(color: Colors.black),
    //                                     ),
    //                                     onPressed: () {
    //                                       Routes.instance.push(
    //                                           widget: ProductsDeatials(
    //                                             singleProduct: singleProduct,
    //                                           ),
    //                                           context: context);
    //                                     },
    //                                     child: Text(
    //                                       "Buy",
    //                                       style: TextStyle(color: Colors.black),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           );
    //                         },
    //                       ),
    //               ],
    //             ),
    //           ),
    //         ),
    // );
  }

  bool isSearched() {
    if (search.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (search.text.isEmpty && searchList.isNotEmpty) {
      return false;
    } else if (searchList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

// List<String> categaroyList = [
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
//   // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4LnmXwyPH1kgVq1qVrdELjQFpSwOldBdtpA",
//   // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd6Be_eu1ChKiiq4Fb76x44wVpaxSyPpclLQ",
//   // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgTyy_wx14b59N4sM6g7N8_L5XO-thX0A6ZA",
//   // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2r8eRpNS-WzNa1rJylvAaJ7G8Rzps0fgXbA",
// ];

// List<ProductModel> bestProducts = [
//   ProductModel(
//     image:
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
//     id: "1",
//     name: "aalu",
//     price: 5,
//     description: "This is aalu",
//     isFavourite: false,
//   ),
//   ProductModel(
//     image:
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
//     id: "2",
//     name: "kalu",
//     price: 10,
//     description: "This is kalu",
//     isFavourite: true,
//   ),
//   ProductModel(
//     image:
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
//     id: "3",
//     name: "malu",
//     price: 15,
//     description: "This is malu",
//     isFavourite: false,
//   ),
//   ProductModel(
//     image:
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9xoMNqeduGtf-jCB9OQ2HpW_gCa80HTSiGE3iRUshajEnFLLaxjxufrRWN6L09BMs9_Q",
//     id: "4",
//     name: "bhalu",
//     price: 20,
//     description: "This is bhalu",
//     isFavourite: true,
//   ),
// ];
