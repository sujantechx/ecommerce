class CartDataModel {
  bool? status;
  String? message;
  List<CartModel>? data;

  CartDataModel({this.status, this.message, this.data});

  CartDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CartModel>[];
      json['data'].forEach((v) {
        data!.add(new CartModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartModel {
  int? id;
  int? productId;
  String? name;
  String? price;
  int? quantity;
  String? image;

  CartModel(
      {this.id,
        this.productId,
        this.name,
        this.price,
        this.quantity,
        this.image});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['image'] = this.image;
    return data;
  }
}