# Grocery App

A Flutter application for managing your grocery shopping list. Add, view, and organize grocery items by category with a simple and intuitive interface.

**Developer:** [LK-Hour](https://github.com/LK-Hour)  
**Repository:** [W12-Navigation](https://github.com/LK-Hour/W12-Navigation)

## Features

- ✅ View grocery list with categorized items
- ✅ Add new grocery items with name, quantity, and category
- ✅ Category color indicators for easy identification
- ✅ Form validation for input fields
- ✅ Reset form functionality
- ✅ Dark theme UI

## Screenshots / Demo

*Add screenshots of your app here*

## Installation and Setup

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)
- Git

### Clone the Repository

```bash
git clone https://github.com/LK-Hour/W12-Navigation.git
cd grocery_app
```

### Install Dependencies

```bash
flutter pub get
```

### Verify Installation

```bash
flutter doctor
```

## How to Run the App

### Run on Linux

```bash
flutter run -d linux
```

### Run on Other Platforms

```bash
# Android
flutter run -d android

# iOS (macOS only)
flutter run -d ios

# Web
flutter run -d chrome

# Windows
flutter run -d windows
```


## Project Structure

```
grocery_app/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── data/
│   │   ├── mock_grocery_repository.dart   # Mock data store
│   │   └── models/
│   │       └── grocery.dart               # Grocery & Category models
│   └── ui/
│       └── groceries/
│           ├── grocery_list.dart          # List view screen
│           └── grocery_form.dart          # Add item form screen
├── android/                               # Android platform files
├── ios/                                   # iOS platform files
├── linux/                                 # Linux platform files
├── windows/                               # Windows platform files
├── web/                                   # Web platform files
├── pubspec.yaml                           # Dependencies & assets
└── README.md                              # This file
```

## Key Flutter Concepts Used

### 1. setState() - State Management

`setState()` tells Flutter to rebuild the widget when data changes.

```dart
void updateData() {
  setState(() {
    // Change your state variables here
    _selectedCategory = newCategory;
  });
  // Flutter automatically calls build() after this
}
```

**How it works:**
1. You call `setState(() { ... })`
2. Flutter marks the widget as "dirty"
3. Flutter calls the `build()` method again
4. The UI updates with new values

### 2. Navigator - Screen Navigation

Navigator manages the screen stack (like a deck of cards).

```dart
// Push - Open new screen and wait for result
final result = await Navigator.of(context).push(
  MaterialPageRoute(builder: (ctx) => NewScreen()),
);

// Pop - Close screen and return value
Navigator.of(context).pop(returnValue);
```

**Flow:**
```
Screen A → push() → Screen B
         ← pop(data) ←
```

### 3. DropdownButtonFormField - Dropdown Selection

Key points for proper implementation:

```dart
DropdownButtonFormField<GroceryCategory>(
  value: _selectedCategory,           // Use 'value' not 'initialValue'
  decoration: InputDecoration(
    labelText: 'Category',
  ),
  items: GroceryCategory.values
    .map((category) => DropdownMenuItem(
      value: category,
      child: Text(category.label),
    ))
    .toList(),
  onChanged: (value) {
    setState(() {
      _selectedCategory = value!;     // Update state on change
    });
  },
)
```

**Important:**
- Use `value` (not `initialValue`) to make dropdown reactive
- Call `setState()` in `onChanged` to update the UI
- Provide a `decoration` for consistent styling

### 4. Form Validation Pattern

```dart
String? _errorMessage;  // State variable for error

void validateInput() {
  if (inputIsInvalid) {
    setState(() {
      _errorMessage = "Error text";  // Set error
    });
    return;
  }
  
  setState(() {
    _errorMessage = null;  // Clear error on success
  });
}

// In TextField:
TextField(
  decoration: InputDecoration(
    errorText: _errorMessage,  // Display error
  ),
)
```

## Data Models

### GroceryCategory Enum

```dart
enum GroceryCategory {
  vegetables, fruit, meat, dairy, carbs, 
  sweets, spices, convenience, hygiene, other
}
```

Each category has:
- `label`: Display name (e.g., "Vegetables")
- `color`: Color indicator for UI

### Grocery Class

```dart
class Grocery {
  final String id;
  final String name;
  final int quantity;
  final GroceryCategory category;
}
```

## Common Issues & Solutions

### Issue: Dropdown shows nothing
**Solution:** Use `value` instead of `initialValue` in DropdownButtonFormField

### Issue: Error messages don't show
**Solution:** Use state variables with `setState()` and connect them to TextField's `errorText`

### Issue: New items don't appear in list
**Solution:** Add item to repository and call `setState()` in the list screen after Navigator.pop()

## Learning Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Widget Catalog](https://docs.flutter.dev/ui/widgets)
- [State Management](https://docs.flutter.dev/data-and-backend/state-mgmt/intro)

## Contributing

Contributions are welcome! If you'd like to contribute to this project, please follow these steps:

### How to Contribute

1. **Fork the repository**
   ```bash
   # Click the 'Fork' button at the top of this repository
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR-USERNAME/W12-Navigation.git
   cd grocery_app
   ```

3. **Create a new branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make your changes**
   - Add new features
   - Fix bugs
   - Improve documentation
   - Add tests

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add: Brief description of your changes"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Describe your changes in detail

### Contribution Guidelines

- **Code Style**: Follow Flutter/Dart style guidelines
- **Commit Messages**: Use clear, descriptive commit messages
- **Documentation**: Update README if you add new features
- **Testing**: Test your changes on multiple platforms if possible
- **Issues**: Check existing issues before creating new ones

### Areas for Contribution

- 🐛 Bug fixes
- ✨ New features (categories, search, filters)
- 📝 Documentation improvements
- 🎨 UI/UX enhancements
- 🧪 Adding tests
- 🌐 Internationalization (i18n)
- ♿ Accessibility improvements

### Questions or Issues?

- Open an [issue](https://github.com/LK-Hour/W12-Navigation/issues)
- Contact the developer: [LK-Hour](https://github.com/LK-Hour)

## License

This project is for educational purposes.

## Developer

**LK-Hour**
- GitHub: [@LK-Hour](https://github.com/LK-Hour)
- Repository: [W12-Navigation](https://github.com/LK-Hour/W12-Navigation)

---

*Developed with ❤️ using Flutter*
