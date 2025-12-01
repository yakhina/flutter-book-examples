import 'dart:ui';

import 'package:hive/hive.dart';

part 'shopping_item.g.dart';

@HiveType(typeId: 0)
class ShoppingItem extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int quantity;

  @HiveField(2)
  String category; // новая категория, например "еда", "бытовое"

  @HiveField(3)
  int colorValue; // цвет карточки в виде int

  ShoppingItem({
    required this.name,
    required this.quantity,
    this.category = 'прочее',
    this.colorValue = 0xFF80CBC4, // по умолчанию — мягкий бирюзовый
  });

  Color get color => Color(colorValue);
}
