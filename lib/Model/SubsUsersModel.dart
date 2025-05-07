class SubsUsersModel {
  SubsUsersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<SubsUsersData> data;

  factory SubsUsersModel.fromJson(Map<String, dynamic> json) {
    return SubsUsersModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<SubsUsersData>.from(
              json["data"]!.map((x) => SubsUsersData.fromJson(x))),
    );
  }
}

class SubsUsersData {
  SubsUsersData({
    required this.username,
    required this.userImage,
    required this.email,
    required this.mobile,
    required this.sellerName,
    required this.id,
    required this.planId,
    required this.userId,
    required this.sellerId,
    required this.amount,
    required this.startDate,
    required this.expiryDate,
    required this.createdAt,
    required this.updatedAt,
    required this.transactionId,
    required this.subtotal,
    required this.discount,
    required this.description,
    required this.remarks,
    required this.status,
    required this.type,
    required this.time,
    required this.planTitle,
    required this.planDescription,
    required this.menus,
    required this.orders,
  });

  final String? username;
  final String? userImage;
  final String? email;
  final String? mobile;
  final String? sellerName;
  final String? id;
  final String? planId;
  final String? userId;
  final String? sellerId;
  final String? amount;
  final DateTime? startDate;
  final DateTime? expiryDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? transactionId;
  final String? subtotal;
  final String? discount;
  final String? description;
  final String? remarks;
  final String? status;
  final String? type;
  final String? time;
  final String? planTitle;
  final String? planDescription;
  final List<Menu> menus;
  final List<Order> orders;

  factory SubsUsersData.fromJson(Map<String, dynamic> json) {
    return SubsUsersData(
      username: json["username"],
      userImage: json["user_image"],
      email: json["email"],
      mobile: json["mobile"],
      sellerName: json["seller_name"],
      id: json["id"],
      planId: json["plan_id"],
      userId: json["user_id"],
      sellerId: json["seller_id"],
      amount: json["amount"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      expiryDate: DateTime.tryParse(json["expiry_date"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      transactionId: json["transaction_id"],
      subtotal: json["subtotal"],
      discount: json["discount"],
      description: json["description"],
      remarks: json["remarks"],
      status: json["status"].toString(),
      type: json["type"],
      time: json["time"],
      planTitle: json["plan_title"],
      planDescription: json["plan_description"],
      menus: json["menus"] == null
          ? []
          : List<Menu>.from(json["menus"]!.map((x) => Menu.fromJson(x))),
      orders: json["orders"] == null
          ? []
          : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
    );
  }
}

class Menu {
  Menu({
    required this.id,
    required this.planId,
    required this.day,
    required this.title,
    required this.items,
    required this.description,
    required this.image,
    required this.sellerId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? planId;
  final String? day;
  final String? title;
  final String? items;
  final String? description;
  final String? image;
  final String? sellerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json["id"],
      planId: json["plan_id"],
      day: json["day"],
      title: json["title"],
      items: json["items"],
      description: json["description"],
      image: json["image"],
      sellerId: json["seller_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}

class Order {
  Order({
    required this.id,
    required this.subscriptionId,
    required this.userId,
    required this.planId,
    required this.status,
    required this.date,
    required this.deliveryDateTime,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
    required this.statusText,
  });

  final String? id;
  final String? subscriptionId;
  final String? userId;
  final String? planId;
  final String? status;
  final DateTime? date;
  final dynamic deliveryDateTime;
  final dynamic remarks;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? statusText;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"],
      subscriptionId: json["subscription_id"],
      userId: json["user_id"],
      planId: json["plan_id"],
      status: json["status"].toString(),
      date: DateTime.tryParse(json["date"] ?? ""),
      deliveryDateTime: json["delivery_date_time"],
      remarks: json["remarks"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      statusText: json["status_text"],
    );
  }
}
