class Products {
  int id;
  String name;
  String image;
  int price;
  int quantity;

  toMap() {
    var map = Map<String, dynamic>();
    map['productId'] = id;
    map['productName'] = name;
    map['productPhoto'] = image;
    map['productPrice'] = price;
    map['productQuantity'] = quantity;

    return map;
  }
}
