import 'package:flutter/material.dart';

class MenuModel {
  String title;
  String? image;
  String? route;
  bool isActive;
  IconData icon;
  VoidCallback? onTap;

  MenuModel({
    required this.title,
    this.image,
    this.route,
    required this.isActive,
    required this.icon,
    this.onTap,
  });

  MenuModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        image = json['image'],
        route = json['route'],
        isActive = json['isActive'],
        icon = json['icon'];
  //to json
  //toJson is the instance method
  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "route": route,
        "isActive": isActive,
        "icon": icon,
      };
}
