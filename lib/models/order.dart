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
  final bool? isRefunded;
  final double totalPrice;
  final int deletedDate;

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
    required this.isRefunded,
    required this.totalPrice,
    required this.deletedDate
  });

  Order copyWith({
    String? id,
    String? userID,
    String? productID,
    int? quantity,
    int? queue,
    int? orderNumber,
    int? status,
    int? orderDate,
    bool? isPaid,
    bool? isRefunded,
    double? totalPrice,
    int? deleteDate
  }) {
    return Order(
        id: id ?? this.id,
        userID: userID ?? this.userID,
        productID: productID ?? this.productID,
        quantity: quantity ?? this.quantity,
        queue: queue ?? this.queue,
        orderNumber: orderNumber ?? this.orderNumber,
        status: status ?? this.status,
        orderDate: orderDate ?? this.orderDate,
        isPaid: isPaid ?? this.isPaid,
        isRefunded: isRefunded ?? this.isRefunded,
        totalPrice: totalPrice ?? this.totalPrice,
        deletedDate: deletedDate,
        );

  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userID': userID,
      'productID': productID,
      'quantity': quantity,
      'queue': queue,
      'status': status,
      'orderDate': orderDate,
      'totalPrice': totalPrice,
      'orderNumber': orderNumber,
      'isPaid': isPaid,
      'isRefunded': isRefunded,
      'deletedDate' : deletedDate,
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
      isPaid: map['isPaid'],
      isRefunded: map['isRefunded'],
      deletedDate: map['deletedDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
