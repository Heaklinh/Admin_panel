import 'dart:convert';

class Order {
  final String id;
  final String userID;
  final String productID;
  final int quantity;
  final int queue;
  final int orderNumber;
  final int status;
  final int orderDate;
  final bool? isPaid;
  final double totalPrice;

  Order({
    required this.id,
    required this.userID,
    required this.productID,
    required this.quantity,
    required this.queue,
    required this.orderNumber,
    required this.status,
    required this.orderDate,
    required this.isPaid,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userID': userID,
      'productID': productID,
      'quantity' : quantity,
      'queue': queue,
      'status': status,
      'orderDate': orderDate,
      'totalPrice': totalPrice,
      'orderNumber': orderNumber,
      'isPaid': isPaid,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      userID: map['userID'] ?? '',
      productID: map['productID'] ?? '',
      quantity: map['quantity'] ?? '',
      queue: map['queue'] ?? '',
      status: map['status'] ?? '',
      orderNumber: map['orderNumber'] ?? '',
      orderDate: map['orderDate'] ?? '',
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      isPaid: null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
