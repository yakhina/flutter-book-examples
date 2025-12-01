import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/shopping_item.dart';
import 'package:shopping_list/viewmodels/shopping_list_viewmodel.dart';
import 'package:shopping_list/viewmodels/theme_notifier.dart';

final categories = ['еда', 'бытовое', 'техника', 'прочее'];

final categoryColors = [
  Colors.lightGreen,
  Colors.orange,
  Colors.blueGrey,
  Colors.pinkAccent,
  Colors.blue,
];

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'еда':
        return Icons.fastfood_outlined;
      case 'бытовое':
        return Icons.cleaning_services_outlined;
      case 'техника':
        return Icons.devices_other_outlined;
      default:
        return Icons.shopping_bag_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    // создаём экземпляр ViewModel
    final viewModel = ShoppingListViewModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список покупок'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              final themeNotifier = context.read<ThemeNotifier>();
              switch (value) {
                case 'Светлая':
                  themeNotifier.setThemeMode(ThemeMode.light);
                  break;
                case 'Тёмная':
                  themeNotifier.setThemeMode(ThemeMode.dark);
                  break;
                default:
                  themeNotifier.setThemeMode(ThemeMode.system);
              }
            },
            itemBuilder:
                (context) => const [
                  PopupMenuItem(value: 'Светлая', child: Text('Светлая тема')),
                  PopupMenuItem(value: 'Тёмная', child: Text('Тёмная тема')),
                  PopupMenuItem(value: 'Системная', child: Text('Системная тема')),
                ],
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: viewModel.listenableBox,
        builder: (context, box, _) {
          final items = viewModel.items;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Card(
                  color: item.color.withAlpha(40),
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: item.color,
                      child: Icon(_getCategoryIcon(item.category), color: Colors.white),
                    ),
                    title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Количество: ${item.quantity}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () => showItemDialog(context, viewModel, item: item),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => viewModel.deleteItem(item),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showItemDialog(context, viewModel),
      ),
    );
  }

  /// Сохраняет новый или изменённый элемент
  Future<void> saveItem({
    required BuildContext context,
    required ShoppingListViewModel viewModel,
    ShoppingItem? item,
    required TextEditingController nameController,
    required TextEditingController quantityController,
    required String category,
    required Color color,
  }) async {
    final name = nameController.text.trim();
    final quantity = int.tryParse(quantityController.text) ?? 1;

    if (name.isEmpty) return;

    if (item == null) {
      await viewModel.addItem(name, quantity, category, color);
    } else {
      await viewModel.updateItem(item, name, quantity, category, color);
    }

    if (context.mounted) {
      closeDialog(context);
    }
  }

  /// Закрывает диалоговое окно
  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// Показывает диалог добавления или редактирования
  void showItemDialog(BuildContext context, ShoppingListViewModel viewModel, {ShoppingItem? item}) {
    final nameController = TextEditingController(text: item?.name ?? '');
    final quantityController = TextEditingController(text: item?.quantity.toString() ?? '1');

    // создаём список категорий
    final categories = ['еда', 'бытовое', 'техника', 'прочее'];

    // текущее значение категории
    String selectedCategory = item?.category ?? categories.first;

    // текущее значение цвета
    Color selectedColor = item?.color ?? categoryColors.first;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(item == null ? 'Добавить продукт' : 'Редактировать продукт'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Название'),
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Количество'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(labelText: 'Категория'),
                  items:
                      categories
                          .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                          .toList(),
                  onChanged: (value) {
                    if (value != null) selectedCategory = value;
                  },
                ),
                const SizedBox(height: 12),
                // Выбор цвета
                Wrap(
                  spacing: 8,
                  children:
                      categoryColors.map((color) {
                        final isSelected = color == selectedColor;
                        return GestureDetector(
                          onTap: () => selectedColor = color,
                          child: CircleAvatar(
                            radius: isSelected ? 18 : 16,
                            backgroundColor: color,
                            child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => closeDialog(context), child: const Text('Отмена')),
              ElevatedButton(
                onPressed: () async {
                  await saveItem(
                    context: context,
                    viewModel: viewModel,
                    item: item,
                    nameController: nameController,
                    quantityController: quantityController,
                    category: selectedCategory,
                    color: selectedColor,
                  );
                },
                child: const Text('Сохранить'),
              ),
            ],
          ),
    );
  }
}
