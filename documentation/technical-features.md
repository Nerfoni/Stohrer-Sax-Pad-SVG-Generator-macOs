# Technical Features - Implementation Details

## 1. SVG Generation Engine

### SVGWrite Library Integration

- **Library**: `svgwrite` for Python SVG generation
- **Profile**: "tiny" profile for minimal SVG output
- **Coordinate system**: Millimeter-based for precision
- **Namespace handling**: Proper SVG namespace declarations

### SVG Structure

```xml
<svg width="342.9mm" height="254mm" xmlns="http://www.w3.org/2000/svg">
  <circle cx="25.5mm" cy="25.5mm" r="20.25mm" stroke="#000000" fill="none" stroke-width="0.1mm"/>
  <circle cx="25.5mm" cy="25.5mm" r="1.75mm" stroke="#0000A0" fill="none" stroke-width="0.1mm"/>
  <text x="25.5mm" y="23.75mm" text-anchor="middle" font-size="2mm" fill="#A00000">42</text>
</svg>
```

### Circle Generation

- **Outline circles**: Main pad boundaries
- **Center holes**: Optional inner circles
- **Stroke-only rendering**: No fill for cutting paths
- **Precise positioning**: Millimeter-based coordinates

### Text Rendering

- **SVG text elements** for engraving
- **Middle anchor** for centered text
- **Font size specification** in millimeters
- **Color-coded** per material type

## 2. Mathematical Calculations

### Diameter Calculations

```python
def get_disc_diameter(pad_size, material, settings):
    if material == "felt":
        return pad_size - settings["felt_offset"]
    elif material == "card":
        return pad_size - (settings["felt_offset"] + settings["card_to_felt_offset"])
    elif material == "leather":
        wrap = leather_back_wrap(pad_size, settings["leather_wrap_multiplier"])
        felt_thickness_mm = get_felt_thickness_mm(settings)
        diameter = pad_size + 2 * (felt_thickness_mm + wrap)
        return round(diameter * 2) / 2
    elif material == "exact_size":
        return pad_size
```

### Leather Wrap Calculation

```python
def leather_back_wrap(pad_size, multiplier):
    if pad_size >= 45:
        base_wrap = 3.2
    elif pad_size >= 12:
        base_wrap = 1.2 + (pad_size - 12) * (2.0 / 33.0)
    elif pad_size >= 6:
        base_wrap = 1.0 + (pad_size - 6) * (0.2 / 6.0)
    else:
        base_wrap = 1.0
    return base_wrap * multiplier
```

### Unit Conversion

```python
def convert_to_mm(value, unit):
    if unit == "in":
        return value * 25.4
    elif unit == "cm":
        return value * 10
    elif unit == "mm":
        return value
```

## 3. Nesting Algorithm

### Placement Strategy

- **Greedy algorithm**: Place largest pads first
- **Size-based sorting**: Descending order by diameter
- **Grid-based placement**: 1mm grid for efficient packing
- **Collision detection**: Circular boundary checking

### Collision Detection

```python
def is_collision(cx, cy, r, placed, spacing):
    for _, px, py, pr in placed:
        distance = math.sqrt((cx - px)**2 + (cy - py)**2)
        if distance < (r + pr + spacing):
            return True
    return False
```

### Placement Loop

```python
def place_pads(discs, width_mm, height_mm, spacing):
    placed = []
    for pad_size, dia in discs:
        r = dia / 2
        placed_successfully = False
        y = spacing
        while y + dia + spacing <= height_mm and not placed_successfully:
            x = spacing
            while x + dia + spacing <= width_mm:
                cx, cy = x + r, y + r
                if not is_collision(cx, cy, r, placed, spacing):
                    placed.append((pad_size, cx, cy, r))
                    placed_successfully = True
                    break
                x += 1
            y += 1
    return placed
```

## 4. File System Operations

### Directory Management

```python
def get_app_data_dir():
    if getattr(sys, "frozen", False):
        app_dir = os.path.dirname(sys.executable)
    else:
        app_dir = os.path.dirname(os.path.abspath(__file__))

    data_dir = os.path.join(app_dir, "data")
    os.makedirs(data_dir, exist_ok=True)
    return data_dir
```

### File Operations

- **Atomic writes**: Prevent corruption during saves
- **Error handling**: Permission and I/O error management
- **Path validation**: Ensure directory existence
- **Cross-platform compatibility**: Handle different path separators

### Data Persistence

- **JSON serialization**: Human-readable configuration
- **Pretty printing**: 2-space indentation for readability
- **Type preservation**: Maintain data types during serialization
- **Backup handling**: Graceful fallback to defaults

## 5. Input Parsing

### Text Processing

```python
def parse_pad_list(pad_input):
    pad_list = []
    for line in pad_input.strip().splitlines():
        try:
            size, qty = map(float, line.strip().lower().split("x"))
            pad_list.append({"size": size, "qty": int(qty)})
        except ValueError:
            continue
    return pad_list
```

### Validation Features

- **Line-by-line processing**: Skip invalid entries
- **Type conversion**: String to numeric conversion
- **Error tolerance**: Continue processing valid entries
- **Case normalization**: Convert to lowercase

## 6. Error Handling

### Exception Management

```python
try:
    # Operation
    result = perform_operation()
except PermissionError:
    messagebox.showerror("Permission Error", "Cannot save to file")
except Exception as e:
    messagebox.showerror("Error", f"Unexpected error: {e}")
```

### User Feedback

- **Specific error messages**: Different messages for different errors
- **Actionable guidance**: Tell user how to fix the problem
- **Graceful degradation**: Continue operation when possible
- **Error logging**: Print errors to console for debugging

## 7. UI Framework Integration

### Tkinter Components

- **Main window**: `tk.Tk()` with custom geometry
- **Modal dialogs**: `tk.Toplevel()` with grab_set()
- **Input widgets**: Entry, Text, Checkbutton, Radiobutton
- **Layout managers**: Pack, Grid for positioning

### Event Handling

```python
def on_generate(self):
    try:
        # Validation
        hole_dia = self.get_hole_dia()
        if hole_dia is None:
            return

        # Processing
        pads = self.parse_pad_list(self.pad_entry.get("1.0", tk.END))
        if not pads:
            messagebox.showerror("Error", "No valid pad sizes entered.")
            return

        # Generation
        self.generate_svgs(pads, hole_dia)

    except Exception as e:
        messagebox.showerror("Error", f"Generation failed: {e}")
```

### State Management

- **Widget state**: Enable/disable based on selections
- **Data binding**: Connect UI elements to data
- **Event propagation**: Handle user interactions
- **State persistence**: Save/restore application state

## 8. Configuration Management

### Settings Structure

```python
DEFAULT_SETTINGS = {
    "units": "in",
    "felt_offset": 0.75,
    "card_to_felt_offset": 2.0,
    "leather_wrap_multiplier": 1.00,
    "sheet_width": "13.5",
    "sheet_height": "10",
    "hole_option": "3.5mm",
    "custom_hole_size": "4.0",
    "min_hole_size": 16.5,
    "felt_thickness": 3.175,
    "felt_thickness_unit": "mm",
    "engraving_on": True,
    "show_engraving_warning": True,
    "last_output_dir": "",
    "resonance_clicks": 0
}
```

### Settings Operations

- **Deep merge**: Preserve nested structure
- **Type checking**: Ensure correct data types
- **Validation**: Check value ranges and formats
- **Migration**: Handle settings format changes

## 9. Performance Optimizations

### Algorithm Efficiency

- **O(n²) nesting**: Reasonable for typical pad counts
- **Early termination**: Stop when all pads placed
- **Memory management**: Efficient data structures
- **Grid optimization**: 1mm grid for faster collision detection

### UI Responsiveness

- **Non-blocking operations**: Use after() for progress updates
- **Progress indication**: Visual feedback during long operations
- **Error handling**: Prevent UI freezing on errors
- **State management**: Maintain UI consistency

## 10. Cross-Platform Compatibility

### Path Handling

- **os.path.join()**: Cross-platform path construction
- **Path normalization**: Handle different separators
- **Directory creation**: Ensure data directory exists
- **File permissions**: Handle different permission models

### Application Packaging

- **Frozen executable**: Detect when running as compiled app
- **Resource bundling**: Include data files in distribution
- **Icon handling**: Platform-specific icon formats
- **Build scripts**: Automated packaging process
