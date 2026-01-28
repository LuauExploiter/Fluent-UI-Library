# 🎨 Fluent UI Library

[![Luau UI Library](https://img.shields.io/badge/Language-Luau-blue.svg)](https://luau-lang.org/)
[![Loadstring](https://img.shields.io/badge/Loadstring-Available-brightgreen.svg)](https://raw.githubusercontent.com/LuauExploiter/Fluent-UI-Library/refs/heads/main/Fluent.lua)

---

## ✨ Introduction

**Fluent** is a clean, minimal, and modern UI library designed specifically for the Luau environment (Roblox). It focuses on delivering a premium user experience through a dark, consistent aesthetic and smooth, responsive interactions.

Every component in Fluent is built with **tweened animations** for hover, active, and state changes, ensuring a polished and professional feel for your in-game menus and tools.

## 🚀 Installation

Fluent is distributed as a single-file script, making it incredibly easy to load and use in any Luau execution environment.

To get started, simply execute the following `loadstring`:

\`\`\`lua
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/LuauExploiter/Fluent-UI-Library/refs/heads/main/Fluent.lua"))()
\`\`\`

The `Fluent` table will be returned, providing access to the library's core function: `Fluent:CreateWindow()`.

## 🖼️ Component Showcase

Fluent provides a robust set of controls to build complex interfaces.

| Component | Description | Key Features |
| :--- | :--- | :--- |
| **Window** | The main container for your UI. | Draggable, Close/Minimize controls, Custom Title/Size/Position. |
| **Button** | A standard, interactive button. | Smooth hover/active state transitions, Callback on click. |
| **Toggle** | A clean switch for boolean settings. | Animated state change, Accent color for "On" state, State persistence. |
| **Slider** | Numerical input control. | Drag-to-change value, Displays current value, Supports Min/Max range (integer values). |
| **Dropdown** | Select one option from a list. | Animated open/close, Option list is dynamically sized, State persistence. |
| **Tab** | A simple control for navigation. | Used to create sections within the main window. |

## 🎨 Design Philosophy

Fluent uses a dark, high-contrast color palette with a subtle accent color to highlight interactive elements.

| Color Name | RGB Value | Usage |
| :--- | :--- | :--- |
| **Background** | `15, 15, 15` | Main window and container background. |
| **Secondary** | `25, 25, 25` | Default state for buttons and controls. |
| **Hover** | `35, 35, 35` | Mouse-over state for interactive elements. |
| **Active** | `20, 20, 20` | Mouse-down state for buttons. |
| **Accent** | `80, 150, 80` | Highlight color for active states (e.g., Toggle "On" state, Slider fill). |
| **Text** | `230, 230, 230` | Primary text color. |
| **Stroke** | `60, 60, 60` | Border/outline color for controls. |

## 📖 Full Usage Example

This example demonstrates the creation of a complete menu with all available components.

\`\`\`lua
-- 1. Load the library
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/LuauExploiter/Fluent-UI-Library/refs/heads/main/Fluent.lua"))()

-- 2. Create the main window
local Window = Fluent:CreateWindow({
    Title = "Fluent UI Demo",
    Size = UDim2.new(0, 450, 0, 600),
})

-- 3. Add components

-- Simple Button
Window:CreateButton({
    Text = "Click Me to Print",
    Callback = function()
        print("Button was pressed!")
    end
})

-- Toggle Switch
local myToggle = Window:CreateToggle({
    Text = "Enable Auto-Farm",
    Default = false,
    Callback = function(state)
        print("Auto-Farm is now: " .. tostring(state))
    end
})

-- Numerical Slider
local mySlider = Window:CreateSlider({
    Text = "Set WalkSpeed (10-100)",
    Min = 10,
    Max = 100,
    Default = 16,
    Callback = function(value)
        print("WalkSpeed set to: " .. value)
    end
})

-- Dropdown Menu
local myDropdown = Window:CreateDropdown({
    Text = "Select Server Region",
    Options = {"North America", "Europe", "Asia"},
    Default = "North America",
    Callback = function(selected)
        print("Region selected: " .. selected)
    end
})

-- Tab (for sectioning)
Window:CreateTab("Utility Settings")

-- Example of using the returned control objects:
-- myToggle:Set(true) -- Programmatically set the toggle to ON
-- local currentValue = mySlider:Get() -- Get the current slider value
\`\`\`

## ⚙️ API Reference

### Core Functions

#### `Fluent:CreateWindow(config)`

Creates the main UI container.

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Title` | `string` | The title text displayed on the window's title bar. | `"Fluent UI"` |
| `config.Size` | `UDim2` | The size of the main window frame. | `UDim2.new(0, 400, 0, 500)` |
| `config.Position` | `UDim2` | The initial position of the main window frame. | Centered |

**Returns:** A `Window` object with methods for adding components and managing the window.

### Window Component Methods

All methods below are called on the returned `Window` object (e.g., `Window:CreateButton(...)`).

#### `Window:CreateButton(config)`

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `config.Text` | `string` | The text displayed on the button. |
| `config.Callback` | `function` | **Required.** Function to execute when the button is clicked. |

**Returns:** Control object with utility methods: `SetText(text)`, `SetVisible(visible)`.

#### `Window:CreateToggle(config)`

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Text` | `string` | The label text for the toggle. | `"Toggle"` |
| `config.Default` | `boolean` | The initial state of the toggle. | `false` |
| `config.Callback` | `function(state)` | Function to execute when the state changes. `state` is the new boolean value. | `nil` |

**Returns:** Control object with utility methods: `Set(value)`, `Get()`.

#### `Window:CreateSlider(config)`

**Note:** The slider only supports **integer** values, as the source code uses `math.floor` on the calculated value.

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Text` | `string` | The label text for the slider. | `"Slider"` |
| `config.Min` | `number` | The minimum value of the slider. | `0` |
| `config.Max` | `number` | The maximum value of the slider. | `100` |
| `config.Default` | `number` | The initial value of the slider. | `config.Min` |
| `config.Callback` | `function(value)` | Function to execute when the value changes. `value` is the new integer value. | `nil` |

**Returns:** Control object with utility methods: `Set(val)`, `Get()`.

#### `Window:CreateDropdown(config)`

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Text` | `string` | The label text for the dropdown. | `"Dropdown"` |
| `config.Options` | `table<string>` | **Required.** A table of strings representing the selectable options. | `nil` |
| `config.Default` | `string` | The initial selected option. Must be one of the strings in `config.Options`. | First option in `config.Options` |
| `config.Callback` | `function(selected)` | Function to execute when a new option is selected. `selected` is the chosen string. | `nil` |

**Returns:** Control object with utility methods: `Set(value)`, `Get()`, `Close()`.

#### `Window:CreateTab(text)`

Creates a simple text label/button intended for use as a tab header or section divider.

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `text` | `string` | The text for the tab/section header. |

**Returns:** Control object with utility methods: `SetText(newText)`.

### Window Management Methods

These methods are used to control the window itself after creation.

| Method | Description |
| :--- | :--- |
| `Window:Destroy()` | Closes and removes the entire UI window from the game. |
| `Window:SetVisible(visible)` | Toggles the visibility of the main window frame (`true` or `false`). |
| `Window:SetPosition(position)` | Sets the position of the main window frame using a `UDim2`. |

---

## 🤝 Contributing

This is an open-source project. Contributions, bug reports, and feature suggestions are welcome! Please refer to the [CONTRIBUTING.md] file for guidelines.

## 📄 License

Fluent is released under the [MIT License]. See the `LICENSE` file for more details.

[CONTRIBUTING.md]: #
[MIT License]: #
