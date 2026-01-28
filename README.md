# 🎨 Fluent UI Library (v3.0 - Premium Edition)

[![Luau UI Library](https://img.shields.io/badge/Language-Luau-blue.svg)](https://luau-lang.org/)
[![Version](https://img.shields.io/badge/Version-3.0-brightgreen.svg)](#)
[![Loadstring](https://img.shields.io/badge/Loadstring-Available-brightgreen.svg)](https://raw.githubusercontent.com/LuauExploiter/Fluent-UI-Library/refs/heads/main/Fluent.lua)

---

## ✨ Introduction

**Fluent v3.0** is a complete overhaul, delivering a premium, minimal, and highly functional UI library for Luau (Roblox). This version focuses on a polished user experience with **smooth, clean animations**, **cross-platform compatibility** (PC and Mobile), and essential features like a **Notification System** and a **functional Tab/Page architecture**.

All previous functional issues, such as the non-working toggles, have been resolved.

## 🚀 Key Features in v3.0

| Feature | Description | Status |
| :--- | :--- | :--- |
| **Premium Animations** | Smoother, cleaner animations for all component states (hover, active) and window controls (close, minimize). | **Implemented** |
| **Notification System** | Non-intrusive, timed notifications that stack in the corner of the screen. | **Implemented** |
| **Cross-Platform Sliders** | Sliders now correctly handle both mouse (PC) and touch (Mobile) input. | **Implemented** |
| **Functional Toggles** | Toggle components are now fully functional and visually responsive. | **Fixed** |
| **Window Controls** | Added functional minimize/restore and a smooth closing animation. | **Implemented** |
| **Tab/Page System** | Organize controls into independent, scrollable pages via a sidebar. | **Implemented** |

## 📖 Usage Example

This example demonstrates the core functionality of Fluent v3.0, including the new Notification system.

```lua
-- 1. Load the library
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/LuauExploiter/Fluent-UI-Library/refs/heads/main/Fluent.lua"))()

-- 2. Create the main window
local Window = Fluent:CreateWindow({
    Title = "Fluent UI v3.0 Demo",
    Size = UDim2.new(0, 550, 0, 400)
})

-- 3. Create Tabs
local MainTab = Window:CreateTab("Main")
local NotificationsTab = Window:CreateTab("Notifications")

-- 4. Add components to the Main Tab
MainTab:CreateToggle({
    Text = "Enable Feature X",
    Default = false,
    Callback = function(state)
        Fluent:Notify({
            Title = "Feature Status",
            Content = "Feature X is now " .. (state and "ENABLED" or "DISABLED"),
            Duration = 3
        })
    end
})

MainTab:CreateSlider({
    Text = "Set Value (PC/Mobile)",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        -- Note: Slider value is now an integer
    end
})

-- 5. Add components to the Notifications Tab
NotificationsTab:CreateButton({
    Text = "Show Simple Notification",
    Callback = function()
        Fluent:Notify({
            Title = "System Alert",
            Content = "This is a simple, non-intrusive notification.",
            Duration = 5
        })
    end
})

NotificationsTab:CreateButton({
    Text = "Show Long Notification",
    Callback = function()
        Fluent:Notify({
            Title = "Long Message",
            Content = "This notification has a longer message to demonstrate auto-sizing and stacking functionality. It will disappear after 8 seconds.",
            Duration = 8
        })
    end
})
```

## ⚙️ API Reference

### Core Functions

#### `Fluent:CreateWindow(config)`

Creates the main UI container.

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Title` | `string` | The title text displayed on the window's title bar. | `"Fluent UI"` |
| `config.Size` | `UDim2` | The size of the main window frame. | `UDim2.new(0, 550, 0, 400)` |

**Returns:** A `Window` object with methods for adding tabs and managing the window.

#### `Fluent:Notify(config)`

Displays a temporary, non-intrusive notification in the bottom-right corner.

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Title` | `string` | The bold title of the notification. | `"Notification"` |
| `config.Content` | `string` | The main body text of the notification. | `""` |
| `config.Duration` | `number` | The time in seconds before the notification fades out. | `5` |

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

#### `Page:CreateToggle(config)`

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Text` | `string` | The label text for the toggle. | `"Toggle"` |
| `config.Default` | `boolean` | The initial state of the toggle. | `false` |
| `config.Callback` | `function(state)` | Function to execute when the state changes. `state` is the new boolean value. | `nil` |

#### `Page:CreateSlider(config)`

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Text` | `string` | The label text for the slider. | `"Slider"` |
| `config.Min` | `number` | The minimum value of the slider. | `0` |
| `config.Max` | `number` | The maximum value of the slider. | `100` |
| `config.Default` | `number` | The initial value of the slider. | `config.Min` |
| `config.Callback` | `function(value)` | Function to execute when the value changes. `value` is the new integer value. | `nil` |

---

## 🤝 Contributing

This is an open-source project. Contributions, bug reports, and feature suggestions are welcome! Please refer to the [CONTRIBUTING.md] file for guidelines.

## 📄 License

Fluent is released under the [MIT License]. See the `LICENSE` file for more details.

[CONTRIBUTING.md]: ./CONTRIBUTING.md
[MIT License]: ./LICENSE
