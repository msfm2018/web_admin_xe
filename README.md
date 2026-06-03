
# Simple Tree

**A lightweight, simple and powerful tree menu component for Flutter Web admin panels.**

The easiest way to build a beautiful nested sidebar navigation menu in Flutter.

![Demo](https://github.com/msfm2018/simple_tree/blob/1.1.2/index.png?raw=true)
![Screenshot](https://github.com/msfm2018/simple_tree/blob/1.1.2/1.png?raw=true)

---

## Features

- Extremely simple JSON configuration
- Support unlimited nested submenus
- Two usage modes: **Manual** and **Automatic** (recommended)
- Built with `rxflare` for reactive state management
- Designed specifically for Flutter Web admin systems
- Lightweight with minimal dependencies

---

## Installation

```yaml
dependencies:
  simple_tree: ^1.1.3
```

Run:

```bash
flutter pub get
```

---

## Quick Start

### Method 1: Manual Configuration

1. Create `menu.json`
2. Manually define `route_mapper.dart`

### Method 2: Automatic Route Generation (Recommended)

1. Put your pages in the `views/` folder
2. Match the `page` field in JSON with your class name
3. Run:

```bash
dart run gen_route.dart
```

---

## Example

See the [example](example/) folder for a complete working demo.

---

## Documentation

Detailed usage instructions (Chinese): [中文文档](README_CN.md)

---

## License

MIT License © 2025 [msfm2018](https://github.com/msfm2018)

