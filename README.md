# Stohrer Sax Pad SVG Generator - macOS Edition

**Version 1.3-macOS**

A macOS port of the original Stohrer Sax Pad SVG Generator. Generates SVGs for laser cutting saxophone felts, cards, and leathers.

## Features

- SVG creation with basic nesting
- Layout in proscribed space (unless it won't fit)
- Save/delete pad presets
- Center hole options (none, 3.0mm, 3.5mm)
- User-defined minimum pad size for center hole
- Select inches-cm-mm for sheet size
- Advanced options to change sizing rules
- User-selectable layer colors (Lightburn palette only) to streamline workflow
- Felt thickness configuration (in or mm)

## macOS-Specific Features

- Native macOS app bundle (.app)
- macOS-optimized UI with native colors
- Automatic dependency management
- Built with PyInstaller for easy distribution
- Drag to Applications folder to install

## Usage

1. Download the latest release from the [Releases page](../../releases)
2. Drag the `StohrerPadGenerator.app` to your Applications folder
3. Launch the app from Applications or Spotlight
4. Enter pad sizes like "34.0 x 10" (one per line)
5. Select materials and configure options
6. Generate SVGs for your laser cutter

## Technical Details

Should work with default settings for leather between .011"- .014", and sizing of leather disc assumes a .125" thick felt with cardstock between .010 and .025 being acceptable for overwrap, providing for a final pad thickness of .160" to .175" or so.

You will need to apply your own feeds/speeds and kerf settings depending on your cutter in Lightburn. SVGs may not present correctly in other apps (especially default image viewers).

Make sure to enter the pad sizes like it suggests, e.g. "34.0 x 10" without the quotes, and each size on a different line. If you use a comma rather than a decimal point, the value will be ignored.

## Original Project

This is a macOS port of the original Windows version by Matt. The original project was created with AI assistance and provides excellent functionality for saxophone pad generation.

## Building from Source

If you want to build from source:

```bash
pip install -r requirements.txt
python main.py
```

For creating a distributable app:

```bash
pyinstaller --noconsole --onefile --name "StohrerPadGenerator" --icon=icon.icns main.py
```
