import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list/models/shopping_item.dart';

/// ViewModel управляет бизнес-логикой списка покупок.
/// Здесь сосредоточены операции с Hive и обновление данных.
class ShoppingListViewModel {
  final Box<ShoppingItem> _box = Hive.box<ShoppingItem>('items');

  /// Получаем ValueListenable, чтобы UI мог обновляться при изменениях.
  ValueListenable<Box<ShoppingItem>> get listenableBox => _box.listenable();

  /// Список всех элементов (удобен для единоразового чтения).
  List<ShoppingItem> get items => _box.values.toList();

  /// Добавляем новый элемент.
  Future<void> addItem(String name, int quantity, String category, Color color) async {
    await _box.add(
      ShoppingItem(name: name, quantity: quantity, category: category, colorValue: color.value),
    );
  }

  /// Обновляем существующий элемент.
  Future<void> updateItem(
    ShoppingItem item,
    String name,
    int quantity,
    String category,
    Color color,
  ) async {
    item
      ..name = name
      ..quantity = quantity
      ..category = category
      ..colorValue = color.value;
    await item.save();
  }

  /// Удаляем элемент.
  Future<void> deleteItem(ShoppingItem item) async {
    await item.delete();
  }
}
