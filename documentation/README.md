# Stohrer Sax Pad SVG Generator - Electron Migration Documentation

This documentation outlines the features and functionality of the current Python/Tkinter application that need to be implemented in the Electron version.

## Documentation Structure

- [Core Features](./core-features.md) - Main SVG generation functionality
- [UI Features](./ui-features.md) - User interface components and interactions
- [Settings & Configuration](./settings-features.md) - Settings management and persistence
- [Technical Features](./technical-features.md) - Technical implementation details
- [Data Management](./data-management.md) - File handling and data persistence

## Overview

The Stohrer Sax Pad SVG Generator is a specialized tool for creating SVG files for saxophone pad cutting. It generates different material types (felt, card, leather, exact size) with proper sizing rules, center holes, and engraving labels.

## Key Capabilities

- **Multi-material Support**: Generate SVGs for felt, card, leather, and exact-size pads
- **Intelligent Sizing**: Automatic diameter calculations based on material-specific rules
- **Center Hole Management**: Configurable center holes with size validation
- **Engraving System**: Size labels with customizable positioning and font sizes
- **Preset Management**: Save and load pad size configurations
- **Advanced Settings**: Comprehensive configuration options for all aspects
- **Layer Color Mapping**: Lightburn-compatible color system for laser cutting
- **Nesting Algorithm**: Automatic pad placement optimization on sheets

## Technology Stack Migration

**Current**: Python + Tkinter + SVGWrite
**Target**: Electron + React + Tailwind + ShadCN

This migration will modernize the UI while maintaining all existing functionality and improving user experience.
