import 'dart:convert';

import 'package:e_commerce/constants.dart';
import 'package:e_commerce/pages/chackout_page.dart';
import 'package:e_commerce/repository/card_service.dart';
import 'package:e_commerce/repository/model.dart';
import 'package:e_commerce/widgets/Product_card_category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  // List products = [];
  // List cart = [];
  // int count = 0;
  //int a = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CartService _cartService = CartService();
  List<Products> _prodcts = List<Products>();
  List<Products> _cardItems;

  @override
  void initState() {
    this.fetchData();
    _getCardItems();
    super.initState();
  }

  _getCardItems() async {
    _cardItems = List<Products>();
    var cartItems = await _cartService.getCartItems();
    cartItems.forEach((data) {
      var product = Products();
      product.id = data['productId'];
      product.image = data['productPhoto'];
      product.name = data['productName'];
      product.price = data['productPrice'];
      product.quantity = data['productQuantity'];
      setState(() {
        _cardItems.add(product);
      });
    });
  }

  void fetchData() async {
    var url = "https://antopolis.tech/task-assets/ecom/ecom.json";
    var res = await http.get(url);
    var result = json.decode(res.body);
    print("+++++++++++++++++++++");
    print(result);
    print("+++++++++++++++++++++");
    result['data'].forEach((data) {
      var model = Products();
      model.id = data['id'];
      model.name = data['name'];
      model.price = data['price'];
      model.image = data['photo'];
      setState(() {
        _prodcts.add(model);
      });
    });
  }

  _addToCart(BuildContext context, Products product) async {
    var result = await _cartService.addToCart(product);
    String name = product.name;
    print(name);
    if (result > 0) {
      _showSnackMessage(Text(
        '$name added to cart successfully!',
        style: TextStyle(color: Colors.green),
      ));
    } else {
      _showSnackMessage(Text(
        'Failed to add to cart!',
        style: TextStyle(color: Colors.red),
      ));
    }
  }

  _showSnackMessage(message) {
    var snackBar = SnackBar(
      content: message,
      duration: Duration(seconds: 2),
    );
    _scaffoldKey.currentState.showSnackBar(
      snackBar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: eButtonColor,
        leading: Icon(Icons.sort, color: eBlackColor),
        title: Center(
          child: Text(
            'PRODUCTS',
            style: TextStyle(color: eBlackColor, fontWeight: FontWeight.w400),
          ),
        ),
        actions: [
          Container(
            height: 150,
            width: 50,
            child: Stack(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: eBlackColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CheckoutPage(
                            cardItems: _cardItems,
                          );
                        }),
                      );
                    }),
                Positioned(
                  left: 5.0,
                  top: 5.0,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                    child: Center(
                      child: Text(
                        _cardItems.length.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: _prodcts.isNotEmpty
              ? GridView.builder(
                  itemCount: _prodcts.length,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(children: [
                      ProductCard(
                        image: _prodcts[index].image,
                        name: _prodcts[index].name,
                        price: _prodcts[index].price,
                        id: _prodcts[index].id,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconButton(
                          onPressed: () {
                            _addToCart(context, _prodcts[index]);

                            // String name = _prodcts[index].name;
                            // print(name);
                            print('add to sqflite');
                          },
                          icon: Icon(Icons.shopping_bag_outlined),
                        ),
                      ),
                    ]);
                  },
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

//   Widget getCard(item) {
//     var name = item;
//     var price = item["price"];
//     String img = item["photo"];
//     return Padding(
//       padding: const EdgeInsets.all(0.0),
//       child: Card(
//         child: FlatButton(
//           onPressed: () {
//             cart.add({
//               'name': name,
//               'price': price,
//               'img': img,
//             });
//           },
//           child: Stack(
//             children: [
//               Positioned(
//                 bottom: 10,
//                 right: 10,
//                 child: Container(
//                   height: 20,
//                   width: 20,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: NetworkImage(img),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                       name.toString(),
//                       style: TextStyle(color: Colors.grey, fontSize: 16),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                       '\$ $price',
//                       style: TextStyle(color: eButtonColor, fontSize: 16),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                       '****',
//                       style: TextStyle(color: eButtonColor, fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
}
