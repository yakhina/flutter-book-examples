import 'package:hive/hive.dart';
import 'package:shopping_list/models/shopping_item.dart';

/// Класс-помощник для работы с локальной базой данных Hive.
/// Содержит основные CRUD-операции для модели [ShoppingItem].
class HiveDatabaseHelper {
  static const String boxName = 'shoppingBox';

  /// Открывает box с элементами списка покупок.
  static Future<Box<ShoppingItem>> openBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<ShoppingItem>(boxName);
    }
    return await Hive.openBox<ShoppingItem>(boxName);
  }

  /// Добавление нового элемента в box.
  static Future<int> addItem(ShoppingItem item) async {
    final box = await openBox();
    return await box.add(item);
  }

  /// Получение всех элементов списка.
  static Future<List<ShoppingItem>> getAllItems() async {
    final box = await openBox();
    return box.values.toList();
  }

  /// Обновление существующего элемента по ключу.
  static Future<void> updateItem(int key, ShoppingItem newItem) async {
    final box = await openBox();
    await box.put(key, newItem);
  }

  /// Удаление элемента по ключу.
  static Future<void> deleteItem(int key) async {
    final box = await openBox();
    await box.delete(key);
  }

  /// Очистка box — удаляет все элементы.
  static Future<void> clearBox() async {
    final box = await openBox();
    await box.clear();
  }
}
