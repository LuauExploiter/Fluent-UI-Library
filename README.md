# 🎨 Fluent UI Library

[![Luau UI Library](https://img.shields.io/badge/Language-Luau-blue.svg)](https://luau-lang.org/)
[![Version](https://img.shields.io/badge/Version-2.0-orange.svg)](#)
[![Loadstring](https://img.shields.io/badge/Loadstring-Available-brightgreen.svg)](https://raw.githubusercontent.com/LuauExploiter/Fluent-UI-Library/refs/heads/main/Fluent.lua)

---

## ✨ Introduction

**Fluent** is a clean, minimal, and modern UI library designed specifically for the Luau environment (Roblox). It focuses on delivering a premium user experience through a dark, consistent aesthetic and smooth, responsive interactions.

This upgraded version features a professional **Tab and Page system**, allowing you to organize your tools into multiple categories. Every component in Fluent is built with **tweened animations** for hover, active, and state changes, ensuring a polished and professional feel for your in-game menus and tools.

## 🚀 Installation

Fluent is distributed as a single-file script, making it incredibly easy to load and use in any Luau execution environment.

To get started, simply execute the following `loadstring`:

```lua
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/LuauExploiter/Fluent-UI-Library/refs/heads/main/Fluent.lua"))()
```

The `Fluent` table will be returned, providing access to the library's core function: `Fluent:CreateWindow()`.

## 🖼️ Component Showcase

Fluent provides a robust set of controls to build complex interfaces.

| Component | Description | Key Features |
| :--- | :--- | :--- |
| **Window** | The main container for your UI. | Draggable, Close/Minimize controls, Custom Title/Size/Position. |
| **Tab System** | Sidebar navigation for organizing controls. | Independent pages, Animated selection, Scalable for complex menus. |
| **Button** | A standard, interactive button. | Smooth hover/active state transitions, Callback on click. |
| **Toggle** | A clean switch for boolean settings. | Animated state change, Accent color for "On" state, State persistence. |
| **Slider** | Numerical input control. | Drag-to-change value, Displays current value, Supports Min/Max range (integer values). |
| **Dropdown** | Select one option from a list. | Animated open/close, Option list is dynamically sized, State persistence. |
| **Textbox** | Input field for text. | Placeholder text, Focus lost callback for input handling. |
| **Label** | Non-interactive text. | Used for section headers, descriptions, or static information. |

## 📖 Full Usage Example

This example demonstrates the creation of a complete menu using the new Tab system and all available components.

```lua
-- 1. Load the library
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/LuauExploiter/Fluent-UI-Library/refs/heads/main/Fluent.lua"))()

-- 2. Create the main window
local Window = Fluent:CreateWindow({
    Title = "Fluent UI Demo",
    Size = UDim2.new(0, 550, 0, 400) -- Larger size for sidebar layout
})

-- 3. Create Tabs
local MainTab = Window:CreateTab("Main Features")
local SettingsTab = Window:CreateTab("Configuration")

-- 4. Add components to the Main Tab
MainTab:CreateLabel("--- Automation ---")

MainTab:CreateToggle({
    Text = "Enable Auto-Farm",
    Default = false,
    Callback = function(state)
        print("Auto-Farm is now: " .. tostring(state))
    end
})

MainTab:CreateSlider({
    Text = "Speed Multiplier",
    Min = 10,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("Speed set to: " .. value)
    end
})

MainTab:CreateButton({
    Text = "Execute Action",
    Callback = function()
        print("Action executed!")
    end
})

-- 5. Add components to the Settings Tab
SettingsTab:CreateLabel("--- User Input ---")

SettingsTab:CreateTextbox({
    Placeholder = "Enter Webhook URL...",
    Default = "https://discord.com/...",
    Callback = function(text, enterPressed)
        print("Webhook updated to: " .. text .. " (Enter pressed: " .. tostring(enterPressed) .. ")")
    end
})

SettingsTab:CreateDropdown({
    Text = "Select Theme",
    Options = {"Dark", "Light", "System"},
    Default = "Dark",
    Callback = function(selected)
        print("Theme changed to: " .. selected)
    end
})
```

## ⚙️ API Reference

### Core Function

#### `Fluent:CreateWindow(config)`

Creates the main UI container.

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Title` | `string` | The title text displayed on the window's title bar. | `"Fluent UI"` |
| `config.Size` | `UDim2` | The size of the main window frame. | `UDim2.new(0, 550, 0, 400)` |
| `config.Position` | `UDim2` | The initial position of the main window frame. | Centered |

**Returns:** A `Window` object with methods for adding tabs and managing the window.

### Tab Management

#### `Window:CreateTab(name)`

Creates a new tab button in the sidebar and an associated page container.

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `name` | `string` | The text displayed on the tab button. |

**Returns:** A `Page` object. All components must be added using methods on this `Page` object.

### Page Component Methods

All component creation methods are called on the returned `Page` object (e.g., `MainTab:CreateButton(...)`).

#### `Page:CreateButton(config)`

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `config.Text` | `string` | The text displayed on the button. |
| `config.Callback` | `function` | **Required.** Function to execute when the button is clicked. |

**Returns:** Control object with utility methods: `SetText(text)`.

#### `Page:CreateToggle(config)`

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Text` | `string` | The label text for the toggle. | `"Toggle"` |
| `config.Default` | `boolean` | The initial state of the toggle. | `false` |
| `config.Callback` | `function(state)` | Function to execute when the state changes. `state` is the new boolean value. | `nil` |

**Returns:** Control object with utility methods: `Set(value)`, `Get()`.

#### `Page:CreateSlider(config)`

**Note:** The slider only supports **integer** values.

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Text` | `string` | The label text for the slider. | `"Slider"` |
| `config.Min` | `number` | The minimum value of the slider. | `0` |
| `config.Max` | `number` | The maximum value of the slider. | `100` |
| `config.Default` | `number` | The initial value of the slider. | `config.Min` |
| `config.Callback` | `function(value)` | Function to execute when the value changes. `value` is the new integer value. | `nil` |

**Returns:** Control object with utility methods: `Set(val)`, `Get()`.

#### `Page:CreateDropdown(config)`

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Text` | `string` | The label text for the dropdown. | `"Dropdown"` |
| `config.Options` | `table<string>` | **Required.** A table of strings representing the selectable options. | `nil` |
| `config.Default` | `string` | The initial selected option. | First option in `config.Options` |
| `config.Callback` | `function(selected)` | Function to execute when a new option is selected. | `nil` |

**Returns:** Control object with utility methods: `Set(value)`, `Get()`.

#### `Page:CreateTextbox(config)`

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Placeholder` | `string` | Text shown when the box is empty. | `"Type here..."` |
| `config.Default` | `string` | The initial text value. | `""` |
| `config.Callback` | `function(text, enterPressed)` | Function to execute when the box loses focus. | `nil` |

**Returns:** Control object with utility methods: `Set(text)`, `Get()`.

#### `Page:CreateLabel(text)`

Adds a simple, non-interactive text label.

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `text` | `string` | The text content of the label. |

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

[CONTRIBUTING.md]: ./CONTRIBUTING.md
[MIT License]: ./LICENSE
