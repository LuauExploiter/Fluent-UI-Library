# Fluent UI Library

A clean, minimal, and feature-rich UI library for Luau (Roblox). Fluent is designed to provide a modern, dark-themed interface with smooth, responsive interactions, making it ideal for creating professional-looking in-game menus and tools.

## 🚀 Installation

Fluent is designed to be easily loaded and executed in a Luau environment using a simple `loadstring`.

To get started, execute the following line in your environment:

\`\`\`lua

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/LuauExploiter/Fluent-UI-Library/refs/heads/main/Fluent.lua"))()
\`\`\`

Once loaded, the `Fluent` table will contain the main library functions, starting with `Fluent:CreateWindow()`.

## ✨ Features

Fluent offers a comprehensive set of components styled with a consistent, dark, and minimal aesthetic. All components feature smooth **tweened animations** for hover and click states, ensuring a premium user experience.

| Component | Description |
| :--- | :--- |
| **Window** | Draggable main container with close and minimize controls. |
| **Button** | Standard click-activated button with hover and active state feedback. |
| **Toggle** | A clean switch component for boolean settings, with an accent color for the "on" state. |
| **Slider** | A numerical input slider with a visible value display, supporting custom minimum and maximum ranges. |
| **Dropdown** | A compact menu for selecting one option from a predefined list. |
| **Tab** | A simple button component, typically used for navigation within a multi-page window. |

## 📖 Usage Example

The following example demonstrates how to create a window and add the core components.

\`\`\`lua
-- 1. Load the library
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/LuauExploiter/Fluent-UI-Library/refs/heads/main/Fluent.lua"))()

-- 2. Create the main window
local Window = Fluent:CreateWindow({
    Title = "Fluent Demo Menu",
    Size = UDim2.new(0, 450, 0, 600), -- Optional: Custom size
    Position = UDim2.new(0.5, -225, 0.5, -300) -- Optional: Custom position
})

-- 3. Add components to the window

-- Button Example
Window:CreateButton({
    Text = "Execute Action",
    Callback = function()
        print("Button clicked!")
    end
})

-- Toggle Example
local MyToggle = Window:CreateToggle({
    Text = "Enable Feature X",
    Default = false, -- Optional: Initial state
    Callback = function(state)
        print("Feature X is now: " .. tostring(state))
    end
})

-- Slider Example
Window:CreateSlider({
    Text = "Set Speed",
    Min = 10,
    Max = 200,
    Default = 50,
    Callback = function(value)
        print("Speed set to: " .. value)
    end
})

-- Dropdown Example
Window:CreateDropdown({
    Text = "Select Theme",
    Options = {"Dark", "Light", "System"},
    Default = "Dark",
    Callback = function(selected)
        print("Theme changed to: " .. selected)
    end
})

-- Tab Example (Note: Tab content management is handled by the user)
Window:CreateTab("Settings")
\`\`\`

## ⚙️ API Reference

### `Fluent:CreateWindow(config)`

Creates and displays the main UI window.

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Title` | `string` | The title text displayed on the window's title bar. | `"Fluent UI"` |
| `config.Size` | `UDim2` | The size of the main window frame. | `UDim2.new(0, 400, 0, 500)` |
| `config.Position` | `UDim2` | The initial position of the main window frame. | Centered |

Returns a `Window` object.

### `Window:CreateButton(config)`

Adds a clickable button to the window.

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `config.Text` | `string` | The text displayed on the button. |
| `config.Callback` | `function` | Function to execute when the button is clicked. |

Returns a control object with methods: `SetText(text)`, `SetVisible(visible)`.

### `Window:CreateToggle(config)`

Adds a boolean toggle switch to the window.

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Text` | `string` | The label text for the toggle. | `"Toggle"` |
| `config.Default` | `boolean` | The initial state of the toggle. | `false` |
| `config.Callback` | `function(state)` | Function to execute when the state changes. `state` is the new boolean value. | `nil` |

Returns a control object with methods: `Set(value)`, `Get()`.

### `Window:CreateSlider(config)`

Adds a numerical slider control to the window.

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Text` | `string` | The label text for the slider. | `"Slider"` |
| `config.Min` | `number` | The minimum value of the slider. | `0` |
| `config.Max` | `number` | The maximum value of the slider. | `100` |
| `config.Default` | `number` | The initial value of the slider. | `config.Min` |
| `config.Callback` | `function(value)` | Function to execute when the value changes. `value` is the new integer value. | `nil` |

Returns a control object with methods: `Set(val)`, `Get()`.

### `Window:CreateDropdown(config)`

Adds a dropdown menu for selecting from a list of options.

| Parameter | Type | Description | Default |
| :--- | :--- | :--- | :--- |
| `config.Text` | `string` | The label text for the dropdown. | `"Dropdown"` |
| `config.Options` | `table<string>` | **Required.** A table of strings representing the selectable options. | `nil` |
| `config.Default` | `string` | The initial selected option. Must be one of the strings in `config.Options`. | First option in `config.Options` |
| `config.Callback` | `function(selected)` | Function to execute when a new option is selected. `selected` is the chosen string. | `nil` |

Returns a control object with methods: `Set(value)`, `Get()`, `Close()`.

### Window Utility Methods

The `Window` object also provides methods for managing the window itself:

| Method | Description |
| :--- | :--- |
| `Window:Destroy()` | Closes and cleans up the entire UI window. |
| `Window:SetVisible(visible)` | Toggles the visibility of the main window frame. |
| `Window:SetPosition(position)` | Sets the position of the main window frame using a `UDim2`. |
