# UI Features - User Interface Components

## 1. Main Window Layout

### Window Properties

- **Title**: "Stohrer Sax Pad SVG Generator v1.3-macOS"
- **Size**: 620x640 pixels (fixed size)
- **Background**: Mac-native color scheme
- **Resizable**: No (fixed layout)

### Color Scheme

- **Background**: `#F2F2F7` (Mac system background)
- **Secondary Background**: `#FFFFFF` (Mac window background)
- **Text**: `#000000` (Black)
- **Secondary Text**: `#3C3C43` (Mac secondary text)
- **Entry Background**: `#FFFFFF` (White)
- **Button Background**: `#E5E5EA` (Light gray)
- **Accent Color**: `#007AFF` (Blue)

## 2. Input Components

### Pad Size Input

- **Multi-line text area** (10 lines height)
- **Placeholder text**: "Enter pad sizes (e.g. 42.0x3):"
- **Full-width layout** with horizontal padding
- **Monospace font** for consistent formatting
- **Clear visual separation** from other elements

### Filename Input

- **Single-line text entry**
- **Label**: "Output filename base (no extension):"
- **Default value**: "my_pad_job"
- **Full-width layout** with horizontal padding
- **No extension validation** (handled automatically)

## 3. Material Selection

### Checkbox Interface

- **Four checkboxes** for material types:
  - Felt (enabled by default)
  - Card (enabled by default)
  - Leather (enabled by default)
  - Exact Size (disabled by default)
- **Left-aligned layout** with consistent padding
- **Clear labeling** with proper capitalization
- **Visual grouping** under "Select materials:" label

## 4. Center Hole Configuration

### Radio Button Group

- **Labeled frame**: "Center Hole"
- **Four options**:
  - None
  - 3.0mm
  - 3.5mm
  - Custom (with entry field)
- **Horizontal layout** for radio buttons
- **Conditional entry field** for custom size
- **Unit label** (mm) for custom entry

### Custom Hole Entry

- **6-character width** entry field
- **Disabled state** when not selected
- **Default value**: "4.0"
- **Numeric validation** on input

## 5. Sheet Size Configuration

### Labeled Frame

- **Frame title**: "Sheet Size"
- **Two input fields**:
  - Width (with unit label)
  - Height (with unit label)
- **Dynamic unit labels** based on selected unit
- **Grid layout** for proper alignment

### Unit Selection

- **Radio button group** for units:
  - Inches (in)
  - Centimeters (cm)
  - Millimeters (mm)
- **Default unit**: Inches
- **Real-time label updates** when unit changes

## 6. Preset Management

### Preset Controls

- **Save as Preset** button
- **Load Preset** dropdown (readonly combobox)
- **Delete Preset** button
- **Horizontal layout** with proper spacing

### Preset Dropdown

- **Readonly combobox** with preset names
- **Default text**: "Load Preset"
- **20-character width**
- **Event binding** for selection changes

### Preset Actions

- **Save dialog** for preset names
- **Confirmation dialogs** for deletion
- **Success/error feedback** for operations

## 7. Action Buttons

### Generate Button

- **Primary action button**
- **Bold font** for emphasis
- **Text**: "Generate SVGs"
- **Full-width layout** with vertical padding
- **Event binding** for generation process

### Menu Bar

- **Options menu** with submenu items:
  - Sizing Rules...
  - Layer Colors...
  - Separator
  - Exit
- **Native menu styling**

## 8. Modal Windows

### Options Window (Sizing Rules)

- **Title**: "Sizing Rules"
- **Size**: 500x700 pixels
- **Scrollable content** with canvas and scrollbar
- **Modal behavior** - blocks main window
- **Action buttons**: Save, Cancel, Advanced, Revert to Defaults

### Layer Colors Window

- **Title**: "Layer Color Mapping"
- **Size**: 450x420 pixels
- **Grid layout** for color selection
- **Lightburn color palette** integration
- **Action buttons**: Save, Cancel

### Resonance Window (Easter Egg)

- **Title**: "Resonance Chamber"
- **Size**: 400x200 pixels
- **Single action button**: "Add Resonance"
- **Progress dialog** with animated progress bar
- **Theme-changing effects** based on usage

## 9. Dialog Windows

### Confirmation Dialogs

- **Custom confirmation dialog** class
- **Checkbox**: "Don't show this message again"
- **Action buttons**: "Yes, Proceed", "No, Cancel"
- **Wrappable text** (430px width)
- **Modal behavior** with proper focus management

### Error Dialogs

- **Standard error dialogs** for various error conditions
- **Specific error messages** for different failure types
- **Permission error handling** with detailed messages
- **File system error reporting**

### Input Dialogs

- **Simple input dialogs** for preset names
- **String validation** for required inputs
- **Cancel handling** for user cancellation

## 10. Visual Feedback

### Status Indicators

- **Success messages** for completed operations
- **Warning messages** for potential issues
- **Error messages** for failures
- **Progress indication** during long operations

### Theme System

- **Resonance theme** with color changes:
  - 10-50 clicks: Cool blue background
  - 50-100 clicks: Cool green background
  - 100+ clicks: Special effects and reset
- **Dynamic background updates** for all child widgets
- **Smooth theme transitions**

## 11. Layout Management

### Grid System

- **Two-column grid** for options frame
- **Proper column weighting** for responsive layout
- **Consistent padding** and margins
- **Sticky positioning** for proper alignment

### Frame Organization

- **Labeled frames** for logical grouping
- **Consistent padding** within frames
- **Visual separation** between sections
- **Proper nesting** of UI elements

## 12. Accessibility Features

### Keyboard Navigation

- **Tab order** for logical navigation
- **Enter key** handling for text inputs
- **Escape key** handling for dialogs
- **Focus management** for modal windows

### Visual Accessibility

- **High contrast** color scheme
- **Clear visual hierarchy** with proper spacing
- **Consistent button styling**
- **Readable font sizes** and weights
