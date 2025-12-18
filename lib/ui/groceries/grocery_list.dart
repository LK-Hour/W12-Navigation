import 'package:flutter/material.dart';
import 'package:grocery_app/ui/groceries/grocery_form.dart';
import '../../data/mock_grocery_repository.dart';
import '../../data/models/grocery.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  bool isSelected = false;

  Set<String> selectedItems = {};
  void onCreate() async {
    // TODO-4 - Navigate to the form screen using the Navigator push
    final newItem = await Navigator.of(
      context,
    ).push<Grocery>(MaterialPageRoute(builder: (context) => const NewItem()));
    if (newItem != null) {
      setState(() {
        dummyGroceryItems.add(newItem);
      });
    }
  }

  void onLongPressed(String id) {
    setState(() {
      isSelected = true;
      selectedItems.add(id);
    });
  }

  void toggleSelection(String id) {
    setState(() {
      if (selectedItems.contains(id)) {
        selectedItems.remove(id);
        if (selectedItems.isEmpty) {
          isSelected = false; // Exit if nothing selected
        }
      } else {
        selectedItems.add(id);
      }
    });
  }

  void deleteSelection() {
    setState(() {
      dummyGroceryItems.removeWhere((item) => selectedItems.contains(item.id));
      selectedItems.clear();
      isSelected = false;
    });
  }

  void cancelSelection() {
    setState(() {
      selectedItems.clear();
      isSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      // TODO-1 - Display groceries with an Item builder and  LIst Tile
      content = ReorderableListView.builder(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = dummyGroceryItems.removeAt(oldIndex);
            dummyGroceryItems.insert(newIndex, item);
          });
        },
        itemCount: dummyGroceryItems.length,
        itemBuilder: (ctx, index) {
          final grocery = dummyGroceryItems[index];
          final isItemSelected = selectedItems.contains(grocery.id);

          return GroceryTile(
            key: ValueKey(grocery.id),
            grocery: grocery,
            isSelected: isItemSelected,
            isSelectionMode: isSelected,
            onUpdate: (updatedGrocery) {
              setState(() {
                dummyGroceryItems[index] = updatedGrocery;
              });
            },
            onTap: () {
              if (isSelected) {
                // In selection mode: toggle selection
                toggleSelection(grocery.id);
              } else {
                // Normal mode: navigate to edit
                Navigator.of(context)
                    .push<Grocery>(
                      MaterialPageRoute(
                        builder: (context) => NewItem(grocery: grocery),
                      ),
                    )
                    .then((updatedGrocery) {
                      if (updatedGrocery != null) {
                        setState(() {
                          dummyGroceryItems[index] = updatedGrocery;
                        });
                      }
                    });
              }
            },
            onLongPressed: () {
              if (!isSelected) {
                onLongPressed(grocery.id);
              }
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: isSelected
            ? Text('${selectedItems.length} selected')
            : const Text('Your Groceries'),
        leading: isSelected
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: cancelSelection,
              )
            : null,
        actions: [
          if (isSelected)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Delete Items'),
                    content: Text('Delete ${selectedItems.length} items?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          deleteSelection();
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          else
            IconButton(onPressed: onCreate, icon: const Icon(Icons.add)),
        ],
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({
    super.key,
    required this.grocery,
    required this.isSelected,
    required this.isSelectionMode,
    required this.onUpdate,
    required this.onTap,
    required this.onLongPressed,
  });

  final Grocery grocery;
  final bool isSelected;
  final bool isSelectionMode;
  final void Function(Grocery) onUpdate;
  final VoidCallback onTap;
  final VoidCallback onLongPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        border: Border(bottom: BorderSide(color: Colors.blueGrey[800]!)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        key: ValueKey(grocery.id),
        selected: isSelected,
        leading: isSelectionMode
            ? Checkbox(value: isSelected, onChanged: (_) => onTap())
            : Container(color: grocery.category.color, width: 15, height: 15),
        title: Text(grocery.name),
        subtitle: Text(
          '${grocery.category.label} - Quantity: ${grocery.quantity}',
        ),
        onTap: onTap,
        onLongPress: onLongPressed,
      ),
    );
  }
}
