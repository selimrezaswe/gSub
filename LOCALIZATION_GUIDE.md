# 🌍 Flutter Localization Guide (gen-l10n)

This project uses **Flutter's `gen-l10n`** (code generation for localization) for internationalization. This guide explains how to add new strings, add new languages, and use localization throughout the app.

---

## 📚 Table of Contents

1. [How It Works](#how-it-works)
2. [Adding a New String](#adding-a-new-string)
3. [Adding a New Language](#adding-a-new-language)
4. [Using Localized Strings in Code](#using-localized-strings-in-code)
5. [Complete Workflow Example](#complete-workflow-example)
6. [File Structure](#file-structure)
7. [Best Practices](#best-practices)

---

## 🎯 How It Works

### Setup Files

1. **`pubspec.yaml`** - Enables code generation:
   ```yaml
   flutter:
     generate: true
   ```

2. **`l10n.yaml`** - Configuration for localization:
   ```yaml
   arb-dir: lib/l10n
   template-arb-file: app_en.arb
   output-localization-file: app_localizations.dart
   output-class: AppLocalizations
   output-dir: lib/l10n/generated
   ```

3. **ARB Files** (`lib/l10n/app_*.arb`) - JSON files containing translations:
   - `app_en.arb` - English (template file)
   - `app_es.arb` - Spanish
   - `app_hi.arb` - Hindi
   - `app_bn.arb` - Bengali
   - Add more as needed...

4. **Generated Files** (`lib/l10n/generated/`) - Auto-generated Dart code:
   - `app_localizations.dart` - Main class
   - `app_localizations_*.dart` - Per-language implementations

### Code Generation

When you run `flutter pub get` or `flutter gen-l10n`, Flutter:
1. Reads all `.arb` files in `lib/l10n/`
2. Generates strongly-typed Dart classes in `lib/l10n/generated/`
3. Provides autocomplete and type safety for all strings

---

## ✨ Adding a New String

### Step 1: Add to Template File (`app_en.arb`)

Open `lib/l10n/app_en.arb` and add your new string:

```json
{
  "welcomeMessage": "Welcome to SuperAlarm!",
  "@welcomeMessage": {
    "description": "Message shown on the welcome screen"
  }
}
```

**Key Rules:**
- ✅ Use camelCase for keys (e.g., `welcomeMessage`)
- ✅ Add `@key` entries for descriptions (helpful for translators)
- ✅ Always add new strings to `app_en.arb` first (the template)

### Step 2: Add Translations to Other Languages

Add the same key to other ARB files with translations:

**`app_es.arb`** (Spanish):
```json
{
  "welcomeMessage": "¡Bienvenido a SuperAlarm!"
}
```

**`app_hi.arb`** (Hindi):
```json
{
  "welcomeMessage": "SuperAlarm में आपका स्वागत है!"
}
```

### Step 3: Generate Localization Files

Run:
```bash
flutter gen-l10n
```

Or:
```bash
flutter pub get
```

This regenerates `lib/l10n/generated/app_localizations.dart` with your new string.

### Step 4: Use in Your Code

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Text(l10n.welcomeMessage);
  }
}
```

**That's it!** The string will automatically change based on the device's language.

---

## 🌐 Adding a New Language

### Step 1: Create New ARB File

Create `lib/l10n/app_[lang_code].arb` where `[lang_code]` is the ISO 639-1 language code:

**Example:** `lib/l10n/app_fr.arb` for French:

```json
{
  "@@locale": "fr",
  "settings": "Paramètres",
  "alarm": "Alarme",
  "weather": "Météo",
  "appLanguage": "Langue de l'application",
  "appLanguageDescription": "Changer la langue de l'application",
  "currentLanguage": "Français",
  // ... add all other strings from app_en.arb
}
```

### Step 2: Add Locale to `main.dart`

Update `lib/main.dart`:

```dart
supportedLocales: const [
  Locale('en'),
  Locale('es'),
  Locale('hi'),
  Locale('bn'),
  Locale('fr'), // ← Add new language here
  // ... other locales
],
```

### Step 3: Add to Android `locales_config.xml`

Update `android/app/src/main/res/xml/locales_config.xml`:

```xml
<locale-config xmlns:android="http://schemas.android.com/apk/res/android">
    <locale android:name="en"/>
    <locale android:name="es"/>
    <locale android:name="hi"/>
    <locale android:name="bn"/>
    <locale android:name="fr"/> <!-- ← Add new language here -->
</locale-config>
```

### Step 4: Update Settings Page Language Map

Update `_getCurrentLanguageName()` in `settings_page.dart`:

```dart
case 'fr':
  return 'Français';
```

### Step 5: Generate Files

```bash
flutter gen-l10n
```

---

## 💻 Using Localized Strings in Code

### Basic Usage

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Get the localization instance
final l10n = AppLocalizations.of(context)!;

// Use strings
Text(l10n.settings)
Text(l10n.alarm)
Text(l10n.appLanguage)
```

### With Null Safety

Always use `!` operator if you're sure the context has localizations:

```dart
final l10n = AppLocalizations.of(context)!;
```

Or handle null safely:

```dart
final l10n = AppLocalizations.of(context);
if (l10n != null) {
  return Text(l10n.settings);
}
```

### In Different Widget Contexts

**StatelessWidget:**
```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Text(l10n.settings);
  }
}
```

**StatefulWidget:**
```dart
class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Text(l10n.settings);
  }
}
```

---

## 📋 Complete Workflow Example

Let's say you want to add a new "About" button with text "About the App".

### 1. Add to `app_en.arb`:

```json
{
  "aboutTheApp": "About the App",
  "@aboutTheApp": {
    "description": "Button text for the about screen"
  }
}
```

### 2. Add translations to other ARB files:

**`app_es.arb`:**
```json
{
  "aboutTheApp": "Acerca de la Aplicación"
}
```

**`app_hi.arb`:**
```json
{
  "aboutTheApp": "ऐप के बारे में"
}
```

### 3. Generate files:

```bash
flutter gen-l10n
```

### 4. Use in your code:

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

ElevatedButton(
  onPressed: () {},
  child: Text(AppLocalizations.of(context)!.aboutTheApp),
)
```

### 5. Test:

- Change your device/emulator language
- The button text will automatically update! ✨

---

## 📁 File Structure

```
lib/
├── l10n/
│   ├── app_en.arb          ← Template file (English)
│   ├── app_es.arb          ← Spanish translations
│   ├── app_hi.arb          ← Hindi translations
│   ├── app_bn.arb          ← Bengali translations
│   └── generated/          ← Auto-generated (DO NOT EDIT)
│       ├── app_localizations.dart
│       ├── app_localizations_en.dart
│       ├── app_localizations_es.dart
│       ├── app_localizations_hi.dart
│       └── app_localizations_bn.dart
```

---

## ✅ Best Practices

### 1. **Always Start with English**

Add new strings to `app_en.arb` first (the template file).

### 2. **Use Descriptive Keys**

✅ Good: `alarmSettingsTitle`  
❌ Bad: `title1`, `text1`

### 3. **Group Related Strings**

Keep related strings together in the ARB file for easier management.

### 4. **Add Descriptions**

Use `@key` entries to help translators:

```json
{
  "snooze5Min": "5 minutes",
  "@snooze5Min": {
    "description": "Snooze duration option - 5 minutes"
  }
}
```

### 5. **Don't Edit Generated Files**

Never edit files in `lib/l10n/generated/`. They are auto-generated and will be overwritten.

### 6. **Run `flutter gen-l10n` After Changes**

After editing ARB files, always regenerate:

```bash
flutter gen-l10n
```

### 7. **Keep Translations in Sync**

When you add a new key to `app_en.arb`, add it to **all other ARB files** (even if you use English temporarily).

### 8. **Test with Different Languages**

Always test your app with different device languages to ensure everything works.

---

## 🔄 Automatic Language Detection

The app automatically uses the device's system language. When users change the language in **Android Settings → Apps → Your App → Language**, the app will automatically reload with the new language.

**No code changes needed!** Flutter's `Localizations` widget handles this automatically.

---

## 📝 Current Settings Page Display

The settings page shows the current language:

```dart
subtitle: Column(
  children: [
    Text(l10n.appLanguageDescription),
    Text(_getCurrentLanguageName(context)), // Shows: "English", "Español", etc.
  ],
)
```

---

## 🚀 Quick Reference

| Task | Command |
|------|---------|
| Add new string | Edit `lib/l10n/app_en.arb` and other ARB files |
| Add new language | Create `lib/l10n/app_[code].arb`, update `main.dart`, update `locales_config.xml` |
| Generate files | `flutter gen-l10n` or `flutter pub get` |
| Use in code | `AppLocalizations.of(context)!.yourString` |

---

## ❓ Common Issues

### "AppLocalizations.of(context) returns null"

**Solution:** Make sure `AppLocalizations.delegate` is in your `localizationsDelegates` list in `main.dart`.

### "String not found"

**Solution:** 
1. Check if the key exists in `app_en.arb`
2. Run `flutter gen-l10n` to regenerate files
3. Make sure you're using the correct key name (case-sensitive)

### "Language not changing"

**Solution:**
1. Check if locale is in `supportedLocales` in `main.dart`
2. Check if locale is in `locales_config.xml`
3. Restart the app after changing language in system settings

---

## 📚 Additional Resources

- [Flutter Internationalization Documentation](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)
- [ARB File Format Specification](https://github.com/google/app-resource-bundle)
- [ISO 639-1 Language Codes](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes)

---

**Happy Localizing! 🌍✨**
