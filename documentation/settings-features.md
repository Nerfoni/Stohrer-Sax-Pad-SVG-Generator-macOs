# Settings & Configuration Features

## 1. Settings Persistence

### File Management

- **Settings file**: `app_settings.json` in data directory
- **Automatic creation** of data directory if missing
- **JSON format** for human-readable configuration
- **Error handling** for file read/write operations
- **Permission error handling** with user-friendly messages

### Settings Loading

- **Default settings fallback** if file doesn't exist
- **Deep merge** for nested configuration objects
- **Type preservation** for different setting types
- **Graceful degradation** for corrupted settings files

### Settings Saving

- **Automatic saving** on application exit
- **Manual saving** after configuration changes
- **Pretty printing** with 2-space indentation
- **Atomic writes** to prevent corruption

## 2. Default Configuration

### Core Settings

```json
{
  "units": "in",
  "felt_offset": 0.75,
  "card_to_felt_offset": 2.0,
  "leather_wrap_multiplier": 1.0,
  "sheet_width": "13.5",
  "sheet_height": "10",
  "hole_option": "3.5mm",
  "custom_hole_size": "4.0",
  "min_hole_size": 16.5,
  "felt_thickness": 3.175,
  "felt_thickness_unit": "mm",
  "engraving_on": true,
  "show_engraving_warning": true,
  "last_output_dir": "",
  "resonance_clicks": 0
}
```

### Engraving Font Sizes

```json
{
  "engraving_font_size": {
    "felt": 2.0,
    "card": 2.0,
    "leather": 2.0,
    "exact_size": 2.0
  }
}
```

### Engraving Locations

```json
{
  "engraving_location": {
    "felt": { "mode": "centered", "value": 0.0 },
    "card": { "mode": "centered", "value": 0.0 },
    "leather": { "mode": "from_outside", "value": 1.0 },
    "exact_size": { "mode": "centered", "value": 0.0 }
  }
}
```

### Layer Colors (Lightburn Compatible)

```json
{
  "layer_colors": {
    "felt_outline": "#000000",
    "felt_center_hole": "#0000A0",
    "felt_engraving": "#A00000",
    "card_outline": "#0000FF",
    "card_center_hole": "#00A0FF",
    "card_engraving": "#A000A0",
    "leather_outline": "#FF0000",
    "leather_center_hole": "#00E000",
    "leather_engraving": "#FF8000",
    "exact_size_outline": "#D0D000",
    "exact_size_center_hole": "#A0A000",
    "exact_size_engraving": "#BB7784"
  }
}
```

## 3. Sizing Rules Configuration

### Unit System

- **Primary units**: inches, centimeters, millimeters
- **Default unit**: inches
- **Real-time conversion** for all calculations
- **UI label updates** when unit changes

### Material Offsets

- **Felt diameter reduction**: Configurable offset in mm
- **Card additional reduction**: Additional offset beyond felt
- **Leather wrap multiplier**: Fine-tuning for leather sizing
- **Minimum hole size**: Threshold for center hole inclusion

### Felt Thickness

- **Configurable thickness** value
- **Unit selection**: inches or millimeters
- **Automatic conversion** for calculations
- **Default value**: 3.175mm (1/8 inch)

## 4. Engraving Configuration

### Font Size Settings

- **Per-material font sizes** in millimeters
- **Independent configuration** for each material type
- **Default size**: 2.0mm for all materials
- **Validation** against pad size limits

### Positioning Options

- **Three positioning modes**:
  - `from_outside`: Distance from outer edge
  - `from_inside`: Distance from inner edge (hole)
  - `centered`: Between outer and inner edges
- **Configurable offset values** in millimeters
- **Per-material configuration**

### Engraving Control

- **Master enable/disable** for all engraving
- **Warning system** for oversized engravings
- **User preference** to suppress warnings
- **Automatic skipping** of oversized engravings

## 5. Layer Color Management

### Lightburn Integration

- **30 predefined colors** matching Lightburn palette
- **Color name mapping** for user-friendly selection
- **Hex value storage** for SVG generation
- **Per-layer color assignment**

### Color Categories

- **Outline colors**: Main pad boundaries
- **Center hole colors**: Hole boundaries
- **Engraving colors**: Text labels
- **Material-specific** color schemes

### Color Selection Interface

- **Dropdown selection** for each layer type
- **Current color display** in selection
- **Bulk color management** across all layers
- **Reset to defaults** functionality

## 6. Preset Management

### Preset Storage

- **Preset file**: `pad_presets.json` in data directory
- **JSON format** with preset names as keys
- **Pad list storage** as text strings
- **Independent from main settings**

### Preset Operations

- **Save preset**: Name input with validation
- **Load preset**: Dropdown selection
- **Delete preset**: Confirmation dialog
- **Empty preset validation**

### Preset Data Structure

```json
{
  "preset_name": "42.0x3\n38.0x2\n35.0x1",
  "another_preset": "45.0x1\n40.0x2"
}
```

## 7. Application State

### Session State

- **Current pad list** in text area
- **Selected materials** checkboxes
- **Current hole option** radio buttons
- **Sheet dimensions** input fields
- **Filename** input field

### Persistent State

- **Last output directory** for file dialogs
- **Window geometry** (if resizable)
- **User preferences** for warnings
- **Theme state** (resonance clicks)

## 8. Advanced Settings

### Resonance System (Easter Egg)

- **Click counter** for resonance feature
- **Theme changes** based on usage count
- **Progress animations** for resonance application
- **Reset functionality** at 100 clicks

### Warning Preferences

- **Engraving size warnings** can be disabled
- **User confirmation** for warning suppression
- **Per-session** warning state
- **Persistent preference** storage

## 9. Settings Validation

### Input Validation

- **Numeric validation** for all numeric inputs
- **Range validation** for reasonable values
- **Unit conversion** validation
- **File path validation** for directories

### Error Handling

- **Permission errors** with helpful messages
- **File corruption** recovery
- **Invalid setting** fallback to defaults
- **User notification** for all errors

## 10. Settings UI

### Options Window

- **Scrollable interface** for all settings
- **Grouped sections** for logical organization
- **Real-time preview** of changes
- **Save/Cancel** workflow

### Color Window

- **Grid layout** for color selection
- **Visual color representation**
- **Bulk operations** for color management
- **Reset functionality**

### Settings Integration

- **Immediate application** of changes
- **UI updates** when settings change
- **Validation feedback** for invalid inputs
- **Consistent styling** with main application
