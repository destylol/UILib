local Library = {}
local CoreGui = game:GetService("CoreGui")
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local input = game:GetService("UserInputService")
local CoreGuiService = game:GetService("CoreGui")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local ContentService = game:GetService("ContentProvider")

-- [[ Delay Is Optional ]] 
function Tween(object, properties,delay)
    if delay == nil then delay = .25 end 
    return game:GetService("TweenService"):Create(object, TweenInfo.new(delay,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),properties):Play()
end
-- [[ Object and Type are required ]]
function CheckType(object, type)
    if typeof(object) ~= type then
        error(type .. " expected (got: " .. typeof(object) .. ") 3BD")
    end
end
-- [[ Object and Type are required ]]
function CheckIfNill(object, type)
    if object == nil then 
            error(type .. " expected (got: nil) 3BD")
    end
end
function Do_Get_Connections()
    for i, v in ipairs(getconnections(game:GetService('UserInputService').InputBegan)) do
        local f = v.Function
        if (f) then
            local scr = getfenv(f).script
            if (not scr:IsDescendantOf(game.CoreGui)) then 
                v:Disable() 
            end
        end
    end
end
-- [[ Object and Color are required ]]
function AddShadow(object, color)
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = tostring(math.floor(math.random(100000,900000)))
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "https://www.roblox.com/asset/?id=5554236805"
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(23,23,277,277)
    Shadow.Size = UDim2.fromScale(1,1) + UDim2.fromOffset(30,30)
    Shadow.Position = UDim2.fromOffset(-15,-15)
    Shadow.ImageColor3 = color
    Shadow.Parent = object
    Shadow.ZIndex = 9e6
    return Shadow
end
-- [[ Animation Stuff ]]
local function GetXY(GuiObject)
	local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
	return Px/Max, Py/May
end
local function CircleAnim(GuiObject, EndColour, StartColour)
	local PX, PY = GetXY(GuiObject)
	local Circle = Instance.new("ImageLabel")
    Circle.BackgroundTransparency = 1
	Circle.Image = "http://www.roblox.com/asset/?id=5554831670"
	Circle.Size = UDim2.fromScale(0,0)
	Circle.Position = UDim2.fromScale(PX,PY)
	Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
	Circle.ZIndex = 200
	Circle.Parent = GuiObject
	local Size = GuiObject.AbsoluteSize.X
	game:GetService("TweenService"):Create(Circle, TweenInfo.new(1), {Position = UDim2.fromScale(PX,PY) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, ImageColor3 = EndColour, Size = UDim2.fromOffset(Size,Size)}):Play()
	spawn(function()
		wait(2)
		Circle:Destroy()
	end)
end
-- [[ Enables Dragging ]]
function DraggingEnabled(frame, parent)    
    parent = parent or frame
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end
function pause(wait)
    local old = os.clock()
    spawn(function()
        while true do
            if (os.clock() - old) >= wait then
                break
            end
        end
    end)
end
function Library.ToggleUI()
    CoreGui["DarkT"].Enabled = not CoreGui['DarkT'].Enabled
end
-- [[ Find all instances of Lib ]]
for i,v in pairs(CoreGui:GetChildren()) do if v:IsA("ScreenGui") and v.Name == "DarkT" then Debris:AddItem(v,0) end end 
Do_Get_Connections()
function Library.Project()

    pause(2)
    local Dark = Instance.new("ScreenGui")
    local Motherframe = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Header = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local Cover = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local close = Instance.new("ImageButton")
    local Border = Instance.new("Frame")
    local Tabs = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local UIPadding = Instance.new("UIPadding")
    local Pages = Instance.new("Folder")

    Dark.Name = "DarkT"
    Dark.Parent = CoreGui
    Dark.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    Motherframe.Name = "Motherframe"
    Motherframe.Parent = Dark
    Motherframe.AnchorPoint = Vector2.new(0.5, 0.5)
    Motherframe.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
    Motherframe.Position = UDim2.new(.475,0,.499,0)
    Motherframe.Size = UDim2.new(0, 592,0,409)
    
    AddShadow(Motherframe,Color3.fromRGB(0,0,0))

    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Motherframe
    
    Header.Name = "Header"
    Header.Parent = Motherframe
    Header.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
    Header.Size = UDim2.new(0, 592, 0, 21)
    
    DraggingEnabled(Header,Motherframe)

    UICorner_2.CornerRadius = UDim.new(0, 4)
    UICorner_2.Parent = Header
    
    Cover.Name = "Cover"
    Cover.Parent = Header
    Cover.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
    Cover.BorderSizePixel = 0
    Cover.Position = UDim2.new(0, 0, 0.75, 0)
    Cover.Size = UDim2.new(0, 592, 0, 15)
    
    Title.Name = "Title"
    Title.Parent = Header
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.BorderColor3 = Color3.fromRGB(163, 162, 165)
    Title.Position = UDim2.new(0.0117994305, 0, -0.0476190485, 0)
    Title.Size = UDim2.new(0, 200, 0, 32)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "<font color= \"rgb(69,91,123)\"></font>MH"
    Title.TextColor3 = Color3.fromRGB(230, 230, 230)
    Title.TextSize = 15.000
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.RichText = true 

    close.Name = "close"
    close.Parent = Header
    close.BackgroundTransparency = 1.000
    close.BorderColor3 = Color3.fromRGB(163, 162, 165)
    close.Position = UDim2.new(0.961117744, 0, 0.149963379, 0)
    close.Size = UDim2.new(0, 19, 0, 25)
    close.ZIndex = 2
    close.Image = "rbxassetid://3926305904"
    close.ImageColor3 = Color3.fromRGB(245, 245, 245)
    close.ImageRectOffset = Vector2.new(284, 4)
    close.ImageRectSize = Vector2.new(24, 24)
    close.ScaleType = Enum.ScaleType.Fit
    
    Border.Name = "Border"
    Border.Parent = Header
    Border.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    Border.BorderColor3 = Color3.fromRGB(55, 55, 55)
    Border.Position = UDim2.new(0.072, 0, 0.285714298, 0)
    Border.Size = UDim2.new(0, 0, 0, 18)
    
    Tabs.Name = "Tabs"
    Tabs.Parent = Header
    Tabs.Active = true
    Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tabs.BackgroundTransparency = 1.000
    Tabs.Position = UDim2.new(0, 0,0.286, 0)
    Tabs.Size = UDim2.new(0, 592, 0, 286)
    Tabs.CanvasSize = UDim2.new(0, 0, 0, 0)
    Tabs.VerticalScrollBarInset = Enum.ScrollBarInset.Always
    
    UIListLayout.Parent = Tabs
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIPadding.Parent = Tabs
    
    Pages.Name = "Pages"
    Pages.Parent = Motherframe
    
    local t = {}
    function t:Tab(settings)
        CheckIfNill(settings,"table")
        CheckType(settings,"table")
        local text = string.upper(settings.Text) or "NEW TAB"
        CheckIfNill(text,"string")
        CheckType(text,"string")
        local Tab = Instance.new("TextButton")
        local Page = Instance.new("ScrollingFrame")
        local UIList = Instance.new("UIListLayout")
        local UIPad = Instance.new("UIPadding")

        Tab.Name = "Tab"

        Tab.Parent = Tabs
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.Size = UDim2.new(0, 48, 0, 17)
        Tab.Font = Enum.Font.GothamBold
        Tab.Text = text
        Tab.TextColor3 = Color3.fromRGB(230, 230, 230)
        Tab.TextSize = 12.000
        Tab.AutomaticSize = Enum.AutomaticSize.X
        
        Page.Name = "Page"
        Page.Parent = Pages
        Page.Active = true
        Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Page.BackgroundTransparency = 1.000
        Page.BorderSizePixel = 0
        Page.Position = UDim2.new(0, 0, 0.0684596598, 0)
        Page.Size = UDim2.new(0, 592, 0, 381)
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.ScrollBarThickness = 5
        Page.ScrollBarImageColor3 = Color3.fromRGB(65,65,65)
    
        UIList.Parent = Page
        UIList.Padding = UDim.new(0,6)
        UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

        task.spawn(function()
            while wait() do
                Page.CanvasSize = UDim2.new(0,0,0,UIList.AbsoluteContentSize.Y + 21)
            end
        end)

        UIPad.Parent = Page
        UIPad.PaddingTop = UDim.new(0,9)
    
        PageIndex = 0
        TabIndex = 0 

        for i,v in pairs(Pages:GetChildren()) do
            PageIndex = PageIndex + 1 
            v.Name = "Page" .. tostring(PageIndex)
            if v.Name ~= "Page1" then
                v.Visible = false 
            end
        end
        for i,v in pairs(Tabs:GetChildren()) do
           if v:IsA("TextButton") then
            TabIndex = TabIndex + 1 
            v.Name = "Tab" .. tostring(TabIndex)
            if v.Name ~= "Tab1" then
                v.TextColor3 = Color3.fromRGB(150,150,150) 
              end
            end 
        end

        Tab.MouseButton1Click:Connect(function()
            for i,v in pairs(Tabs:GetChildren()) do
                if v:IsA("TextButton") then
                    Tween(v, {TextColor3 = Color3.fromRGB(150,150,150)})
                 end 
             end
             Tween(Tab, { TextColor3 = Color3.fromRGB(230,230,230) })
             for i,v in pairs(Pages:GetChildren()) do
                 v.Visible = false 
             end
             wait(.1)
             Page.Visible = true
        end)

        local Sections = {}
        function Sections:Section(settings)
            CheckIfNill(settings,"table")
            CheckType(settings,"table")
            local text = string.upper(settings.Text) or "NEW SECTION"
            CheckIfNill(text,"string")
            CheckType(text,"string")

            local SectionContainer = Instance.new("Frame")
            local layout = Instance.new("UIListLayout")
            local lbl = Instance.new("TextLabel")

            SectionContainer.Name = "SectionContainer"
            SectionContainer.Parent = Page
            SectionContainer.Size = UDim2.new(0,592,0,38)
            SectionContainer.BackgroundTransparency = 1 

            lbl.Name = "lbl"
            lbl.Parent = SectionContainer
            lbl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            lbl.BackgroundTransparency = 1.000
            lbl.BorderColor3 = Color3.fromRGB(27, 42, 53)
            lbl.Size = UDim2.new(0, 580, 0, 14)
            lbl.Font = Enum.Font.GothamBold
            lbl.Text = text
            lbl.TextColor3 = Color3.fromRGB(125, 125, 125)
            lbl.TextSize = 12.000
            lbl.TextXAlignment = Enum.TextXAlignment.Left
                
            layout.Parent = SectionContainer
            layout.Name = "Layout"
            layout.Padding = UDim.new(0,8)
            layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            layout.VerticalAlignment =Enum.VerticalAlignment.Top
             layout.SortOrder = Enum.SortOrder.LayoutOrder

            layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                TweenService:Create(SectionContainer,TweenInfo.new(.01),{Size = UDim2.new(0,592,0,layout.AbsoluteContentSize.Y)}):Play()
            end)
            --[[ 
                local function AB(v)
    local DropItem = Instance.new("TextButton")
    local TextboxTitle_2 = Instance.new("TextLabel")
    
    
    DropItem.Name = "DropItem"
DropItem.Parent = Dropdown
 = Color3.fromRGB(47, 47, 47)
DropItem.BorderColor3 = Color3.fromRGB(27, 42, 53)
DropItem.BorderSizePixel = 0
DropItem.Position = UDim2.new(0, 0, 0.443298966, 0)
DropItem.Size = UDim2.new(0, 411, 0, 31)
DropItem.AutoButtonColor = false
DropItem.Font = Enum.Font.SourceSans
DropItem.Text = ""
DropItem.TextColor3 = Color3.fromRGB(0, 0, 0)
DropItem.TextSize = 14.000

TextboxTitle_2.Name = "TextboxTitle"
TextboxTitle_2.Parent = DropItem
TextboxTitle_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextboxTitle_2.BackgroundTransparency = 1.000
TextboxTitle_2.Position = UDim2.new(0.0264701005, 0, 0, 0)
TextboxTitle_2.Size = UDim2.new(0, 403, 0, 31)
TextboxTitle_2.Font = Enum.Font.GothamBold
TextboxTitle_2.Text = v 
TextboxTitle_2.TextColor3 = Color3.fromRGB(200, 200, 200)
TextboxTitle_2.TextSize = 13.000
TextboxTitle_2.TextXAlignment = Enum.TextXAlignment.Left

DropItem.MouseEnter:Connect(function(x, y)
    Tween(DropItem,{ BackgroundColor3 = Color3.fromRGB(55,55,55 )},.125)
end)
DropItem.MouseLeave:Connect(function(x, y)
    Tween(DropItem,{ BackgroundColor3 = Color3.fromRGB(47,47,47 )},.125)
end)
DropItem.MouseButton1Click:Connect(function()
    pcall(callback, TextboxTitle_2.Text)
    TextboxTitle.Text = text .. " " .. TextboxTitle_2.Text
    Tween(Dropdown, { Size = UDim2.new(0, 411, 0, 93) },.1)
    Tween(expand_less, { Rotation = 0 },.1)
    Dropped = false 
end)   
end
--]]


            local Elements = {}
            function Elements:Button(settings)
                CheckIfNill(settings,"table")
                CheckType(settings,"table")
                local text = settings.Text or "New Button"
                CheckIfNill(text,"string")
                CheckType(text,"string")
                local callback = settings.Callback or function() end 
                CheckIfNill(callback, "function")
                CheckType(callback,"function")

                local ButtonElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local BtnTitle = Instance.new("TextLabel")


                ButtonElement.Name = "ButtonElement"
                ButtonElement.Parent = SectionContainer
                ButtonElement.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
                ButtonElement.Position = UDim2.new(0.135693222, 0, 0, 0)
                ButtonElement.Size = UDim2.new(0, 414, 0, 38)
                ButtonElement.AutoButtonColor = false
                ButtonElement.Font = Enum.Font.SourceSans
                ButtonElement.Text = ""
                ButtonElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                ButtonElement.TextSize = 14.000
                ButtonElement.ClipsDescendants = true

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = ButtonElement

                BtnTitle.Name = "BtnTitle"
                BtnTitle.Parent = ButtonElement
                BtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BtnTitle.BackgroundTransparency = 1.000
                BtnTitle.Position = UDim2.new(0.0241545886, 0, 0, 0)
                BtnTitle.Size = UDim2.new(0, 404, 0, 38)
                BtnTitle.Font = Enum.Font.GothamBold
                BtnTitle.Text = text
                BtnTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
                BtnTitle.TextSize = 13.000
                BtnTitle.TextXAlignment = Enum.TextXAlignment.Left
                   
                ButtonElement.MouseEnter:Connect(function(x, y)
                    Tween(ButtonElement,{ BackgroundColor3 = Color3.fromRGB(47,47,47 )},.125)
                end)
                ButtonElement.MouseLeave:Connect(function(x, y)
                    Tween(ButtonElement,{ BackgroundColor3 = Color3.fromRGB(41,41,41 )},.125)
                end)
                ButtonElement.MouseButton1Click:Connect(function()
                    pcall(callback)
                    CircleAnim(ButtonElement,Color3.fromRGB(150,150,150),Color3.fromRGB(65,65,65))
                end)
            end
            
            function Elements:Label(settings)
                local text = settings.Text or 'Text Label'
                
                local TextElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local TextTitle = Instance.new("TextLabel")


                TextElement.Name = "TextElement"
                TextElement.Parent = SectionContainer
                TextElement.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
                TextElement.Position = UDim2.new(0.135693222, 0, 0, 0)
                TextElement.Size = UDim2.new(0, 414, 0, 38)
                TextElement.AutoButtonColor = false
                TextElement.Font = Enum.Font.SourceSans
                TextElement.Text = ""
                TextElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                TextElement.TextSize = 14.000
                TextElement.ClipsDescendants = true

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = TextElement

                TextTitle.Name = "TextTitle"
                TextTitle.Parent = TextElement
                TextTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextTitle.BackgroundTransparency = 1.000
                TextTitle.Position = UDim2.new(0.0241545886, 0, 0, 0)
                TextTitle.Size = UDim2.new(0, 404, 0, 38)
                TextTitle.Font = Enum.Font.GothamBold
                TextTitle.Text = text
                TextTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
                TextTitle.TextSize = 13.000
                TextTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                local text_functions = {}
                
                function text_functions:UpdateLabel(text)
                    TextTitle.Text = text
                end
                
                return text_functions
            end
            
            function Elements:Toggle(settings)
                
                CheckIfNill(settings,"table")
                CheckType(settings,"table")
                local text = settings.Text or "New Button"
                CheckIfNill(text,"string")
                CheckType(text,"string")
                local Default = settings.Default or false
                CheckIfNill(Default,"boolean")
                CheckType(Default,"boolean")
                local callback = settings.Callback or function() end 
                CheckIfNill(callback, "function")
                CheckType(callback,"function")

                    local Toggle = Instance.new("Frame")
                    local UICorner = Instance.new("UICorner")
                    local TogTitle = Instance.new("TextLabel")
                    local Tracker = Instance.new("ImageLabel")
                    local Dot = Instance.new("ImageLabel")
                    local ToggleButton = Instance.new("TextButton")


                    Toggle.Name = "Toggle"
                    Toggle.Parent = SectionContainer
                    Toggle.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
                    Toggle.Size = UDim2.new(0, 414, 0, 38)

                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = Toggle

                    TogTitle.Name = "TogTitle"
                    TogTitle.Parent = Toggle
                    TogTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TogTitle.BackgroundTransparency = 1.000
                    TogTitle.Position = UDim2.new(0.0241545886, 0, 0, 0)
                    TogTitle.Size = UDim2.new(0, 404, 0, 38)
                    TogTitle.Font = Enum.Font.GothamBold
                    TogTitle.Text = text
                    TogTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
                    TogTitle.TextSize = 13.000
                    TogTitle.TextXAlignment = Enum.TextXAlignment.Left
                    TogTitle.ClipsDescendants = true

                    Tracker.Name = "Tracker"
                    Tracker.Parent = Toggle
                    Tracker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Tracker.BackgroundTransparency = 1.000
                    Tracker.Position = UDim2.new(0.806763291, 41, 0.184210539, 6)
                    Tracker.Size = UDim2.new(0, 26, 0, 12)
                    Tracker.Image = "rbxassetid://3570695787"
                    Tracker.ImageColor3 = Color3.fromRGB(30, 30, 30)
                    Tracker.ScaleType = Enum.ScaleType.Slice
                    Tracker.SliceCenter = Rect.new(100, 100, 100, 100)

                    Dot.Name = "Dot"
                    Dot.Parent = Tracker
                    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Dot.BackgroundTransparency = 1.000
                    Dot.Position = UDim2.new(0, -8, 0.5, -8)
                    Dot.Size = UDim2.new(0, 16, 0, 16)
                    Dot.Image = "rbxassetid://3570695787"
                    Dot.ImageColor3 = Color3.fromRGB(193, 193, 193)

                    ToggleButton.Name = "ToggleButton"
                    ToggleButton.Parent = Toggle
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleButton.BackgroundTransparency = 1.000
                    ToggleButton.Size = UDim2.new(0, 414, 0, 38)
                    ToggleButton.Font = Enum.Font.SourceSans
                    ToggleButton.Text = ""
                    ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    ToggleButton.TextSize = 14.000

                    TweenService:Create(Dot, TweenInfo.new(0.15), {Position = (Default and UDim2.fromScale(1,0.5) or UDim2.fromScale(0,0.5)) - UDim2.fromOffset(8,8), ImageColor3 = Default and Color3.fromRGB(65,65,65) or Color3.fromRGB(150,150,150)}):Play()
                    pcall(callback,Default)


                    ToggleButton.MouseButton1Click:Connect(function()
                        Default = not Default
                        TweenService:Create(Dot, TweenInfo.new(0.15), {Position = (Default and UDim2.fromScale(1,0.5) or UDim2.fromScale(0,0.5)) - UDim2.fromOffset(8,8), ImageColor3 = Default and Color3.fromRGB(65,65,65) or Color3.fromRGB(150,150,150)}):Play()
                        pcall(callback,Default)
                        CircleAnim(TogTitle, Color3.fromRGB(150,150,150), Color3.fromRGB(65,65,65))
                    end)
            end

            function Elements:Textbox(settings)
                CheckIfNill(settings,"table")
                CheckType(settings,"table")
                local text = settings.Text or "New Textbox"
                CheckIfNill(text,"string")
                CheckType(text,"string")
                local Default = settings.PText or ""
                CheckIfNill(Default,"string")
                CheckType(Default,"string")
                local callback = settings.Callback or function() end 
                CheckIfNill(callback, "function")
                CheckType(callback,"function")

            local Textbox = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local InputBox = Instance.new("TextBox")
            local UICorner_2 = Instance.new("UICorner")
            local TextboxTitle = Instance.new("TextLabel")
            local tbbutton = Instance.new("TextButton")
            --Properties:

            Textbox.Name = "Textbox"
            Textbox.Parent = SectionContainer
            Textbox.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
            Textbox.Position = UDim2.new(0.150337845, 0, 0.235924929, 0)
            Textbox.Size = UDim2.new(0, 409, 0, 38)
            Textbox.ClipsDescendants = true

            tbbutton.Name = "tbbutton"
            tbbutton.Parent = Textbox
            tbbutton.BackgroundTransparency =1 
            tbbutton.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
            tbbutton.Position = UDim2.new(0.150337845, 0, 0.235924929, 0)
            tbbutton.Size = UDim2.new(0, 409, 0, 38)

            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Textbox

            InputBox.Name = "InputBox"
            InputBox.Parent = Textbox
            InputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            InputBox.ClipsDescendants = true
            InputBox.Position = UDim2.new(0.683168292, 0, 0.210526317, 0)
            InputBox.Size = UDim2.new(0, 120, 0, 22)
            InputBox.Font = Enum.Font.Gotham
            InputBox.Text = ""
            InputBox.TextColor3 = Color3.fromRGB(200, 200, 200)
            InputBox.TextSize = 14.000
            InputBox.PlaceholderText = Default
            InputBox.PlaceholderColor3 = Color3.fromRGB(150,150,150)


            UICorner_2.CornerRadius = UDim.new(0, 4)
            UICorner_2.Parent = InputBox

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0.0241545886, 0, 0, 0)
            TextboxTitle.Size = UDim2.new(0, 404, 0, 38)
            TextboxTitle.Font = Enum.Font.GothamBold
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
            TextboxTitle.TextSize = 13.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            tbbutton.MouseButton1Click:Connect(function()
               InputBox:CaptureFocus()
               CircleAnim(Textbox, Color3.fromRGB(135,135,135), Color3.fromRGB(65,65,65))
            end)
            InputBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
                if enterPressed then
                    pcall(callback, InputBox.Text)
                end
            end)
            end
            function Elements:Slider(settings)
                CheckIfNill(settings,"table")
                CheckType(settings,"table")
                local text = settings.Text or "New Slider"
                CheckIfNill(text,"string")
                CheckType(text,"string")
                local Min = settings.Min or 16 
                CheckIfNill(Min,"number")
                CheckType(Min,"number")
                local Max = settings.Max or 500 
                CheckIfNill(Max,"number")
                CheckType(Max,"number")
                local Default = settings.Default or 16 
                if Default == nil then
                    Default = Min
                end
                CheckType(Default,"number")
                local callback = settings.Callback or function() end 
                CheckIfNill(callback, "function")
                CheckType(callback,"function")


                    local SliderDef = math.clamp(Default, Min, Max) or math.clamp(50, Min, Max)
			        local DefaultScale =  (SliderDef - Min) / (Max - Min)

                if Min > Max then
                    local ValueBefore = Min
                    Min, Max = Max, ValueBefore
                end

            local Slider = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local Title = Instance.new("TextLabel")
            local Int = Instance.new("TextBox")
            local SliderButton = Instance.new("TextButton")
            local UICorner_2 = Instance.new("UICorner")
            local SliderBack = Instance.new("Frame")
            local UICorner_3 = Instance.new("UICorner")
        
            Slider.Name = "Slider"
            Slider.Parent = SectionContainer
            Slider.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
            Slider.Position = UDim2.new(0.154560804, 0, 0.353887409, 0)
            Slider.Size = UDim2.new(0, 409, 0, 59)

            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Slider

            Title.Name = "Title"
            Title.Parent = Slider
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0.0241545886, 0, 0, 0)
            Title.Size = UDim2.new(0, 404, 0, 38)
            Title.Font = Enum.Font.GothamBold
            Title.Text = text
            Title.TextColor3 = Color3.fromRGB(200, 200, 200)
            Title.TextSize = 13.000
            Title.TextXAlignment = Enum.TextXAlignment.Left
            local MinSize = 10
            local MaxSize = 36

            Int.Name = "Int"
            Int.Parent = Slider
            Int.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Int.BackgroundTransparency = 1.000
            Int.Position = UDim2.new(0.831295848, 0, 0, 0)
            Int.Size = UDim2.new(0, 64, 0, 27)
            Int.Font = Enum.Font.GothamBold
            Int.Text = "100"
            Int.TextColor3 = Color3.fromRGB(200, 200, 200)
            Int.TextSize = 13.000
            Int.TextXAlignment = Enum.TextXAlignment.Right

            SliderButton.Name = "SliderButton"
            SliderButton.Parent = Slider
            SliderButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            SliderButton.Position = UDim2.new(0.017114915, 0, 0.644067824, 0)
            SliderButton.Size = UDim2.new(0, 392, 0, 9)
            SliderButton.AutoButtonColor = false
            SliderButton.Font = Enum.Font.SourceSans
            SliderButton.Text = ""
            SliderButton.TextColor3 = Color3.fromRGB(69,91,123)
            SliderButton.TextSize = 14.000

            UICorner_2.CornerRadius = UDim.new(0, 4)
            UICorner_2.Parent = SliderButton

            SliderBack.Name = "SliderBack"
            SliderBack.Parent = SliderButton
            SliderBack.BackgroundColor3 = Color3.fromRGB(69,91,123)
            SliderBack.Position = UDim2.new(0, 0, 3.39084204e-06, 0)
            SliderBack.Size = UDim2.fromScale(DefaultScale,1)

            UICorner_3.CornerRadius = UDim.new(0, 4)
            UICorner_3.Parent = SliderBack

            pcall(callback,Default)
            Int.Text = Default

            Int.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
                if enterPressed then
                       numb = tonumber(Int.Text)
                 
                      local function check()
                            if numb < Min and numb > Max then
                                warn("shoulden't run")
                                return false 
                                elseif numb >= Min and numb <= Max then
                                    warn("should run")
                                    return true 
                                end
                      end
                      if check() then
                        local oldSliderDef = math.clamp(Int.Text, Min, Max) or math.clamp(50, Min, Max)
                        local oldDefaultScale =  (oldSliderDef - Min) / (Max - Min)
                        TweenService:Create(SliderBack, TweenInfo.new(0.15), {Size = UDim2.fromScale(oldDefaultScale, 1)}):Play()
                      end
                end  
            end)
            SliderButton.MouseButton1Down:Connect(function()
                local MouseMove, MouseKill
                MouseMove = Mouse.Move:Connect(function()
                    local Px = GetXY(SliderButton)
                    local SizeFromScale = (MinSize +  (MaxSize - MinSize)) * Px
                    local Value = math.floor(Min + ((Max - Min) * Px))
                    SizeFromScale = SizeFromScale - (SizeFromScale % 2)
                    TweenService:Create(SliderBack, TweenInfo.new(0.15), {Size = UDim2.fromScale(Px, 1)}):Play()
                    Int.Text = tostring(Value)
                    pcall(callback,Value)
                end)
                MouseKill = input.InputEnded:Connect(function(UserInput)
                    if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                        MouseMove:Disconnect()
                        MouseKill:Disconnect()
                    end
                end)
            end)
            end
            function Elements:Dropdown(settings)
                
                CheckIfNill(settings,"table")
                CheckType(settings,"table")
                local text = settings.Text or "New Dropdown"
                CheckIfNill(text,"string")
                CheckType(text,"string")
                local Items = settings.Items or {}
                CheckIfNill(Items,"table")
                CheckType(Items,"table")
                local callback = settings.Callback or function() end 
                CheckIfNill(callback, "function")
                CheckType(callback,"function")
                Dropped = false 

local DropFuncs = {}

local Dropdown = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local ButtonElement = Instance.new("TextButton")
local TextboxTitle = Instance.new("TextLabel")
local expand_less = Instance.new("ImageButton")
local UIListLayout = Instance.new("UIListLayout")



Dropdown.Name = "Dropdown"
Dropdown.Parent = SectionContainer
Dropdown.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
Dropdown.ClipsDescendants = true
Dropdown.Position = UDim2.new(0.152871624, 0, 0.528150201, 0)
Dropdown.Size = UDim2.new(0, 411, 0, 38)

UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Dropdown

ButtonElement.Name = "ButtonElement"
ButtonElement.Parent = Dropdown
ButtonElement.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
ButtonElement.BackgroundTransparency = 1.000
ButtonElement.Position = UDim2.new(-0.00611246936, 0, 0, 0)
ButtonElement.Size = UDim2.new(0, 411, 0, 38)
ButtonElement.AutoButtonColor = false
ButtonElement.Font = Enum.Font.SourceSans
ButtonElement.Text = ""
ButtonElement.TextColor3 = Color3.fromRGB(0, 0, 0)
ButtonElement.TextSize = 14.000

TextboxTitle.Name = "TextboxTitle"
TextboxTitle.Parent = ButtonElement
TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextboxTitle.BackgroundTransparency = 1.000
TextboxTitle.Position = UDim2.new(0.0241545886, 0, 0, 0)
TextboxTitle.Size = UDim2.new(0, 404, 0, 38)
TextboxTitle.Font = Enum.Font.GothamBold
TextboxTitle.Text = text
TextboxTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
TextboxTitle.TextSize = 13.000
TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

expand_less.Name = "expand_less"
expand_less.Parent = ButtonElement
expand_less.BackgroundTransparency = 1.000
expand_less.Position = UDim2.new(0.928223848, 0, 0.157894731, 0)
expand_less.Size = UDim2.new(0, 25, 0, 25)
expand_less.ZIndex = 2
expand_less.Image = "rbxassetid://3926305904"
expand_less.ImageRectOffset = Vector2.new(44, 404)
expand_less.ImageRectSize = Vector2.new(36, 36)

UIListLayout.Parent = Dropdown
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

                local function AB(v)
                    local DropItem = Instance.new("TextButton")
                    local TextboxTitle_2 = Instance.new("TextLabel")
                    
                    
                DropItem.Name = "DropItem"
                DropItem.Parent = Dropdown
                DropItem.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
                DropItem.BorderColor3 = Color3.fromRGB(27, 42, 53)
                DropItem.BorderSizePixel = 0
                DropItem.Position = UDim2.new(0, 0, 0.443298966, 0)
                DropItem.Size = UDim2.new(0, 411, 0, 31)
                DropItem.AutoButtonColor = false
                DropItem.Font = Enum.Font.SourceSans
                DropItem.Text = ""
                DropItem.TextColor3 = Color3.fromRGB(0, 0, 0)
                DropItem.TextSize = 14.000
                
                TextboxTitle_2.Name = "TextboxTitle"
                TextboxTitle_2.Parent = DropItem
                TextboxTitle_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxTitle_2.BackgroundTransparency = 1.000
                TextboxTitle_2.Position = UDim2.new(0.0264701005, 0, 0, 0)
                TextboxTitle_2.Size = UDim2.new(0, 403, 0, 31)
                TextboxTitle_2.Font = Enum.Font.GothamBold
                TextboxTitle_2.Text = v 
                TextboxTitle_2.TextColor3 = Color3.fromRGB(200, 200, 200)
                TextboxTitle_2.TextSize = 13.000
                TextboxTitle_2.TextXAlignment = Enum.TextXAlignment.Left
                
                DropItem.MouseEnter:Connect(function(x, y)
                    Tween(DropItem,{ BackgroundColor3 = Color3.fromRGB(55,55,55 )},.125)
                end)
                DropItem.MouseLeave:Connect(function(x, y)
                    Tween(DropItem,{ BackgroundColor3 = Color3.fromRGB(47,47,47 )},.125)
                end)
                DropItem.MouseButton1Click:Connect(function()
                    pcall(callback, TextboxTitle_2.Text)
                    TextboxTitle.Text = text .. " - " .. TextboxTitle_2.Text
                    Tween(Dropdown, { Size = UDim2.new(0, 411, 0, 38) },.1)
                    Tween(expand_less, { Rotation = 0 },.1)
                    Dropped = false
                end)   
                end

                for i,v in next, Items do
                    AB(v)
                end
                ButtonElement.MouseButton1Click:Connect(function()
                    Dropped = not Dropped 
                    if Dropped then
                        TweenService:Create(Dropdown,TweenInfo.new(.25), { Size = UDim2.new(0,411,0,UIListLayout.AbsoluteContentSize.Y + 8)}):Play()
                        TweenService:Create(expand_less,TweenInfo.new(.1), { Rotation = 180}):Play()
                       
                    else
                        TweenService:Create(Dropdown,TweenInfo.new(.25), { Size = UDim2.new(0,411,0,38)}):Play()
                        TweenService:Create(expand_less,TweenInfo.new(.1), { Rotation = 0}):Play()
                    end
                end)
-- where tf is my lsp im going insane
                function DropFuncs:Refresh(items)
                    for i,v in next, Dropdown:GetChildren() do
                        if v:IsA("TextButton") and v.Name == "DropItem" then
                            v:Destroy()
                        end
                     end
                     -- After Destroy
                     for i,v in next, items do
                         AB(v)
                     end
                end
                return DropFuncs
            end
            function Elements:Bind(settings)
                
                CheckIfNill(settings,"table")
                CheckType(settings,"table")
                local text = settings.Text or "New Dropdown"
                CheckIfNill(text,"string")
                CheckType(text,"string")
                local oldkey = settings.Key or Enum.KeyCode.F
                if oldkey == nil then oldkey = Enum.KeyCode.F end 
                local oldKey = oldkey.Name
                local callback = settings.Callback or function() end 
                CheckIfNill(callback, "function")
                CheckType(callback,"function")

            local Keybind = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local TextboxTitle = Instance.new("TextLabel")
            local Tog = Instance.new("TextButton")
            local UICorner_2 = Instance.new("UICorner")


            Keybind.Name = "Keybind"
            Keybind.Parent = SectionContainer
            Keybind.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
            Keybind.Position = UDim2.new(0.150337845, 0, 0.235924929, 0)
            Keybind.Size = UDim2.new(0, 409, 0, 38)

            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Keybind

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Keybind
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0.0241545886, 0, 0, 0)
            TextboxTitle.Size = UDim2.new(0, 404, 0, 38)
            TextboxTitle.Font = Enum.Font.GothamBold
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
            TextboxTitle.TextSize = 13.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            Tog.Name = "Tog"
            Tog.Parent = Keybind
            Tog.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Tog.Position = UDim2.new(0.682151556, 0, 0.236842096, 0)
            Tog.Size = UDim2.new(0, 120, 0, 22)
            Tog.AutoButtonColor = false
            Tog.Font = Enum.Font.GothamMedium
            Tog.Text = oldKey
            Tog.TextColor3 = Color3.fromRGB(230, 230, 230)
            Tog.TextSize = 12.000

            UICorner_2.CornerRadius = UDim.new(0, 4)
            UICorner_2.Parent = Tog

            Tog.MouseButton1Click:Connect(function()
                                
                Tog.TextSize = 0 
                TweenService:Create(Tog,TweenInfo.new(.2),{ TextSize = 15}):Play()
                Tog.Text = "..."
                wait(.2)
                TweenService:Create(Tog,TweenInfo.new(.2),{TextSize = 13}):Play()
                Tog.Text = "..."
                local a, b = game:GetService('UserInputService').InputBegan:wait();
                if a.KeyCode.Name ~= "Unknown" then
                    Tog.Text = a.KeyCode.Name
                    oldKey = a.KeyCode.Name;
                end
            end)
            game:GetService("UserInputService").InputBegan:connect(function(current, ok) 
                if not ok then 
                    if current.KeyCode.Name == oldKey then 
                        pcall(callback)
                    end
                end
            end)

            end
            return  Elements
        end
        return Sections
    end
    return t
end
warn("hi spectrum")
return Library
