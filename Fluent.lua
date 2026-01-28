-- Fluent UI Library v3.0 - Fixed Version
-- Premium, Minimal, and Cross-Platform (PC/Mobile)

local Fluent = {
    Options = {},
    Unloaded = false,
    Theme = {
        Main = Color3.fromRGB(15, 15, 15),
        Secondary = Color3.fromRGB(25, 25, 25),
        Hover = Color3.fromRGB(35, 35, 35),
        Active = Color3.fromRGB(20, 20, 20),
        Stroke = Color3.fromRGB(60, 60, 60),
        Text = Color3.fromRGB(230, 230, 230),
        Accent = Color3.fromRGB(80, 150, 80),
        Placeholder = Color3.fromRGB(120, 120, 120)
    }
}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- Utility
local function tween(obj, props, duration, style, dir)
    local tweenInfo = TweenInfo.new(
        duration or 0.2, 
        style or Enum.EasingStyle.Quad, 
        dir or Enum.EasingDirection.Out
    )
    local t = TweenService:Create(obj, tweenInfo, props)
    t:Play()
    return t
end

-- Notification System
local NotifyContainer = Instance.new("ScreenGui")
NotifyContainer.Name = "Fluent_Notifications"
NotifyContainer.DisplayOrder = 100
NotifyContainer.Parent = CoreGui

local NotifyList = Instance.new("Frame")
NotifyList.Size = UDim2.new(0, 300, 1, -20)
NotifyList.Position = UDim2.new(1, -310, 0, 10)
NotifyList.BackgroundTransparency = 1
NotifyList.Parent = NotifyContainer

local NotifyLayout = Instance.new("UIListLayout")
NotifyLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifyLayout.Padding = UDim.new(0, 8)
NotifyLayout.Parent = NotifyList

function Fluent:Notify(config)
    local title = config.Title or "Notification"
    local content = config.Content or ""
    local duration = config.Duration or 5
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 0)
    frame.BackgroundColor3 = Fluent.Theme.Main
    frame.ClipsDescendants = true
    frame.Parent = NotifyList
    
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Fluent.Theme.Stroke
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 20)
    titleLabel.Position = UDim2.new(0, 10, 0, 8)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Fluent.Theme.Accent
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame
    
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Size = UDim2.new(1, -20, 0, 0)
    contentLabel.Position = UDim2.new(0, 10, 0, 28)
    contentLabel.BackgroundTransparency = 1
    contentLabel.Text = content
    contentLabel.TextColor3 = Fluent.Theme.Text
    contentLabel.TextSize = 13
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextWrapped = true
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextYAlignment = Enum.TextYAlignment.Top
    contentLabel.Parent = frame
    
    local textHeight = game:GetService("TextService"):GetTextSize(content, 13, Enum.Font.Gotham, Vector2.new(280, math.huge)).Y
    contentLabel.Size = UDim2.new(1, -20, 0, textHeight)
    local targetHeight = textHeight + 40
    
    tween(frame, {Size = UDim2.new(1, 0, 0, targetHeight)}, 0.3)
    
    task.delay(duration, function()
        tween(frame, {Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1}, 0.3).Completed:Connect(function()
            frame:Destroy()
        end)
    end)
end

-- Create Window
function Fluent:CreateWindow(config)
    local window = {
        Tabs = {},
        CurrentTab = nil,
        Minimized = false
    }
    config = config or {}
    local title = config.Title or "Fluent UI"
    local size = config.Size or UDim2.new(0, 550, 0, 400)
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "Fluent_v3"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = CoreGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = size
    mainFrame.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    mainFrame.BackgroundColor3 = Fluent.Theme.Main
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
    local mainStroke = Instance.new("UIStroke", mainFrame)
    mainStroke.Color = Fluent.Theme.Stroke
    
    -- Draggable
    local dragging, dragInput, dragStart, startPos
    mainFrame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    mainFrame.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Sidebar & Container
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 140, 1, -35)
    sidebar.Position = UDim2.new(0, 0, 0, 35)
    sidebar.BackgroundColor3 = Fluent.Theme.Secondary
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -150, 1, -45)
    container.Position = UDim2.new(0, 145, 0, 40)
    container.BackgroundTransparency = 1
    container.Parent = mainFrame

    -- Controls
    local controls = Instance.new("Frame")
    controls.Size = UDim2.new(0, 60, 0, 35)
    controls.Position = UDim2.new(1, -65, 0, 0)
    controls.BackgroundTransparency = 1
    controls.Parent = mainFrame
    
    local function createControl(text, x, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 25, 0, 25)
        btn.Position = UDim2.new(0, x, 0.5, -12.5)
        btn.BackgroundColor3 = Fluent.Theme.Secondary
        btn.Text = text
        btn.TextColor3 = Fluent.Theme.Text
        btn.Font = Enum.Font.GothamBold
        btn.AutoButtonColor = false
        btn.Parent = controls
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end
    
    createControl("×", 30, function()
        tween(mainFrame, {Size = UDim2.new(0, size.X.Offset, 0, 0), Position = mainFrame.Position + UDim2.new(0, 0, 0, size.Y.Offset/2)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In).Completed:Connect(function()
            screenGui:Destroy()
        end)
    end)
    
    createControl("-", 0, function()
        window.Minimized = not window.Minimized
        if window.Minimized then
            tween(mainFrame, {Size = UDim2.new(0, size.X.Offset, 0, 35)}, 0.3)
        else
            tween(mainFrame, {Size = size}, 0.3)
        end
    end)

    -- Tab System
    local sidebarList = Instance.new("UIListLayout", sidebar)
    sidebarList.Padding = UDim.new(0, 5)
    sidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    function window:CreateTab(name)
        local tab = {Page = Instance.new("ScrollingFrame")}
        tab.Page.Size = UDim2.new(1, 0, 1, 0)
        tab.Page.BackgroundTransparency = 1
        tab.Page.Visible = false
        tab.Page.ScrollBarThickness = 0
        tab.Page.Parent = container
        Instance.new("UIListLayout", tab.Page).Padding = UDim.new(0, 8)
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 32)
        btn.BackgroundColor3 = Fluent.Theme.Secondary
        btn.BackgroundTransparency = 1
        btn.Text = name
        btn.TextColor3 = Fluent.Theme.Placeholder
        btn.Font = Enum.Font.Gotham
        btn.Parent = sidebar
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        
        local function select()
            if window.CurrentTab then
                window.CurrentTab.Page.Visible = false
                tween(window.CurrentTab.Button, {BackgroundTransparency = 1, TextColor3 = Fluent.Theme.Placeholder})
            end
            window.CurrentTab = tab
            tab.Page.Visible = true
            tween(btn, {BackgroundTransparency = 0, TextColor3 = Fluent.Theme.Text})
        end
        
        btn.MouseButton1Click:Connect(select)
        tab.Button = btn
        if not window.CurrentTab then select() end
        
        -- Page Components
        local page = {}
        
        function page:CreateToggle(config)
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 0, 35)
            frame.BackgroundTransparency = 1
            frame.Parent = tab.Page
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -50, 1, 0)
            label.Text = config.Text or "Toggle"
            label.TextColor3 = Fluent.Theme.Text
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame
            
            local box = Instance.new("TextButton")
            box.Size = UDim2.new(0, 40, 0, 20)
            box.Position = UDim2.new(1, -40, 0.5, -10)
            box.BackgroundColor3 = Fluent.Theme.Secondary
            box.Text = ""
            box.Parent = frame
            Instance.new("UICorner", box).CornerRadius = UDim.new(1, 0)
            
            local dot = Instance.new("Frame")
            dot.Size = UDim2.new(0, 16, 0, 16)
            dot.Position = UDim2.new(0, 2, 0.5, -8)
            dot.BackgroundColor3 = Fluent.Theme.Text
            dot.Parent = box
            Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
            
            local state = config.Default or false
            local function update()
                if state then
                    tween(dot, {Position = UDim2.new(1, -18, 0.5, -8)})
                    tween(box, {BackgroundColor3 = Fluent.Theme.Accent})
                else
                    tween(dot, {Position = UDim2.new(0, 2, 0.5, -8)})
                    tween(box, {BackgroundColor3 = Fluent.Theme.Secondary})
                end
                if config.Callback then config.Callback(state) end
            end
            
            box.MouseButton1Click:Connect(function()
                state = not state
                update()
            end)
            
            update()
            return {Set = function(v) state = v update() end}
        end

        function page:CreateSlider(config)
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 0, 45)
            frame.BackgroundTransparency = 1
            frame.Parent = tab.Page
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 20)
            label.Text = config.Text or "Slider"
            label.TextColor3 = Fluent.Theme.Text
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame
            
            local track = Instance.new("TextButton")
            track.Size = UDim2.new(1, 0, 0, 6)
            track.Position = UDim2.new(0, 0, 0, 30)
            track.BackgroundColor3 = Fluent.Theme.Secondary
            track.Text = ""
            track.Parent = frame
            Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
            
            local fill = Instance.new("Frame")
            fill.Size = UDim2.new(0, 0, 1, 0)
            fill.BackgroundColor3 = Fluent.Theme.Accent
            fill.Parent = track
            Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
            
            local min, max = config.Min or 0, config.Max or 100
            local value = config.Default or min
            
            local function update(input)
                local x = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                value = math.floor(min + (max - min) * x)
                tween(fill, {Size = UDim2.new(x, 0, 1, 0)}, 0.1)
                if config.Callback then config.Callback(value) end
            end
            
            local dragging = false
            track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    update(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    update(input)
                end
            end)
            
            -- Init
            local initX = (value - min) / (max - min)
            fill.Size = UDim2.new(initX, 0, 1, 0)
            
            return {Set = function(v) value = v local x = (v-min)/(max-min) tween(fill, {Size = UDim2.new(x, 0, 1, 0)}, 0.1) end}
        end

        function page:CreateButton(config)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 35)
            btn.BackgroundColor3 = Fluent.Theme.Secondary
            btn.Text = config.Text or "Button"
            btn.TextColor3 = Fluent.Theme.Text
            btn.Font = Enum.Font.Gotham
            btn.Parent = tab.Page
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            
            btn.MouseEnter:Connect(function() tween(btn, {BackgroundColor3 = Fluent.Theme.Hover}) end)
            btn.MouseLeave:Connect(function() tween(btn, {BackgroundColor3 = Fluent.Theme.Secondary}) end)
            btn.MouseButton1Click:Connect(function()
                tween(btn, {BackgroundColor3 = Fluent.Theme.Active}, 0.1):Completed:Connect(function()
                    tween(btn, {BackgroundColor3 = Fluent.Theme.Hover}, 0.1)
                end)
                if config.Callback then config.Callback() end
            end)
            return btn
        end

        return page
    end
    
    return window
end

return Fluent
