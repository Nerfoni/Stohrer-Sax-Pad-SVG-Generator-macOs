# Migration Guide - Python to Electron

## Overview

This guide outlines the migration strategy from the current Python/Tkinter application to an Electron-based implementation using React, Tailwind CSS, and ShadCN components.

## Technology Stack Migration

### Current Stack

- **Language**: Python 3.x
- **UI Framework**: Tkinter
- **SVG Generation**: svgwrite library
- **Data Storage**: JSON files
- **Platform**: Desktop (macOS focus)

### Target Stack

- **Language**: TypeScript/JavaScript
- **UI Framework**: React 18+
- **Desktop Framework**: Electron
- **Styling**: Tailwind CSS
- **Components**: ShadCN UI
- **SVG Generation**: Custom SVG generation or library
- **Data Storage**: JSON files (same format)
- **Platform**: Cross-platform desktop

## 1. Project Structure Migration

### Current Structure

```
/
├── main.py                 # Main application
├── requirements.txt        # Python dependencies
├── build_local.sh         # Build script
├── icon.icns              # Application icon
├── data/                  # Data directory
│   ├── app_settings.json  # Settings
│   └── pad_presets.json   # Presets
└── README.md
```

### Target Structure

```
/
├── electron/              # Electron main process
│   ├── main.js           # Main process entry
│   ├── preload.js        # Preload script
│   └── package.json      # Electron dependencies
├── src/                  # React application
│   ├── components/       # React components
│   ├── hooks/           # Custom hooks
│   ├── utils/           # Utility functions
│   ├── types/           # TypeScript types
│   └── App.tsx          # Main app component
├── public/              # Static assets
├── package.json         # Main package.json
└── data/               # Data directory (same as current)
```

## 2. Core Functionality Migration

### SVG Generation

**Current**: Python svgwrite library

```python
import svgwrite

dwg = svgwrite.Drawing(filename, size=(f"{width_mm}mm", f"{height_mm}mm"))
dwg.add(dwg.circle(center=(f"{cx}mm", f"{cy}mm"), r=f"{r}mm"))
```

**Target**: Custom SVG generation or library

```typescript
// Option 1: Custom SVG generation
const generateSVG = (
  pads: Pad[],
  material: string,
  width: number,
  height: number
) => {
  const svg = `<svg width="${width}mm" height="${height}mm" xmlns="http://www.w3.org/2000/svg">`;
  // Generate circles and text elements
  return svg + "</svg>";
};

// Option 2: Use a library like svg.js or d3
import { SVG } from "@svgdotjs/svg.js";
```

### Mathematical Calculations

**Current**: Python functions

```python
def get_disc_diameter(pad_size, material, settings):
    if material == "felt":
        return pad_size - settings["felt_offset"]
    # ... rest of logic
```

**Target**: TypeScript functions

```typescript
const getDiscDiameter = (
  padSize: number,
  material: string,
  settings: Settings
): number => {
  switch (material) {
    case "felt":
      return padSize - settings.feltOffset;
    case "card":
      return padSize - (settings.feltOffset + settings.cardToFeltOffset);
    // ... rest of logic
  }
};
```

### Nesting Algorithm

**Current**: Python implementation with collision detection

```python
def can_all_pads_fit(pads, material, width_mm, height_mm, settings):
    # Greedy placement algorithm
    # Collision detection using circular boundaries
```

**Target**: TypeScript implementation

```typescript
const canAllPadsFit = (
  pads: Pad[],
  material: string,
  width: number,
  height: number,
  settings: Settings
): boolean => {
  // Same algorithm, TypeScript implementation
  // Use same collision detection logic
};
```

## 3. UI Component Migration

### Main Window

**Current**: Tkinter root window

```python
root = tk.Tk()
root.title("Stohrer Sax Pad SVG Generator v1.3-macOS")
root.geometry("620x640")
```

**Target**: Electron main window

```typescript
// electron/main.js
const mainWindow = new BrowserWindow({
  width: 620,
  height: 640,
  webPreferences: {
    preload: path.join(__dirname, "preload.js"),
  },
});
```

### Input Components

**Current**: Tkinter widgets

```python
self.pad_entry = tk.Text(self.root, height=10)
self.filename_entry = tk.Entry(self.root)
```

**Target**: React components with ShadCN

```tsx
// src/components/PadInput.tsx
import { Textarea } from "@/components/ui/textarea";
import { Input } from "@/components/ui/input";

const PadInput = () => {
  return (
    <div className="space-y-4">
      <Textarea
        placeholder="Enter pad sizes (e.g. 42.0x3):"
        rows={10}
        value={padList}
        onChange={handlePadListChange}
      />
      <Input
        placeholder="my_pad_job"
        value={filename}
        onChange={handleFilenameChange}
      />
    </div>
  );
};
```

### Material Selection

**Current**: Tkinter checkboxes

```python
self.material_vars = {
    "felt": tk.BooleanVar(value=True),
    "card": tk.BooleanVar(value=True),
    "leather": tk.BooleanVar(value=True),
    "exact_size": tk.BooleanVar(value=False),
}
```

**Target**: React checkboxes with ShadCN

```tsx
// src/components/MaterialSelection.tsx
import { Checkbox } from "@/components/ui/checkbox";

const MaterialSelection = () => {
  const [materials, setMaterials] = useState({
    felt: true,
    card: true,
    leather: true,
    exactSize: false,
  });

  return (
    <div className="space-y-2">
      {Object.entries(materials).map(([key, value]) => (
        <div key={key} className="flex items-center space-x-2">
          <Checkbox
            id={key}
            checked={value}
            onCheckedChange={(checked) =>
              setMaterials((prev) => ({ ...prev, [key]: checked }))
            }
          />
          <label htmlFor={key} className="capitalize">
            {key.replace("_", " ")}
          </label>
        </div>
      ))}
    </div>
  );
};
```

### Settings Windows

**Current**: Tkinter modal windows

```python
class OptionsWindow(tk.Toplevel):
    def __init__(self, parent, app, settings, update_callback, save_callback):
        self.top = tk.Toplevel(parent)
        self.top.title("Sizing Rules")
        self.top.geometry("500x700")
```

**Target**: React modal dialogs with ShadCN

```tsx
// src/components/SettingsDialog.tsx
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";

const SettingsDialog = ({ open, onOpenChange, settings, onSave }) => {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-2xl max-h-[700px] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>Sizing Rules</DialogTitle>
        </DialogHeader>
        {/* Settings form content */}
      </DialogContent>
    </Dialog>
  );
};
```

## 4. State Management Migration

### Current State Management

**Python**: Class-based state with instance variables

```python
class PadSVGGeneratorApp:
    def __init__(self, root):
        self.settings = self.load_settings()
        self.presets = self.load_presets()
        self.material_vars = {...}
```

**Target**: React state management

```typescript
// src/hooks/useAppState.ts
import { useState, useEffect } from "react";

export const useAppState = () => {
  const [settings, setSettings] = useState<Settings>(defaultSettings);
  const [presets, setPresets] = useState<Record<string, string>>({});
  const [materials, setMaterials] = useState<MaterialSelection>({
    felt: true,
    card: true,
    leather: true,
    exactSize: false,
  });

  // Load settings and presets on mount
  useEffect(() => {
    loadSettings().then(setSettings);
    loadPresets().then(setPresets);
  }, []);

  return {
    settings,
    presets,
    materials,
    setSettings,
    setPresets,
    setMaterials,
  };
};
```

### Settings Persistence

**Current**: Direct file I/O in Python

```python
def save_settings(self):
    with open(SETTINGS_FILE, "w") as f:
        json.dump(self.settings, f, indent=2)
```

**Target**: Electron IPC with file system access

```typescript
// electron/main.js
ipcMain.handle("save-settings", async (event, settings) => {
  const settingsPath = path.join(app.getPath("userData"), "app_settings.json");
  await fs.writeFile(settingsPath, JSON.stringify(settings, null, 2));
});

// src/utils/settings.ts
export const saveSettings = async (settings: Settings) => {
  await window.electronAPI.saveSettings(settings);
};
```

## 5. Data Management Migration

### File System Access

**Current**: Direct Python file operations

```python
def load_settings(self):
    if os.path.exists(SETTINGS_FILE):
        with open(SETTINGS_FILE, "r") as f:
            return json.load(f)
    return DEFAULT_SETTINGS.copy()
```

**Target**: Electron IPC for file operations

```typescript
// electron/preload.js
contextBridge.exposeInMainWorld("electronAPI", {
  loadSettings: () => ipcRenderer.invoke("load-settings"),
  saveSettings: (settings) => ipcRenderer.invoke("save-settings", settings),
  loadPresets: () => ipcRenderer.invoke("load-presets"),
  savePresets: (presets) => ipcRenderer.invoke("save-presets", presets),
  selectDirectory: () => ipcRenderer.invoke("select-directory"),
  generateSVG: (data) => ipcRenderer.invoke("generate-svg", data),
});
```

### Data Directory

**Current**: Application-relative data directory

```python
DATA_DIR = get_app_data_dir()
PRESET_FILE = os.path.join(DATA_DIR, "pad_presets.json")
SETTINGS_FILE = os.path.join(DATA_DIR, "app_settings.json")
```

**Target**: Electron user data directory

```typescript
// electron/main.js
const dataDir = app.getPath("userData");
const settingsPath = path.join(dataDir, "app_settings.json");
const presetsPath = path.join(dataDir, "pad_presets.json");
```

## 6. Build and Distribution Migration

### Current Build

**Python**: PyInstaller with build script

```bash
# build_local.sh
pyinstaller --onefile --windowed --icon=icon.icns main.py
```

**Target**: Electron Builder

```json
// package.json
{
  "build": {
    "appId": "com.stohrer.sax-pad-generator",
    "productName": "Stohrer Sax Pad SVG Generator",
    "directories": {
      "output": "dist"
    },
    "files": ["electron/**/*", "src/**/*", "public/**/*"],
    "mac": {
      "category": "public.app-category.utilities",
      "icon": "public/icon.icns"
    }
  }
}
```

### Development Workflow

**Current**: Python script execution

```bash
python main.py
```

**Target**: Electron development

```bash
npm run dev          # Start development server
npm run electron:dev # Start Electron in development
npm run build        # Build for production
npm run dist         # Create distributables
```

## 7. Testing Strategy

### Unit Testing

**Current**: Python unittest (if any)
**Target**: Jest + React Testing Library

```typescript
// src/utils/__tests__/calculations.test.ts
import { getDiscDiameter } from "../calculations";

describe("getDiscDiameter", () => {
  it("calculates felt diameter correctly", () => {
    const result = getDiscDiameter(42, "felt", { feltOffset: 0.75 });
    expect(result).toBe(41.25);
  });
});
```

### Integration Testing

**Target**: Playwright for E2E testing

```typescript
// tests/e2e/pad-generation.spec.ts
import { test, expect } from "@playwright/test";

test("generates SVG files", async ({ page }) => {
  await page.goto("/");
  await page.fill('[data-testid="pad-input"]', "42.0x3\n38.0x2");
  await page.click('[data-testid="generate-button"]');
  await expect(page.locator('[data-testid="success-message"]')).toBeVisible();
});
```

## 8. Migration Checklist

### Phase 1: Core Functionality

- [ ] Set up Electron + React project structure
- [ ] Implement SVG generation logic
- [ ] Port mathematical calculations
- [ ] Implement nesting algorithm
- [ ] Set up file system access via IPC

### Phase 2: UI Components

- [ ] Create main application layout
- [ ] Implement input components (text areas, inputs)
- [ ] Create material selection checkboxes
- [ ] Build settings dialogs
- [ ] Implement preset management

### Phase 3: State Management

- [ ] Set up React state management
- [ ] Implement settings persistence
- [ ] Create preset management system
- [ ] Add error handling and validation

### Phase 4: Polish & Testing

- [ ] Add comprehensive error handling
- [ ] Implement user feedback systems
- [ ] Add unit and integration tests
- [ ] Optimize performance
- [ ] Create build and distribution pipeline

### Phase 5: Advanced Features

- [ ] Implement resonance easter egg
- [ ] Add theme system
- [ ] Create advanced settings UI
- [ ] Add keyboard shortcuts
- [ ] Implement accessibility features

## 9. Key Considerations

### Performance

- **SVG Generation**: Consider using Web Workers for large datasets
- **File I/O**: Use async operations to prevent UI blocking
- **Memory Management**: Implement proper cleanup for large operations

### User Experience

- **Responsive Design**: Ensure UI works on different screen sizes
- **Loading States**: Add progress indicators for long operations
- **Error Handling**: Provide clear, actionable error messages
- **Accessibility**: Follow WCAG guidelines for accessibility

### Compatibility

- **Data Format**: Maintain JSON file format compatibility
- **Settings Migration**: Provide migration path for existing settings
- **Cross-Platform**: Ensure Windows and Linux compatibility
- **Version Updates**: Plan for future updates and data migration
