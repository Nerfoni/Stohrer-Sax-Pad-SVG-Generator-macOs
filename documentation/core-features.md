# Core Features - SVG Generation

## 1. Pad Size Input System

### Text Input Parsing

- **Multi-line text input** for pad sizes in format `size x quantity`
- **Example format**: `42.0x3` (42.0mm diameter, quantity 3)
- **Line-by-line parsing** with error handling for invalid entries
- **Empty line filtering** - skip blank lines during parsing
- **Case insensitive** parsing (converts to lowercase)

### Input Validation

- **Numeric validation** for both size and quantity
- **Error handling** for malformed entries
- **Graceful degradation** - skip invalid lines, process valid ones

## 2. Material Type System

### Supported Materials

- **Felt**: Primary material with diameter reduction
- **Card**: Secondary material with additional reduction
- **Leather**: Wrap-around material with variable sizing
- **Exact Size**: No modifications to original pad size

### Material Selection

- **Checkbox interface** for each material type
- **Independent selection** - can generate multiple materials simultaneously
- **Default state**: Felt, Card, Leather enabled; Exact Size disabled

## 3. Sizing Rules Engine

### Felt Sizing

- **Base diameter calculation**: `pad_size - felt_offset`
- **Configurable offset** (default: 0.75mm)
- **Unit conversion support** (mm, cm, inches)

### Card Sizing

- **Additional reduction**: `felt_offset + card_to_felt_offset`
- **Cumulative sizing** based on felt dimensions
- **Configurable card offset** (default: 2.0mm)

### Leather Sizing

- **Variable wrap calculation** based on pad size:
  - Pads ≥45mm: 3.2mm base wrap
  - Pads 12-45mm: Linear interpolation (1.2mm to 3.2mm)
  - Pads 6-12mm: Linear interpolation (1.0mm to 1.2mm)
  - Pads <6mm: 1.0mm base wrap
- **Multiplier support** for fine-tuning (default: 1.00)
- **Felt thickness consideration** in final diameter

### Exact Size

- **No modifications** - uses original pad size
- **Direct diameter mapping**

## 4. Center Hole System

### Hole Size Options

- **None**: No center holes
- **3.0mm**: Standard small hole
- **3.5mm**: Standard medium hole
- **Custom**: User-defined size in mm

### Hole Validation

- **Minimum size check** - only add holes if pad size ≥ minimum (default: 16.5mm)
- **Size validation** for custom hole entries
- **Error handling** for invalid custom sizes

## 5. SVG Generation Engine

### File Output

- **Multiple file generation** - one SVG per selected material
- **Naming convention**: `{base_filename}_{material}.svg`
- **Directory selection** with last-used directory memory
- **File overwrite handling**

### SVG Structure

- **Proper SVG namespace** and profile settings
- **Millimeter-based coordinates** for precision
- **Layer-based organization** for laser cutting compatibility

### Circle Generation

- **Outline circles** for each pad
- **Center holes** when applicable
- **Stroke-only rendering** (no fill) for cutting paths
- **Configurable stroke width** (0.1mm)

## 6. Nesting Algorithm

### Automatic Placement

- **Greedy placement algorithm** - largest pads first
- **Collision detection** using circular boundary checking
- **Spacing management** (1mm minimum spacing)
- **Sheet boundary respect** - pads must fit within sheet dimensions

### Optimization Features

- **Size-based sorting** - place largest pads first for better fit
- **Grid-based placement** - 1mm grid for efficient packing
- **Fit validation** - check if all pads can fit before generation

## 7. Engraving System

### Size Label Generation

- **Automatic size labeling** on each pad
- **Decimal formatting** - remove trailing zeros and decimal points
- **Font size configuration** per material type
- **Positioning options**:
  - From outside edge
  - From inside edge (hole)
  - Centered between edge and hole

### Engraving Validation

- **Size checking** - prevent oversized engravings
- **Warning system** for pads too small for current font size
- **User confirmation** for oversized engraving scenarios
- **Skip option** for problematic engravings

### Text Rendering

- **SVG text elements** with proper positioning
- **Middle anchor** for centered text
- **Vertical adjustment** for visual centering
- **Color-coded** per material type

## 8. Sheet Size Management

### Unit Support

- **Inches (in)**: Convert to mm (×25.4)
- **Centimeters (cm)**: Convert to mm (×10)
- **Millimeters (mm)**: Direct use
- **Dynamic unit labels** in UI

### Sheet Validation

- **Fit checking** before generation
- **Error reporting** for oversized sheets
- **User feedback** for nesting failures

## 9. Error Handling & Validation

### Input Validation

- **Pad size validation** - numeric values only
- **Quantity validation** - positive integers only
- **Sheet size validation** - positive numeric values
- **Filename validation** - non-empty base names

### Generation Validation

- **Fit validation** - ensure all pads can be placed
- **Engraving validation** - check font size vs pad size
- **File system validation** - check write permissions

### User Feedback

- **Error dialogs** with specific error messages
- **Warning dialogs** for potential issues
- **Success confirmation** when generation completes
- **Progress indication** during processing
