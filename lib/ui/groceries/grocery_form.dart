import 'package:flutter/material.dart';
import '../../data/models/grocery.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key, this.grocery});

  final Grocery? grocery;

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  // Default settings
  static const defaultQuantity = 1;
  static const defaultCategory = GroceryCategory.fruit;

  // Inputs
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  late GroceryCategory _selectedCategory =
      widget.grocery?.category ?? defaultCategory;
  String? _nameError;
  String? _quantityError;

  @override
  void initState() {
    super.initState();

    // Initialize intputs with default settings
    _nameController.text = widget.grocery?.name ?? "New grocery";
    _quantityController.text =
        widget.grocery?.quantity.toString() ?? defaultQuantity.toString();
  }

  @override
  void dispose() {
    super.dispose();

    // Dispose the controlers
    _nameController.dispose();
    _quantityController.dispose();
  }

  void onReset() {
    // Will be implemented later - Reset all fields to the initial values
  }

  void onAdd() {
    // Will be implemented later - Create and return the new grocery
    final enteredName = _nameController.text;
    final enteredQuantity = int.tryParse(_quantityController.text);

    setState(() {
      _nameError = null;
      _quantityError = null;
    });

    if (enteredName.isEmpty ||
        enteredName.trim().isEmpty ||
        enteredName == (widget.grocery?.name ?? "New grocery")) {
      // Show error message
      setState(() {
        _nameError = "Please enter a valid name.";
      });
      return;
    }

    if (enteredQuantity == null || enteredQuantity <= 0) {
      // Show error message
      setState(() {
        _quantityError = "Please enter a valid quantity.";
      });
      return;
    }

    final newGrocery = Grocery(
      id: DateTime.now().toString(),
      name: enteredName,
      quantity: enteredQuantity,
      category: _selectedCategory,
    );
    Navigator.of(context).pop(newGrocery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new item')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              maxLength: 50,
              decoration: InputDecoration(
                label: const Text('Name'),
                errorText: _nameError,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    decoration: InputDecoration(
                      label: const Text('Quantity'),
                      errorText: _quantityError,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<GroceryCategory>(
                    initialValue: _selectedCategory,
                    items: GroceryCategory.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Row(
                              children: [
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: category.color,
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(category.label),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: onReset, child: const Text('Reset')),
                ElevatedButton(onPressed: onAdd, child: const Text('Add Item')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
