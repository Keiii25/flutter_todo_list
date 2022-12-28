# To-Do List

An application that allows user to add and save to-do items and record the item's progress.

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

To add a new localisable string, open the `app_en.arb` file at `lib/l10n/app_en.arb`.

```json
{
    "@@locale": "en",
    "todoList" : "To-Do List",
    "startDate": "Start Date",
    "endDate": "End Date",
}
```

To regenerate the translation files (for auto-completion, etc.), just rebuild or run `flutter gen-l10n` and hot restart.

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...
    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>ms</string>
	</array>

    ...
```

### Adding Translations

For each supported locale, add a new ARB file in `lib/l10n`.

```
├── l10n
│   ├── app_en.arb
│   └── app_ms.arb
```

Add the translated strings to each `.arb` file (follow [Adding Strings](#adding-strings)).

Then, head into the `app_${new_locale}.arb` file and add the same keys and the translated strings as the value. Eg.

```json
{
    "@@locale": "ms",
    "todoList" : "Senerai Kerja",
    "startDate": "Tarikh Bermula",
    "endDate": "Tarikh Tamat",
}
```

## Project Structure

This project uses the Getx package as its state management, route management and dependency injection solution.

```
├── main.dart
├── l10n
│   │   # Any additional language files go here
│   ├── app_en.arb
│   └── app_<language code>.arb
│   └── l10n.dart
│   # A flow describes a user interaction path
├── <flow>
│   │   # Typically, each controller controls a certain page
│   │   # this however can change as we use dependency
│   │   # injection and hence, can get the controller in any
│   │   # child page.
│   ├── controllers
│   │   ├── todo_controller.dart
│   │   └── <controller>.dart
│   │   # Models used by controllers go here
│   ├── models
|   |   |── TodoItemModel.dart
│   │   └── <model>.dart
│   └── view
│       │   # Pages included in the flow
│       ├── pages
│       │   ├── add_todo_item_page.dart
│       │   ├── todo_list_page.dart
│       │   └── <page>.dart
│       └── widgets
│           # any widgets shared between different pages
│           shared
│           └── <widget>.dart
│   # anything that's used throughout the whole app
└── misc
    ├── constants.dart
    ├── <something>.dart
    ├── controllers
    │   └── <controller>.dart
    ├── models
    │   └── <model>.dart
    └── widgets
        ├── generic_appbar.dart
        └── <widget>.dart
```

