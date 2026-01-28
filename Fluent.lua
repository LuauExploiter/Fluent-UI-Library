-- Fluent UI Library
-- A clean, minimal UI library for Roblox

local Fluent = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Utility
local function tween(obj, props, duration)
    local tweenInfo = TweenInfo.new(duration or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, tweenInfo, props)
    tween:Play()
    return tween
end

-- Colors
local Colors = {
    Background = Color3.fromRGB(15, 15, 15),
    Secondary = Color3.fromRGB(25, 25, 25),
    Hover = Color3.fromRGB(35, 35, 35),
    Active = Color3.fromRGB(20, 20, 20),
    Stroke = Color3.fromRGB(60, 60, 60),
    Text = Color3.fromRGB(230, 230, 230),
    Accent = Color3.fromRGB(80, 150, 80)
}

-- Create Window
function Fluent:CreateWindow(config)
    local window = {}
    config = config or {}
    
    local title = config.Title or "Fluent UI"
    local size = config.Size or UDim2.new(0, 400, 0, 500)
    local position = config.Position or UDim2.new(0.5, -200, 0.5, -250)
    
    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FluentUI"
    screenGui.Parent = game:GetService("CoreGui")
    
    -- Main Window
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = size
    mainFrame.Position = position
    mainFrame.BackgroundColor3 = Colors.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", mainFrame).Color = Colors.Stroke
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundTransparency = 1
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Colors.Text
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamMedium
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    
    -- Control Buttons
    local function createControlButton(text, xPos, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 25, 0, 25)
        btn.Position = UDim2.new(1, xPos, 0.5, -12.5)
        btn.BackgroundColor3 = Colors.Secondary
        btn.Text = text
        btn.TextColor3 = Colors.Text
        btn.Font = Enum.Font.GothamBold
        btn.AutoButtonColor = false
        
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        
        btn.MouseEnter:Connect(function()
            tween(btn, {BackgroundColor3 = Colors.Hover})
        end)
        
        btn.MouseLeave:Connect(function()
            tween(btn, {BackgroundColor3 = Colors.Secondary})
        end)
        
        btn.MouseButton1Click:Connect(callback)
        return btn
    end
    
    local closeBtn = createControlButton("×", -35, function()
        screenGui:Destroy()
    end)
    closeBtn.TextSize = 20
    
    local minBtn = createControlButton("_", -65, function()
        mainFrame.Visible = not mainFrame.Visible
    end)
    minBtn.TextSize = 18
    
    -- Content Container
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -20, 1, -50)
    content.Position = UDim2.new(0, 10, 0, 40)
    content.BackgroundTransparency = 1
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 8)
    
    -- Assemble UI
    titleLabel.Parent = titleBar
    closeBtn.Parent = titleBar
    minBtn.Parent = titleBar
    titleBar.Parent = mainFrame
    contentLayout.Parent = content
    content.Parent = mainFrame
    mainFrame.Parent = screenGui
    
    -- Window API
    function window:CreateButton(config)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, 35)
        button.BackgroundColor3 = Colors.Secondary
        button.Text = config.Text or "Button"
        button.TextColor3 = Colors.Text
        button.TextSize = 14
        button.Font = Enum.Font.Gotham
        button.AutoButtonColor = false
        
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", button).Color = Colors.Stroke
        
        local hoverActive = false
        
        button.MouseEnter:Connect(function()
            hoverActive = true
            tween(button, {BackgroundColor3 = Colors.Hover})
        end)
        
        button.MouseLeave:Connect(function()
            hoverActive = false
            tween(button, {BackgroundColor3 = Colors.Secondary})
        end)
        
        button.MouseButton1Down:Connect(function()
            tween(button, {BackgroundColor3 = Colors.Active})
        end)
        
        button.MouseButton1Up:Connect(function()
            tween(button, {BackgroundColor3 = hoverActive and Colors.Hover or Colors.Secondary})
            if config.Callback then
                config.Callback()
            end
        end)
        
        button.Parent = content
        
        return {
            SetText = function(text)
                button.Text = text
            end,
            SetVisible = function(visible)
                button.Visible = visible
            end
        }
    end
    
    function window:CreateToggle(config)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, 0, 0, 35)
        toggleFrame.BackgroundTransparency = 1
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = config.Text or "Toggle"
        label.TextColor3 = Colors.Text
        label.TextSize = 14
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        
        local toggle = Instance.new("Frame")
        toggle.Size = UDim2.new(0, 50, 0, 25)
        toggle.Position = UDim2.new(1, -50, 0.5, -12.5)
        toggle.BackgroundColor3 = Colors.Secondary
        
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 21, 0, 21)
        dot.Position = UDim2.new(0, 2, 0.5, -10.5)
        dot.BackgroundColor3 = Colors.Stroke
        
        Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
        
        local state = config.Default or false
        local function update()
            if state then
                tween(dot, {Position = UDim2.new(1, -23, 0.5, -10.5)})
                tween(toggle, {BackgroundColor3 = Colors.Accent})
            else
                tween(dot, {Position = UDim2.new(0, 2, 0.5, -10.5)})
                tween(toggle, {BackgroundColor3 = Colors.Secondary})
            end
            if config.Callback then
                config.Callback(state)
            end
        end
        
        toggle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                state = not state
                update()
            end
        end)
        
        dot.Parent = toggle
        toggle.Parent = toggleFrame
        label.Parent = toggleFrame
        toggleFrame.Parent = content
        
        update()
        
        return {
            Set = function(value)
                state = value
                update()
            end,
            Get = function()
                return state
            end
        }
    end
    
    function window:CreateSlider(config)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(1, 0, 0, 60)
        sliderFrame.BackgroundTransparency = 1
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, 20)
        label.BackgroundTransparency = 1
        label.Text = config.Text or "Slider"
        label.TextColor3 = Colors.Text
        label.TextSize = 14
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(0, 50, 0, 20)
        valueLabel.Position = UDim2.new(1, -50, 0, 0)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Text = tostring(config.Default or config.Min or 0)
        valueLabel.TextColor3 = Colors.Text
        valueLabel.TextSize = 14
        valueLabel.Font = Enum.Font.Gotham
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        
        local track = Instance.new("Frame")
        track.Size = UDim2.new(1, 0, 0, 4)
        track.Position = UDim2.new(0, 0, 0, 30)
        track.BackgroundColor3 = Colors.Secondary
        
        local fill = Instance.new("Frame")
        fill.Size = UDim2.new(0, 0, 1, 0)
        fill.BackgroundColor3 = Colors.Accent
        
        local handle = Instance.new("TextButton")
        handle.Size = UDim2.new(0, 20, 0, 20)
        handle.BackgroundColor3 = Colors.Text
        handle.Text = ""
        handle.AutoButtonColor = false
        
        Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
        Instance.new("UICorner", handle).CornerRadius = UDim.new(1, 0)
        
        local min = config.Min or 0
        local max = config.Max or 100
        local value = config.Default or min
        local percent = (value - min) / (max - min)
        
        fill.Size = UDim2.new(percent, 0, 1, 0)
        handle.Position = UDim2.new(percent, -10, 0.5, -10)
        
        local dragging = false
        
        local function update(input)
            local x = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
            x = math.clamp(x, 0, 1)
            percent = x
            value = math.floor(min + (max - min) * x)
            
            fill.Size = UDim2.new(percent, 0, 1, 0)
            handle.Position = UDim2.new(percent, -10, 0.5, -10)
            valueLabel.Text = tostring(value)
            
            if config.Callback then
                config.Callback(value)
            end
        end
        
        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)
        
        handle.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                update(input)
            end
        end)
        
        track.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                update(input)
            end
        end)
        
        fill.Parent = track
        handle.Parent = track
        track.Parent = sliderFrame
        label.Parent = sliderFrame
        valueLabel.Parent = sliderFrame
        sliderFrame.Parent = content
        
        return {
            Set = function(val)
                value = math.clamp(val, min, max)
                percent = (value - min) / (max - min)
                fill.Size = UDim2.new(percent, 0, 1, 0)
                handle.Position = UDim2.new(percent, -10, 0.5, -10)
                valueLabel.Text = tostring(value)
                if config.Callback then
                    config.Callback(value)
                end
            end,
            Get = function()
                return value
            end
        }
    end
    
    function window:CreateDropdown(config)
        local dropdownFrame = Instance.new("Frame")
        dropdownFrame.Size = UDim2.new(1, 0, 0, 35)
        dropdownFrame.BackgroundTransparency = 1
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = config.Text or "Dropdown"
        label.TextColor3 = Colors.Text
        label.TextSize = 14
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 120, 0, 35)
        button.Position = UDim2.new(1, -120, 0, 0)
        button.BackgroundColor3 = Colors.Secondary
        button.Text = config.Default or config.Options[1] or "Select"
        button.TextColor3 = Colors.Text
        button.TextSize = 13
        button.Font = Enum.Font.Gotham
        button.AutoButtonColor = false
        
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", button).Color = Colors.Stroke
        
        local list = Instance.new("Frame")
        list.Size = UDim2.new(0, 120, 0, 0)
        list.Position = UDim2.new(1, -120, 1, 5)
        list.BackgroundColor3 = Colors.Secondary
        list.Visible = false
        list.ZIndex = 2
        
        Instance.new("UICorner", list).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", list).Color = Colors.Stroke
        
        local listLayout = Instance.new("UIListLayout")
        
        local selected = config.Default or config.Options[1]
        local open = false
        
        for _, option in ipairs(config.Options) do
            local optionBtn = Instance.new("TextButton")
            optionBtn.Size = UDim2.new(1, 0, 0, 30)
            optionBtn.BackgroundColor3 = Colors.Secondary
            optionBtn.Text = option
            optionBtn.TextColor3 = Colors.Text
            optionBtn.TextSize = 13
            optionBtn.Font = Enum.Font.Gotham
            optionBtn.AutoButtonColor = false
            
            optionBtn.MouseEnter:Connect(function()
                tween(optionBtn, {BackgroundColor3 = Colors.Hover})
            end)
            
            optionBtn.MouseLeave:Connect(function()
                tween(optionBtn, {BackgroundColor3 = Colors.Secondary})
            end)
            
            optionBtn.MouseButton1Click:Connect(function()
                selected = option
                button.Text = selected
                list.Visible = false
                open = false
                if config.Callback then
                    config.Callback(selected)
                end
            end)
            
            optionBtn.Parent = list
        end
        
        button.MouseEnter:Connect(function()
            tween(button, {BackgroundColor3 = Colors.Hover})
        end)
        
        button.MouseLeave:Connect(function()
            tween(button, {BackgroundColor3 = Colors.Secondary})
        end)
        
        button.MouseButton1Click:Connect(function()
            open = not open
            list.Visible = open
            list.Size = UDim2.new(0, 120, 0, #config.Options * 30)
        end)
        
        label.Parent = dropdownFrame
        button.Parent = dropdownFrame
        listLayout.Parent = list
        list.Parent = dropdownFrame
        dropdownFrame.Parent = content
        
        return {
            Set = function(value)
                selected = value
                button.Text = selected
                if config.Callback then
                    config.Callback(selected)
                end
            end,
            Get = function()
                return selected
            end,
            Close = function()
                list.Visible = false
                open = false
            end
        }
    end
    
    function window:CreateTab(text)
        local tab = Instance.new("TextButton")
        tab.Size = UDim2.new(1, 0, 0, 30)
        tab.BackgroundColor3 = Colors.Secondary
        tab.Text = text
        tab.TextColor3 = Colors.Text
        tab.TextSize = 14
        tab.Font = Enum.Font.Gotham
        tab.AutoButtonColor = false
        
        Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 6)
        
        tab.Parent = content
        
        return {
            SetText = function(newText)
                tab.Text = newText
            end
        }
    end
    
    function window:Destroy()
        screenGui:Destroy()
    end
    
    function window:SetVisible(visible)
        mainFrame.Visible = visible
    end
    
    function window:SetPosition(position)
        mainFrame.Position = position
    end
    
    return window
end

return Fluent
