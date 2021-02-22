import 'package:e_commerce/repository/card_service.dart';
import 'package:e_commerce/repository/model.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CheckoutPage extends StatefulWidget {
  final List<Products> cardItems;

  CheckoutPage({@required this.cardItems});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CartService cartService = CartService();
  int total;

  int totalPrice() {
    total = 0;

    widget.cardItems.forEach((product) {
      setState(() {
        total += (product.price) * (product.quantity);
      });
    });
    return total;
  }

  double fontSize = 10;

  @override
    void initState() {
      
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: eButtonColor,
        leading: Icon(Icons.sort, color: eBlackColor),
        title: Center(
          child: Text(
            'CHECKOUT',
            style: TextStyle(color: eBlackColor, fontWeight: FontWeight.w400),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings_input_composite_outlined,
                color: eBlackColor,
              ),
              onPressed: () {
                this.widget.cardItems.forEach((item) {});
              })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: this.widget.cardItems.isNotEmpty ? Container(
              child: ListView.builder(
                  itemCount: this.widget.cardItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    // print(widget.);
                    return Dismissible(
                      key: Key(this.widget.cardItems[index].id.toString()),
                      onDismissed: (param) {
                        _deleteCartItem(index, this.widget.cardItems[index].id);
                      },
                      background: Container(
                        color: Colors.redAccent,
                      ),
                      child: Card(
                        // color: eBackgroundColor,
                        child: Container(
                          //height: 80,
                          decoration: BoxDecoration(color: eWhiteColor),
                          child: ListTile(
                            leading: Container(
                              width: 100,
                              child: Image(
                                  image: NetworkImage(
                                      this.widget.cardItems[index].image),
                                  fit: BoxFit.cover),
                            ),
                            title: Text(
                              this.widget.cardItems[index].name,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  '\$ ${this.widget.cardItems[index].price}',
                                  style: TextStyle(
                                      color: eButtonColor, fontSize: fontSize),
                                ),
                                Text(
                                  ' x',
                                  style: TextStyle(
                                      color: eButtonColor, fontSize: 10),
                                ),
                                Text(
                                  ' ${this.widget.cardItems[index].quantity}',
                                  style: TextStyle(
                                      color: eButtonColor, fontSize: fontSize),
                                ),
                                Text(
                                  '=',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  '\$ ${(this.widget.cardItems[index].price) * (this.widget.cardItems[index].quantity)}',
                                  style: TextStyle(
                                      color: eButtonColor, fontSize: fontSize),
                                ),
                              ],
                            ),
                            trailing: Column(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        total +=
                                            this.widget.cardItems[index].price;
                                        this.widget.cardItems[index].quantity++;
                                      });
                                    },
                                    child: Icon(
                                      Icons.arrow_drop_up_outlined,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${this.widget.cardItems[index].quantity}',
                                  style: TextStyle(
                                      color: eButtonColor, fontSize: 10),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (this
                                                .widget
                                                .cardItems[index]
                                                .quantity >
                                            1) {
                                          total -= this
                                              .widget
                                              .cardItems[index]
                                              .price;
                                          this
                                              .widget
                                              .cardItems[index]
                                              .quantity--;
                                        }
                                      });
                                    },
                                    child: Icon(
                                      Icons.arrow_drop_down_outlined,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ): Center(child: CircularProgressIndicator(backgroundColor: Colors.yellow,)),
          ),
          Divider(
            thickness: 2,
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(color: Colors.grey, fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '\$ ${totalPrice()}',
                    style: TextStyle(color: eButtonColor, fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 50,
                      width: width,
                      decoration: BoxDecoration(
                        color: eButtonColor,
                      ),
                      child: FlatButton(
                        child: Text(
                          'CHECKOUT',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {
                          setState(() {
                            cartService.makeTheCartEmpty();
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Want to shop more?',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _deleteCartItem(int index, int id) async {
    setState(() {
      this.widget.cardItems.removeAt(index);
    });

    // delete item by id from local database
    var result = await cartService.deleteCartItemById(id);
    if (result > 0) {
      _showSnackMessage(Text(
        'One item deleted from cart',
        style: TextStyle(color: Colors.red),
      ));
    } else {
      _showSnackMessage(Text(
        'Cart items can not be deleted!',
        style: TextStyle(color: Colors.yellow),
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
}
