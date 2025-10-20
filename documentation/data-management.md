# Data Management - File Handling & Persistence

## 1. File System Structure

### Application Data Directory

```
/data/
├── app_settings.json    # Main application settings
└── pad_presets.json     # Saved pad size presets
```

### Directory Creation

- **Automatic creation** of data directory on first run
- **Cross-platform compatibility** for different OS path separators
- **Permission handling** for directory creation
- **Fallback mechanisms** if directory creation fails

### File Path Resolution

```python
def get_app_data_dir():
    if getattr(sys, "frozen", False):
        # Running as compiled executable
        app_dir = os.path.dirname(sys.executable)
    else:
        # Running as script
        app_dir = os.path.dirname(os.path.abspath(__file__))

    data_dir = os.path.join(app_dir, "data")
    os.makedirs(data_dir, exist_ok=True)
    return data_dir
```

## 2. Settings Persistence

### Settings File (`app_settings.json`)

- **JSON format** for human-readable configuration
- **Automatic loading** on application startup
- **Automatic saving** on application exit
- **Manual saving** after configuration changes

### Settings Loading Process

1. **Check file existence** in data directory
2. **Load JSON data** with error handling
3. **Merge with defaults** for missing keys
4. **Validate data types** and ranges
5. **Fallback to defaults** if loading fails

### Settings Saving Process

1. **Validate current settings** before saving
2. **Create data directory** if it doesn't exist
3. **Write JSON with pretty printing** (2-space indentation)
4. **Handle permission errors** gracefully
5. **Provide user feedback** for save operations

## 3. Preset Management

### Preset File (`pad_presets.json`)

- **Simple key-value structure** with preset names as keys
- **Pad list storage** as text strings
- **Independent from main settings** file
- **User-created content** only

### Preset Operations

- **Save preset**: User provides name, system saves current pad list
- **Load preset**: User selects from dropdown, system loads pad list
- **Delete preset**: User confirms deletion, system removes preset
- **List presets**: System populates dropdown with available presets

### Preset Data Structure

```json
{
  "Common Pads": "42.0x3\n38.0x2\n35.0x1\n32.0x2",
  "Small Pads": "25.0x4\n22.0x3\n20.0x2",
  "Large Pads": "45.0x1\n48.0x1\n50.0x1"
}
```

## 4. File I/O Operations

### Error Handling

- **Permission errors**: Specific messages for file access issues
- **JSON parsing errors**: Graceful fallback to defaults
- **File corruption**: Recovery mechanisms for damaged files
- **Directory creation failures**: Alternative path suggestions

### Atomic Operations

- **Write-then-move** pattern for critical files
- **Backup creation** before major changes
- **Rollback mechanisms** for failed operations
- **Consistency checks** after file operations

### Cross-Platform Compatibility

- **Path separators**: Use `os.path.join()` for all paths
- **File permissions**: Handle different permission models
- **Character encoding**: UTF-8 for all text files
- **Line endings**: Platform-appropriate line endings

## 5. Data Validation

### Settings Validation

- **Type checking**: Ensure correct data types for each setting
- **Range validation**: Check numeric values are within reasonable ranges
- **Format validation**: Verify string formats (e.g., color hex codes)
- **Required fields**: Ensure critical settings are present

### Preset Validation

- **Name validation**: Check preset names are non-empty and unique
- **Content validation**: Verify pad list format is valid
- **Size limits**: Prevent extremely large preset files
- **Character validation**: Ensure only valid characters in names

### Input Sanitization

- **Trim whitespace** from user inputs
- **Escape special characters** in file names
- **Validate file paths** before use
- **Prevent directory traversal** attacks

## 6. Memory Management

### Data Structures

- **Efficient storage** of pad lists and settings
- **Minimal memory footprint** for large datasets
- **Garbage collection** of unused data
- **Memory monitoring** for large operations

### Caching Strategy

- **Settings caching** to avoid repeated file reads
- **Preset caching** for quick access
- **UI state caching** for better performance
- **Cache invalidation** when data changes

## 7. Backup and Recovery

### Automatic Backups

- **Settings backup** before major changes
- **Preset backup** before deletion operations
- **Version tracking** for configuration changes
- **Recovery options** for corrupted data

### Manual Backup

- **Export functionality** for settings and presets
- **Import functionality** for restoring data
- **Backup file naming** with timestamps
- **Backup verification** to ensure integrity

## 8. User Data Protection

### Privacy Considerations

- **Local storage only** - no cloud or network operations
- **User control** over all data
- **No telemetry** or usage tracking
- **Transparent data handling** - users can see all stored data

### Data Security

- **File permissions** appropriate for user data
- **No sensitive information** in logs or temp files
- **Secure deletion** of temporary data
- **Access control** through file system permissions

## 9. File Format Specifications

### Settings File Format

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
  "resonance_clicks": 0,
  "engraving_font_size": {
    "felt": 2.0,
    "card": 2.0,
    "leather": 2.0,
    "exact_size": 2.0
  },
  "engraving_location": {
    "felt": { "mode": "centered", "value": 0.0 },
    "card": { "mode": "centered", "value": 0.0 },
    "leather": { "mode": "from_outside", "value": 1.0 },
    "exact_size": { "mode": "centered", "value": 0.0 }
  },
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

### Preset File Format

```json
{
  "preset_name_1": "42.0x3\n38.0x2\n35.0x1",
  "preset_name_2": "45.0x1\n40.0x2\n35.0x3"
}
```

## 10. Migration and Versioning

### Settings Migration

- **Version detection** in settings files
- **Automatic migration** for format changes
- **Backward compatibility** with older versions
- **Data preservation** during upgrades

### File Format Evolution

- **Additive changes** to maintain compatibility
- **Deprecation warnings** for old formats
- **Migration scripts** for major changes
- **Rollback capability** if migration fails

## 11. Performance Considerations

### File I/O Optimization

- **Lazy loading** of non-critical data
- **Batch operations** for multiple file writes
- **Async operations** where possible
- **Progress indication** for long operations

### Memory Optimization

- **Streaming** for large file operations
- **Efficient data structures** for in-memory data
- **Memory cleanup** after operations
- **Resource monitoring** for large datasets
