class SubsPlanModel {
  SubsPlanModel({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool? error;
  final String? message;
  final List<PlanData> data;

  factory SubsPlanModel.fromJson(Map<String, dynamic> json) {
    return SubsPlanModel(
      error: json["error"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<PlanData>.from(json["data"]!.map((x) => PlanData.fromJson(x))),
    );
  }
}

class PlanData {
  PlanData({
    required this.id,
    required this.sellerId,
    required this.title,
    required this.description,
    required this.amount,
    required this.planType,
    required this.type,
    required this.time,
    required this.timeType,
    required this.image,
    required this.lastOrderTime,
    required this.createdAt,
    required this.updatedAt,
    required this.packageType,
    required this.deliveryTimeSlot,
    required this.isPurchased,
    required this.menus,
  });

  final String? id;
  final String? sellerId;
  final String? title;
  final String? description;
  final String? amount;
  final String? planType;
  final String? type;
  final String? time;
  final String? timeType;
  final String? image;
  final DateTime? lastOrderTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? packageType;
  final List<DeliveryTimeSlot> deliveryTimeSlot;
  final bool? isPurchased;
  final List<Menu> menus;

  factory PlanData.fromJson(Map<String, dynamic> json) {
    return PlanData(
      id: json["id"],
      sellerId: json["seller_id"],
      title: json["title"],
      description: json["description"],
      amount: json["amount"],
      planType: json["plan_type"],
      type: json["type"],
      time: json["time"],
      timeType: json["time_type"],
      image: json["image"],
      lastOrderTime: DateTime.tryParse(json["last_order_time"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      packageType: json["package_type"],
      deliveryTimeSlot: json["delivery_time_slot"] == null
          ? []
          : List<DeliveryTimeSlot>.from(json["delivery_time_slot"]!
              .map((x) => DeliveryTimeSlot.fromJson(x))),
      isPurchased: json["is_purchased"],
      menus: json["menus"] == null
          ? []
          : List<Menu>.from(json["menus"]!.map((x) => Menu.fromJson(x))),
    );
  }
}

class DeliveryTimeSlot {
  DeliveryTimeSlot({
    required this.id,
    required this.time,
    required this.startTime,
    required this.endTime,
  });

  final String? id;
  final String? time;
  final String? startTime;
  final String? endTime;

  factory DeliveryTimeSlot.fromJson(Map<String, dynamic> json) {
    return DeliveryTimeSlot(
      id: json["id"].toString(),
      time: json["time"].toString(),
      startTime: json["start_time"].toString(),
      endTime: json["end_time"].toString(),
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
    required this.sellerId,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  final String? id;
  final String? planId;
  final String? day;
  final String? title;
  final String? items;
  final String? image;
  final String? description;
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
      sellerId: json["seller_id"],
      image: json['image'],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
