-- Fluent UI Library (Upgraded Version)
-- A clean, minimal UI library for Roblox with Tab support and advanced components

local Fluent = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Utility
local function tween(obj, props, duration)
    local tweenInfo = TweenInfo.new(duration or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local t = TweenService:Create(obj, tweenInfo, props)
    t:Play()
    return t
end

-- Colors
local Colors = {
    Background = Color3.fromRGB(15, 15, 15),
    Secondary = Color3.fromRGB(25, 25, 25),
    Hover = Color3.fromRGB(35, 35, 35),
    Active = Color3.fromRGB(20, 20, 20),
    Stroke = Color3.fromRGB(60, 60, 60),
    Text = Color3.fromRGB(230, 230, 230),
    Accent = Color3.fromRGB(80, 150, 80),
    Placeholder = Color3.fromRGB(120, 120, 120)
}

-- Create Window
function Fluent:CreateWindow(config)
    local window = {
        Tabs = {},
        CurrentTab = nil
    }
    config = config or {}
    
    local title = config.Title or "Fluent UI"
    local size = config.Size or UDim2.new(0, 550, 0, 400)
    
    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FluentUI_Upgraded"
    screenGui.Parent = CoreGui
    
    -- Main Window
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = size
    mainFrame.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    mainFrame.BackgroundColor3 = Colors.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", mainFrame).Color = Colors.Stroke
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundTransparency = 1
    titleBar.Parent = mainFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.5, 0, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Colors.Text
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamMedium
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar
    
    -- Sidebar (for Tabs)
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 140, 1, -35)
    sidebar.Position = UDim2.new(0, 0, 0, 35)
    sidebar.BackgroundColor3 = Colors.Secondary
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame
    
    local sidebarCorner = Instance.new("UICorner", sidebar)
    sidebarCorner.CornerRadius = UDim.new(0, 8)
    
    -- Hide bottom corners of sidebar to blend with main frame
    local sidebarCover = Instance.new("Frame")
    sidebarCover.Size = UDim2.new(0, 8, 1, 0)
    sidebarCover.Position = UDim2.new(1, -8, 0, 0)
    sidebarCover.BackgroundColor3 = Colors.Secondary
    sidebarCover.BorderSizePixel = 0
    sidebarCover.Parent = sidebar

    local sidebarList = Instance.new("ScrollingFrame")
    sidebarList.Size = UDim2.new(1, 0, 1, -10)
    sidebarList.Position = UDim2.new(0, 0, 0, 5)
    sidebarList.BackgroundTransparency = 1
    sidebarList.BorderSizePixel = 0
    sidebarList.ScrollBarThickness = 2
    sidebarList.Parent = sidebar
    
    local sidebarLayout = Instance.new("UIListLayout")
    sidebarLayout.Padding = UDim.new(0, 2)
    sidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    sidebarLayout.Parent = sidebarList
    
    -- Container for Pages
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -150, 1, -45)
    container.Position = UDim2.new(0, 145, 0, 40)
    container.BackgroundTransparency = 1
    container.Parent = mainFrame

    -- Tab API
    function window:CreateTab(name)
        local tab = {
            Name = name,
            Button = nil,
            Page = nil
        }
        
        -- Tab Button
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(0.9, 0, 0, 32)
        tabBtn.BackgroundColor3 = Colors.Secondary
        tabBtn.BackgroundTransparency = 1
        tabBtn.Text = name
        tabBtn.TextColor3 = Colors.Placeholder
        tabBtn.TextSize = 13
        tabBtn.Font = Enum.Font.Gotham
        tabBtn.AutoButtonColor = false
        tabBtn.Parent = sidebarList
        
        Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 6)
        
        -- Page for this tab
        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.Visible = false
        page.ScrollBarThickness = 2
        page.Parent = container
        
        local pageLayout = Instance.new("UIListLayout")
        pageLayout.Padding = UDim.new(0, 8)
        pageLayout.Parent = page
        
        tab.Button = tabBtn
        tab.Page = page
        
        local function select()
            if window.CurrentTab then
                window.CurrentTab.Page.Visible = false
                tween(window.CurrentTab.Button, {BackgroundTransparency = 1, TextColor3 = Colors.Placeholder})
            end
            window.CurrentTab = tab
            page.Visible = true
            tween(tabBtn, {BackgroundTransparency = 0, TextColor3 = Colors.Text})
        end
        
        tabBtn.MouseButton1Click:Connect(select)
        
        if not window.CurrentTab then
            select()
        end
        
        -- Page API (Add components to this page)
        local pageApi = {}
        
        function pageApi:CreateButton(config)
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, 0, 0, 35)
            button.BackgroundColor3 = Colors.Secondary
            button.Text = config.Text or "Button"
            button.TextColor3 = Colors.Text
            button.TextSize = 14
            button.Font = Enum.Font.Gotham
            button.AutoButtonColor = false
            button.Parent = page
            
            Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)
            Instance.new("UIStroke", button).Color = Colors.Stroke
            
            button.MouseEnter:Connect(function() tween(button, {BackgroundColor3 = Colors.Hover}) end)
            button.MouseLeave:Connect(function() tween(button, {BackgroundColor3 = Colors.Secondary}) end)
            button.MouseButton1Down:Connect(function() tween(button, {BackgroundColor3 = Colors.Active}) end)
            button.MouseButton1Up:Connect(function() 
                tween(button, {BackgroundColor3 = Colors.Hover})
                if config.Callback then config.Callback() end
            end)
            
            return {
                SetText = function(t) button.Text = t end
            }
        end

        function pageApi:CreateToggle(config)
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Size = UDim2.new(1, 0, 0, 35)
            toggleFrame.BackgroundTransparency = 1
            toggleFrame.Parent = page
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -60, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = config.Text or "Toggle"
            label.TextColor3 = Colors.Text
            label.TextSize = 14
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = toggleFrame
            
            local toggle = Instance.new("Frame")
            toggle.Size = UDim2.new(0, 45, 0, 22)
            toggle.Position = UDim2.new(1, -45, 0.5, -11)
            toggle.BackgroundColor3 = Colors.Secondary
            toggle.Parent = toggleFrame
            
            local dot = Instance.new("Frame")
            dot.Size = UDim2.new(0, 18, 0, 18)
            dot.Position = UDim2.new(0, 2, 0.5, -9)
            dot.BackgroundColor3 = Colors.Text
            dot.Parent = toggle
            
            Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)
            Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
            
            local state = config.Default or false
            local function update()
                if state then
                    tween(dot, {Position = UDim2.new(1, -20, 0.5, -9)})
                    tween(toggle, {BackgroundColor3 = Colors.Accent})
                else
                    tween(dot, {Position = UDim2.new(0, 2, 0.5, -9)})
                    tween(toggle, {BackgroundColor3 = Colors.Secondary})
                end
                if config.Callback then config.Callback(state) end
            end
            
            toggle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    state = not state
                    update()
                end
            end)
            
            update()
            return { Set = function(v) state = v update() end, Get = function() return state end }
        end

        function pageApi:CreateSlider(config)
            local sliderFrame = Instance.new("Frame")
            sliderFrame.Size = UDim2.new(1, 0, 0, 50)
            sliderFrame.BackgroundTransparency = 1
            sliderFrame.Parent = page
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 20)
            label.BackgroundTransparency = 1
            label.Text = config.Text or "Slider"
            label.TextColor3 = Colors.Text
            label.TextSize = 14
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = sliderFrame
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 50, 0, 20)
            valueLabel.Position = UDim2.new(1, -50, 0, 0)
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(config.Default or config.Min or 0)
            valueLabel.TextColor3 = Colors.Placeholder
            valueLabel.TextSize = 13
            valueLabel.Font = Enum.Font.Gotham
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right
            valueLabel.Parent = sliderFrame
            
            local track = Instance.new("Frame")
            track.Size = UDim2.new(1, 0, 0, 4)
            track.Position = UDim2.new(0, 0, 0, 35)
            track.BackgroundColor3 = Colors.Secondary
            track.Parent = sliderFrame
            
            local fill = Instance.new("Frame")
            fill.Size = UDim2.new(0, 0, 1, 0)
            fill.BackgroundColor3 = Colors.Accent
            fill.Parent = track
            
            local handle = Instance.new("Frame")
            handle.Size = UDim2.new(0, 16, 0, 16)
            handle.BackgroundColor3 = Colors.Text
            handle.Parent = track
            
            Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
            Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
            Instance.new("UICorner", handle).CornerRadius = UDim.new(1, 0)
            
            local min, max = config.Min or 0, config.Max or 100
            local value = config.Default or min
            local dragging = false
            
            local function update(input)
                local x = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                value = math.floor(min + (max - min) * x)
                fill.Size = UDim2.new(x, 0, 1, 0)
                handle.Position = UDim2.new(x, -8, 0.5, -8)
                valueLabel.Text = tostring(value)
                if config.Callback then config.Callback(value) end
            end
            
            handle.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
            UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
            UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then update(input) end end)
            
            -- Init
            local initX = (value - min) / (max - min)
            fill.Size = UDim2.new(initX, 0, 1, 0)
            handle.Position = UDim2.new(initX, -8, 0.5, -8)
            
            return { Set = function(v) value = math.clamp(v, min, max) local x = (value-min)/(max-min) fill.Size = UDim2.new(x, 0, 1, 0) handle.Position = UDim2.new(x, -8, 0.5, -8) valueLabel.Text = tostring(value) end, Get = function() return value end }
        end

        function pageApi:CreateTextbox(config)
            local boxFrame = Instance.new("Frame")
            boxFrame.Size = UDim2.new(1, 0, 0, 35)
            boxFrame.BackgroundColor3 = Colors.Secondary
            boxFrame.Parent = page
            
            Instance.new("UICorner", boxFrame).CornerRadius = UDim.new(0, 6)
            Instance.new("UIStroke", boxFrame).Color = Colors.Stroke
            
            local box = Instance.new("TextBox")
            box.Size = UDim2.new(1, -20, 1, 0)
            box.Position = UDim2.new(0, 10, 0, 0)
            box.BackgroundTransparency = 1
            box.Text = config.Default or ""
            box.PlaceholderText = config.Placeholder or "Type here..."
            box.PlaceholderColor3 = Colors.Placeholder
            box.TextColor3 = Colors.Text
            box.TextSize = 14
            box.Font = Enum.Font.Gotham
            box.TextXAlignment = Enum.TextXAlignment.Left
            box.ClearTextOnFocus = config.Clear or false
            box.Parent = boxFrame
            
            box.FocusLost:Connect(function(enter)
                if config.Callback then config.Callback(box.Text, enter) end
            end)
            
            return { Set = function(t) box.Text = t end, Get = function() return box.Text end }
        end

        function pageApi:CreateLabel(text)
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 20)
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = Colors.Placeholder
            label.TextSize = 13
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = page
            
            return { SetText = function(t) label.Text = t end }
        end
        
        return pageApi
    end
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundColor3 = Colors.Secondary
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Colors.Text
    closeBtn.TextSize = 20
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = mainFrame
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 4)
    closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

    return window
end

return Fluent
