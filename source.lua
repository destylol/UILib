local CoreGui = game:GetService'CoreGui'
local TweenService = game:GetService'TweenService'
local Input = game:GetService'UserInputService'
local Players = game:GetService'Players'
local Http = game:GetService'HttpService'
local speaker = Players.LocalPlayer
local Mouse = speaker:GetMouse()
local Library = {}
local Util = {}
CurrentVersion = "v1.5.3"
Version = nil 
local function GetXY(GuiObject)
	local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
	return Px/Max, Py/May
end

function Util.CompleteDestroy()
    for i,v in next, CoreGui:GetChildren() do
        if v:IsA("ScreenGui") and v.Name == "april_lib_4" then
            v:Destroy()
        end
    end
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
local is = function(delta,alpha)
    if typeof(delta) ~= alpha then
        return false 
    else
        return true
    end
end
function Util.FetchVersion()
    local vTO = loadstring(game:HttpGet("https://raw.githubusercontent.com/elsiahrekeno/ouro_version/main/version.lua", true))()
    return vTO
end
if Util.FetchVersion() ~= CurrentVersion then
    speaker:Kick("Outdated Version\nVexMilk Lib")
end
udim2ToTable = function(udim2)
    return {udim2.X.Scale, udim2.X.Offset, udim2.Y.Scale, udim2.Y.Offset}
end

udim2FromTable = function(udim2)
    return UDim2.new(udim2[1], udim2[2], udim2[3], udim2[4])
end
function Check()
    if writefile or appendfile or readfile or isfile or makefolder or delfolder or isfolder then
        return true
    else
        return false
    end
end
_G.Settings = {
    Position = nil
}
if Check() then
    makefolder("./xA1lt/")
else
    print("Not supported")
end
local fname = "./xA1lt/settings.dat"
function load()
    if (Check() and isfile(fname)) then
        _G.Settings = Http:JSONDecode(readfile(fname))
    end
end
function save()
    local json
    if Check() then
        json = Http:JSONEncode(_G.Settings)
        writefile(fname, json)
    else
        print("Not supported")
    end
end

load()
save()
function Util.Drag(frame,parent)
    
        
    parent = parent or frame
    
    -- stolen from wally or kiriot, kek
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

    Input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
            _G.Settings.Position = udim2ToTable(parent.Position)
            save()
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
    CoreGui["april_lib_4"].Enabled = not CoreGui['april_lib_4'].Enabled
end
Util.CompleteDestroy()
function Library.Init(options)
    options = options or {}
    if not options then options = {} end 
    local savePos = options.SavePosition 
    if not savePos then savePos = false end 

    if not is(options,"table") then
        error("Invalid usuage of argument (Options must be a table)")
    end
    if _G.Settings.Position == nil then
        local pos = UDim2.new(.5, 0, 0.5, 0)
        _G.Settings.Position = udim2ToTable(pos)
        save()
    end

            local Main = Instance.new("ScreenGui")
            local Motherframe = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local Shadow = Instance.new("ImageLabel")
            local Header = Instance.new("Frame")
            local UICorner_2 = Instance.new("UICorner")
            local Cover = Instance.new("Frame")
            local Title1 = Instance.new("TextLabel")
            local Title2 = Instance.new("TextLabel")
            local BorderFrame = Instance.new("Frame")
            local TabContainer = Instance.new("ScrollingFrame")
            local UIListLayout = Instance.new("UIListLayout")
            local UIPadding = Instance.new("UIPadding")
            local Pages = Instance.new("Folder")
            local versionValue = Instance.new("StringValue")
            local snoop = Instance.new("StringValue")

            Main.Name = "april_lib_4"
            Main.Parent = CoreGui
            Main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

            versionValue.Parent = Main 
            versionValue.Name = "Version"
            versionValue.Value = "v1.5.3"

            snoop.Parent = Main
            snoop.Name = "Stop Snooping!!!"
            snoop.Value = "Its not nice to snoop!"

            Motherframe.Name = "Motherframe"
            Motherframe.Parent = Main
            Motherframe.AnchorPoint = Vector2.new(0.5, 0.5)
            Motherframe.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Motherframe.Size = UDim2.new(0, 606, 0, 375)

            if savePos then 
                Motherframe.Position = udim2FromTable(_G.Settings.Position)
            else
                Motherframe.Position = UDim2.new(0.5,0,.5,0)
            end

            UICorner.CornerRadius = UDim.new(0, 5)
            UICorner.Parent = Motherframe

            Shadow.Name = "Shadow"
            Shadow.Parent = Motherframe
            Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Shadow.BackgroundTransparency = 1.000
            Shadow.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Shadow.Position = UDim2.new(0, -15, 0, -15)
            Shadow.Size = UDim2.new(1, 30, 1, 30)
            Shadow.Image = "http://www.roblox.com/asset/?id=5554236805"
            Shadow.ImageColor3 = Color3.fromRGB(35, 35, 35)
            Shadow.ScaleType = Enum.ScaleType.Slice
            Shadow.SliceCenter = Rect.new(23, 23, 277, 277)

            Header.Name = "Header"
            Header.Parent = Motherframe
            Header.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Header.Size = UDim2.new(0, 605, 0, 35)

            Util.Drag(Header,Motherframe)

            UICorner_2.CornerRadius = UDim.new(0, 5)
            UICorner_2.Parent = Header

            Cover.Name = "Cover"
            Cover.Parent = Header
            Cover.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Cover.BorderSizePixel = 0
            Cover.Position = UDim2.new(0, 0, 0.800000012, 0)
            Cover.Size = UDim2.new(0, 605, 0, 7)

            Title1.Name = "Title1"
            Title1.Parent = Header
            Title1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title1.BackgroundTransparency = 1.000
            Title1.Size = UDim2.new(0, 61, 0, 38)
            Title1.Font = Enum.Font.Gotham
            Title1.Text = "Master"
            Title1.TextColor3 = Color3.fromRGB(137, 207, 240)
            Title1.TextSize = 15.000

            Title2.Name = "Title2"
            Title2.Parent = Header
            Title2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title2.BackgroundTransparency = 1.000
            Title2.Position = UDim2.new(0.0900000036, 0, 0, 0)
            Title2.Size = UDim2.new(0, 30, 0, 38)
            Title2.Font = Enum.Font.Gotham
            Title2.Text = "Hub"
            Title2.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title2.TextSize = 15.000

            BorderFrame.Name = "BorderFrame"
            BorderFrame.Parent = Header
            BorderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            BorderFrame.BorderSizePixel = 0
            BorderFrame.Position = UDim2.new(0, 91, 0, 7)
            BorderFrame.Size = UDim2.new(0, 2, 0, 23)

            TabContainer.Name = "TabContainer"
            TabContainer.Parent = Header
            TabContainer.Active = true
            TabContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TabContainer.BackgroundTransparency = 12.000
            TabContainer.BorderSizePixel = 0
            TabContainer.Position = UDim2.new(0.170247927, 0, 0, 0)
            TabContainer.Size = UDim2.new(0, 502, 0, 35)
            TabContainer.CanvasSize = UDim2.new(0, 0, 0.5, 0)

            UIListLayout.Parent = TabContainer
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            UIListLayout.FillDirection = Enum.FillDirection.Horizontal
            UIListLayout.Padding = UDim.new(0,7)

            UIPadding.Parent = TabContainer

            Pages.Name = "Pages"
            Pages.Parent = Motherframe
            local Tabs = {}
            function Tabs:Tab(tabname)
                tabname = tostring(string.upper(tabname)) or 'NEW TAB'
                if not tabname then tabname = 'NEW TAB' end 
                local Tab = Instance.new("TextButton")
                local Page = Instance.new("ScrollingFrame")
                local UIListLayout_2 = Instance.new("UIListLayout")
                local UIPadding_2 = Instance.new("UIPadding")

                Tab.Name = "Tab"
                Tab.Parent = TabContainer
                Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Tab.BackgroundTransparency = 1.000
                Tab.Size = UDim2.new(0, 42, 0, 38)
                Tab.Font = Enum.Font.GothamBold
                Tab.Text = tabname
                Tab.TextColor3 = Color3.fromRGB(240, 240, 240)
                Tab.TextSize = 12.000
                Tab.AutomaticSize = Enum.AutomaticSize.X

                Page.Name = "Page"
                Page.Parent = Pages
                Page.Active = true
                Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Page.BackgroundTransparency = 1.000
                Page.BorderSizePixel = 0
                Page.Position = UDim2.new(0, 0, 0.109333336, 0)
                Page.Size = UDim2.new(0, 606, 0, 334)
                Page.ScrollBarThickness = 5
                Page.ScrollBarImageColor3 = Color3.fromRGB(15,15,15)

                UIListLayout_2.Parent = Page
                UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout_2.Padding = UDim.new(0, 8)

                UIPadding_2.Parent = Page
                UIPadding_2.PaddingBottom = UDim.new(0, 10)
                UIPadding_2.PaddingTop = UDim.new(0, 2)

                task.spawn(function()
                    while wait() do
                        Page.CanvasSize = UDim2.new(0,0,0,UIListLayout_2.AbsoluteContentSize.Y + 15)
                    end
                end)

                local a = 0
                local b = 0

                for i,v in next, TabContainer:GetChildren() do
                    if v:IsA("TextButton") then
                        a = a + 1 
                        v.Name = tostring(a) .. "Tab"
                    end
                end
                for i,v in next, Pages:GetChildren() do
                    b = b + 1 
                    v.Name = tostring(b) .. "Page"
                end
                for i,v in next, Pages:GetChildren() do
                    if v.Name ~= "1Page" then 
                        v.Visible = false 
                    end
                end
                for i,v in next, TabContainer:GetChildren() do
                    if v:IsA('TextButton')  and v.Name ~= "1Tab" then
                            v.TextColor3 = Color3.fromRGB(150,150,150)
                    end
                end
                Tab.MouseButton1Click:Connect(function()
                    for i,v in next, TabContainer:GetChildren() do
                        if v:IsA('TextButton')  then
                           TweenService:Create(v,TweenInfo.new(.2),{ TextColor3 = Color3.fromRGB(150,150,150)}):Play()
                          end
                    end
                    TweenService:Create(Tab, TweenInfo.new(.2), { TextColor3 = Color3.fromRGB(240,240,240)}):Play()
                    for i,v in next, Pages:GetChildren() do
                        v.Visible = false 
                    end
                    Page.Visible = true 
                end)
                local Sections = {}
                function Sections:Section(sectionname)
                    sectionname = tostring(string.upper(sectionname)) or 'NEW SECTION'
                    if not sectionname then sectionname = 'NEW SECTION' end 
                    if not is(sectionname,'string') then sectionname = "NEW SECTION" end 

                    local SectionContainer = Instance.new("Frame")
                    local layout = Instance.new("UIListLayout")
                    local lbl = Instance.new("TextLabel")

                    SectionContainer.Name = "SectionContainer"
                    SectionContainer.Parent = Page
                    SectionContainer.Size = UDim2.new(0,500,0,38)
                    SectionContainer.BackgroundTransparency = 1 

                    lbl.Name = "lbl"
                    lbl.Parent = SectionContainer
                    lbl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    lbl.BackgroundTransparency = 1.000
                    lbl.BorderColor3 = Color3.fromRGB(27, 42, 53)
                    lbl.Size = UDim2.new(0, 586, 0, 14)
                    lbl.Font = Enum.Font.GothamBold
                    lbl.Text = sectionname
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
                        TweenService:Create(SectionContainer,TweenInfo.new(.01),{Size = UDim2.new(0,538,0,layout.AbsoluteContentSize.Y)}):Play()
                    end)

                    local Elements = {} 
                function Elements:NewButton(options)
                   options = options or {}
                   if not options then options = {} end 
                    if not is(options,"table") then
                        error("Invalid usuage of argument (Options must be a table)")
                    end
                    local  btntitle = options.Title or 'New Button'
                    if not btntitle then btntitle = 'New Button' end 
                    local callback = options.Callback or function() end  
                    if not callback then callback = function() end end 

                    if not is(btntitle,"string") then
                        error("Invalid usuage of argument (Title must be a string)")
                    end
                    if not is(callback,"function") then
                        error("Invalid usuage of argument (Callback must be a function)")
                    end
                    local ButtonContainer = Instance.new("Frame")
                    local Btn = Instance.new("TextButton")
                    local UICorner = Instance.new("UICorner")
                    local UIPadding = Instance.new("UIPadding")
                    local Sample = Instance.new("ImageLabel")
                    local Shadow = Instance.new("ImageLabel")

                    ButtonContainer.Name = "ButtonContainer"
                    ButtonContainer.Parent = SectionContainer
                    ButtonContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ButtonContainer.BackgroundTransparency = 1.000
                    ButtonContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
                    ButtonContainer.Size = UDim2.new(0, 500, 0, 38)

                    Btn.Name = "Btn"
                    Btn.Parent = ButtonContainer
                    Btn.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    Btn.Size = UDim2.new(0, 500, 0, 38)
                    Btn.Selected = true
                    Btn.Font = Enum.Font.GothamSemibold
                    Btn.Text = btntitle
                    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
                    Btn.TextSize = 14.000
                    Btn.TextXAlignment = Enum.TextXAlignment.Left
                    Btn.AutoButtonColor = false 
                    Btn.ClipsDescendants = true 
                    
                    Shadow.Name = "Shadow"
                    Shadow.Parent = ButtonContainer
                    Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Shadow.BackgroundTransparency = 1.000
                    Shadow.BorderColor3 = Color3.fromRGB(27, 42, 53)
                    Shadow.Position = UDim2.new(0, -15, 0, -15)
                    Shadow.Size = UDim2.new(1, 30, 1, 30)
                    Shadow.Image = "http://www.roblox.com/asset/?id=5554236805"
                    Shadow.ImageColor3 = Color3.fromRGB(47, 47, 47)
                    Shadow.ScaleType = Enum.ScaleType.Slice
                    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)

                    Sample.Name = "Sample"
                    Sample.Parent = Btn
                    Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Sample.BackgroundTransparency = 1.000
                    Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                    Sample.ImageColor3 = Color3.fromRGB(75,75,75)
                    Sample.ImageTransparency = 0.600

                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = Btn

                    UIPadding.Parent = Btn
                    UIPadding.PaddingLeft = UDim.new(0, 8)


                    Btn.MouseEnter:Connect(function(x, y)
                        local goal = {}
                        goal.BackgroundColor3 = Color3.fromRGB(48,48,48)
                        TweenService:Create(Btn,TweenInfo.new(.25), goal):Play()
                    end)
                    Btn.MouseLeave:Connect(function(x, y)
                        local goal = {}
                        goal.BackgroundColor3 = Color3.fromRGB(43,43,43)
                        TweenService:Create(Btn,TweenInfo.new(.25), goal):Play()
                    end)
                    Btn.MouseButton1Click:Connect(function()
                        pcall(callback)
                        local c = Sample:Clone()
                        c.Parent = Btn 
                        local x, y = (Mouse.X - c.AbsolutePosition.X), (Mouse.Y - c.AbsolutePosition.Y)
                        c.Position = UDim2.new(0, x, 0, y)
                        local len, size = 0.35, nil
                        if Btn.AbsoluteSize.X >= Btn.AbsoluteSize.Y then
                            size = (Btn.AbsoluteSize.X * 1.5)
                        else
                            size = (Btn.AbsoluteSize.Y * 1.5)
                        end
                        c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.7, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                        for i = 1, 10 do
                            c.ImageTransparency = c.ImageTransparency + 0.05
                            wait(len / 12)
                        end
                        c:Destroy()
                    end)
                end   
                function Elements:NewTextbox(options)
                    options = options or {}
                   if not options then options = {} end 
                    if not is(options,"table") then
                        error("Invalid usuage of argument (Options must be a table)")
                    end
                    local tbtitle = options.Title or 'New Textbox'
                    if not tbtitle then tbtitle = "New Textbox" end 
                    local callback = options.Callback or function() end 
                    if not callback then callback = function() end end 
                    local placeholdertext = options.PlaceholderText or 'Input Here...'
                    if not placeholdertext then placeholdertext = '' end 


                    if not is(tbtitle,"string") then
                            error("Invalid usuage of argument (Title must be a string )")                        
                    end
                    if not is(callback,"function") then
                        error("Invalid usuage of argument (Callback must be a function)")
                    end
                    if not is(placeholdertext,"string") then
                        error("Invalid usuage of argument (PlaceholderText must be a string)")
                    end
                local TextboxContainer = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local TextboxTitle = Instance.new("TextLabel")
                local TbBorder = Instance.new("Frame")
                local UICorner_2 = Instance.new("UICorner")
                local Textbox = Instance.new("TextBox")
                local UICorner_3 = Instance.new("UICorner")
                local Shadow = Instance.new("ImageLabel")
              
                TextboxContainer.Name = "TextboxContainer"
                TextboxContainer.Parent = SectionContainer
                TextboxContainer.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                TextboxContainer.Size = UDim2.new(0, 500, 0, 38)


                    Shadow.Name = "Shadow"
                    Shadow.Parent = TextboxContainer
                    Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Shadow.BackgroundTransparency = 1.000
                    Shadow.BorderColor3 = Color3.fromRGB(27, 42, 53)
                    Shadow.Position = UDim2.new(0, -15, 0, -15)
                    Shadow.Size = UDim2.new(1, 30, 1, 30)
                    Shadow.Image = "http://www.roblox.com/asset/?id=5554236805"
                    Shadow.ImageColor3 = Color3.fromRGB(47, 47, 47)
                    Shadow.ScaleType = Enum.ScaleType.Slice
                    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)


                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = TextboxContainer

                TextboxTitle.Name = "TextboxTitle"
                TextboxTitle.Parent = TextboxContainer
                TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxTitle.BackgroundTransparency = 1.000
                TextboxTitle.Position = UDim2.new(0.0160000008, 0, 0, 0)
                TextboxTitle.Size = UDim2.new(0, 298, 0, 38)
                TextboxTitle.Font = Enum.Font.GothamSemibold
                TextboxTitle.Text = tbtitle
                TextboxTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
                TextboxTitle.TextSize = 14.000
                TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

                TbBorder.Name = "TbBorder"
                TbBorder.Parent = TextboxContainer
                TbBorder.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                TbBorder.Position = UDim2.new(0, 307, 0, 5)
                TbBorder.Size = UDim2.new(0, 182, 0, 28)

                UICorner_2.CornerRadius = UDim.new(0, 4)
                UICorner_2.Parent = TbBorder

                Textbox.Name = "Textbox"
                Textbox.Parent = TbBorder
                Textbox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                Textbox.ClipsDescendants = true
                Textbox.Position = UDim2.new(0, 1, 0, 1)
                Textbox.Size = UDim2.new(0, 180, 0, 26)
                Textbox.Font = Enum.Font.GothamSemibold
                Textbox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
                Textbox.PlaceholderText = placeholdertext
                Textbox.Text = ""
                Textbox.TextColor3 = Color3.fromRGB(200, 200, 200)
                Textbox.TextSize = 14.000

                UICorner_3.CornerRadius = UDim.new(0, 4)
                UICorner_3.Parent = Textbox


                Textbox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
                    if enterPressed then
                        pcall(callback, Textbox.Text)
                        Textbox.Text = ""
                    end
                end)
                end 
                function Elements:NewToggle(options)
                    options = options or {}
                    if not options then options = {} end 
                     if not is(options,"table") then
                         error("Invalid usuage of argument (Options must be a table)")
                     end
                    local title = options.Title or 'New Toggle '
                    local callback = options.Callback or function() end  
                    local default =  options.Default 
                    if  typeof(default) ~= "boolean" then
                        error("Invalid usuage of argument (true/false)",458)
                    end
                    local ToggleContainer = Instance.new("Frame")
                    local UICorner = Instance.new("UICorner")
                    local ToggleTitle = Instance.new("TextLabel")
                    local Shadow = Instance.new("ImageLabel")
                    local ToggleBorder = Instance.new("Frame")
                    local UICorner_2 = Instance.new("UICorner")
                    local ToggleBack = Instance.new("Frame")
                    local UICorner_3 = Instance.new("UICorner")
                    local ImageLabel = Instance.new("ImageLabel")
                    local TextButton = Instance.new("TextButton")

                    ToggleContainer.Name = "ToggleContainer"
                    ToggleContainer.Parent = SectionContainer
                    ToggleContainer.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    ToggleContainer.Size = UDim2.new(0, 500, 0, 38)

                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = ToggleContainer


                    TextButton.Parent = ToggleContainer
                    TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextButton.BackgroundTransparency = 1.000
                    TextButton.Size = UDim2.new(0, 500, 0, 38)
                    TextButton.Font = Enum.Font.SourceSans
                    TextButton.Text = ""
                    TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    TextButton.TextSize = 14.000


                    ToggleTitle.Name = "ToggleTitle"
                    ToggleTitle.Parent = ToggleContainer
                    ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleTitle.BackgroundTransparency = 1.000
                    ToggleTitle.Position = UDim2.new(0.0160000008, 0, 0, 0)
                    ToggleTitle.Size = UDim2.new(0, 435, 0, 38)
                    ToggleTitle.Font = Enum.Font.GothamSemibold
                    ToggleTitle.Text = title 
                    ToggleTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
                    ToggleTitle.TextSize = 14.000
                    ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

                    Shadow.Name = "Shadow"
                    Shadow.Parent = ToggleContainer
                    Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Shadow.BackgroundTransparency = 1.000
                    Shadow.BorderColor3 = Color3.fromRGB(27, 42, 53)
                    Shadow.Position = UDim2.new(0, -15, 0, -15)
                    Shadow.Size = UDim2.new(1, 30, 1, 30)
                    Shadow.Image = "http://www.roblox.com/asset/?id=5554236805"
                    Shadow.ImageColor3 = Color3.fromRGB(47, 47, 47)
                    Shadow.ScaleType = Enum.ScaleType.Slice
                    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)

                    ToggleBorder.Name = "ToggleBorder"
                    ToggleBorder.Parent = ToggleContainer
                    ToggleBorder.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    ToggleBorder.Position = UDim2.new(0, 461, 0, 5)
                    ToggleBorder.Size = UDim2.new(0, 28, 0, 28)

                    UICorner_2.CornerRadius = UDim.new(0, 4)
                    UICorner_2.Parent = ToggleBorder

                    ToggleBack.Name = "ToggleBack"
                    ToggleBack.Parent = ToggleBorder
                    ToggleBack.BackgroundColor3 = Color3.fromRGB(137, 207, 240)
                    ToggleBack.BorderSizePixel = 0
                    ToggleBack.Position = UDim2.new(0, 1, 0, 1)
                    ToggleBack.Size = UDim2.new(0, 26, 0, 26)

                    UICorner_3.CornerRadius = UDim.new(0, 4)
                    UICorner_3.Parent = ToggleBack

                    ImageLabel.Parent = ToggleBack
                    ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ImageLabel.BackgroundTransparency = 1.000
                    ImageLabel.Position = UDim2.new(0, 5, 0, 5)
                    ImageLabel.Size = UDim2.new(0, 15, 0, 15)
                    ImageLabel.Image = "rbxassetid://4921680783"
                    ImageLabel.ImageColor3 = Color3.fromRGB(35, 35, 35)
                    ImageLabel.ScaleType = Enum.ScaleType.Fit
                                    
                    local State = default
                    if default then
                       State = true
                    else
                       State = false
                    end

                    TextButton.MouseButton1Click:Connect(function()
                        State = not State
                        local NewColour = State and Color3.fromRGB(137, 207, 240) or Color3.fromRGB(35, 35, 35)
                        TweenService:Create(ToggleBack, TweenInfo.new(.25), {BackgroundColor3 = NewColour}):Play()
                        pcall(callback, State)
                    end)
                    if default then
                        ToggleBack.BackgroundColor3 = Color3.fromRGB(137, 207, 240)
                        pcall(callback, State)
                    else
                        ToggleBack.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                        pcall(callback, State)
                        end
                end
                function Elements:NewDropdown(options)
                    options = options or {}
                    if not options then options = {} end 
                     if not is(options,"table") then
                         error("Invalid usuage of argument (Options must be a table)")
                     end
                    local droptitle = options.Title or 'New Dropdown'
                    local list = options.Items or {}
                    local callback = options.Callback or function() end 
                    local dropfunctions = {}
                    local Dropped = false 

                    if not droptitle then
                        droptitle = 'New Dropdown'
                    end
                    if not list then
                        list = {}
                    end
                    if not callback then
                        callback = function() end
                    end
                    
                    if not is(droptitle,"string") then
                        error("Invalid usuage of argument (Title must be a string)")
                    end
                    if not is(list,"table") then
                        error("Invalid usuage of argument (Items must be a list)")
                    end
                    if not is(callback,"function") then
                        error("Invalid usuage of argument (Callback must be a function)")
                    end

                local DropdownContainer = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local Btn = Instance.new("TextButton")
                local UICorner_2 = Instance.new("UICorner")
                local Orientation = Instance.new("ImageButton")
                local Shadow = Instance.new("ImageLabel")
                local TextBox = Instance.new("TextLabel")
                local UIPadding = Instance.new("UIPadding")
                local f = Instance.new("UIListLayout")
                
                DropdownContainer.Name = "DropdownContainer"
                DropdownContainer.Parent = SectionContainer
                DropdownContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownContainer.BackgroundTransparency = 1.000
                DropdownContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
                DropdownContainer.ClipsDescendants = true
                DropdownContainer.Position = UDim2.new(0.0874587446, 0, 0.428571433, 0)
                DropdownContainer.Size = UDim2.new(0, 500, 0, 38)

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = DropdownContainer

                Btn.Name = "Btn"
                Btn.Parent = DropdownContainer
                Btn.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                Btn.Position = UDim2.new(-0.0240000002, 0, 0.0388349518, 0)
                Btn.Size = UDim2.new(0, 500, 0, 38)
                Btn.AutoButtonColor = false
                Btn.Selected = true
                Btn.Font = Enum.Font.GothamSemibold
                Btn.Text = ""
                Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
                Btn.TextSize = 14.000
                Btn.TextXAlignment = Enum.TextXAlignment.Left

                UICorner_2.CornerRadius = UDim.new(0, 4)
                UICorner_2.Parent = Btn

                Orientation.Name = "Orientation"
                Orientation.Parent = Btn
                Orientation.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Orientation.BackgroundTransparency = 1.000
                Orientation.Position = UDim2.new(0, 465, 0, 6)
                Orientation.Size = UDim2.new(0, 24, 0, 26)
                Orientation.Image = "rbxassetid://6034818379"
                Orientation.ImageColor3 = Color3.fromRGB(155, 155, 155)

                Shadow.Name = "Shadow"
                Shadow.Parent = Btn
                Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Shadow.BackgroundTransparency = 1.000
                Shadow.BorderColor3 = Color3.fromRGB(27, 42, 53)
                Shadow.Position = UDim2.new(0, 7, 0, 134)
                Shadow.Size = UDim2.new(1, 30, 1, 30)
                Shadow.Image = "http://www.roblox.com/asset/?id=5554236805"
                Shadow.ImageColor3 = Color3.fromRGB(47, 47, 47)
                Shadow.ScaleType = Enum.ScaleType.Slice
                Shadow.SliceCenter = Rect.new(23, 23, 277, 277)

                TextBox.Parent = Btn
                TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.BackgroundTransparency = 1.000
                TextBox.BorderColor3 = Color3.fromRGB(27, 42, 53)
                TextBox.Position = UDim2.new(0.0160000194, 0, 0, 0)
                TextBox.Size = UDim2.new(0, 298, 0, 38)
                TextBox.Font = Enum.Font.GothamSemibold
                TextBox.Text = droptitle
                TextBox.TextColor3 = Color3.fromRGB(200, 200, 200)
                TextBox.TextSize = 14.000
                TextBox.TextXAlignment = Enum.TextXAlignment.Left
                TextBox.Name = "TB"
                TextBox.AutomaticSize = Enum.AutomaticSize.X

                UIPadding.Parent = Btn
                UIPadding.PaddingLeft = UDim.new(0, 2)

                f.Parent = DropdownContainer
                f.SortOrder = Enum.SortOrder.LayoutOrder
                f.Padding = UDim.new(0, 5)

                local function genItems(v)
                local DropItem = Instance.new("TextButton")
                local UICorner_3 = Instance.new("UICorner")

                DropItem.Name = "DropItem"
                DropItem.Parent = DropdownContainer
                DropItem.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                DropItem.Size = UDim2.new(0, 500, 0, 25)
                DropItem.AutoButtonColor = false
                DropItem.Font = Enum.Font.GothamSemibold
                DropItem.TextColor3 = Color3.fromRGB(200, 200, 200)
                DropItem.TextSize = 13.000
                DropItem.TextWrapped = true
                DropItem.Text = v 

                UICorner_3.CornerRadius = UDim.new(0, 4)
                UICorner_3.Parent = DropItem
                
                DropItem.MouseEnter:Connect(function()
                    TweenService:Create(DropItem,TweenInfo.new(.25),{BackgroundColor3 = Color3.fromRGB(47, 47, 47)}):Play()
                end)
                DropItem.MouseLeave:Connect(function()
                    TweenService:Create(DropItem,TweenInfo.new(.25),{BackgroundColor3 = Color3.fromRGB(43, 43, 43)}):Play()
                end)


                DropItem.MouseButton1Click:Connect(function()
                    pcall(callback, DropItem.Text)
                    TweenService:Create(Orientation, TweenInfo.new(.25), { Rotation = 0}):Play()
                    TextBox.Text = droptitle .. " - " .. DropItem.Text
                    TweenService:Create(DropdownContainer,TweenInfo.new(.23), {Size =  UDim2.new(0, 500, 0, 38 )}):Play()
                    Dropped = false
                 
                	end)
                end
                for i,v in next, list do
                    genItems(v)
                end
                Btn.MouseButton1Click:Connect(function()
                    if not Dropped then
                        Dropped = true 
                        TweenService:Create(DropdownContainer,TweenInfo.new(.25),{Size = UDim2.new(0, 500, 0, f.AbsoluteContentSize.Y)}):Play()
                        TweenService:Create(Orientation,TweenInfo.new(.25),{Rotation = 180}):Play() 
              
         
                        elseif Dropped then
                    Dropped = false 
                    TweenService:Create(DropdownContainer,TweenInfo.new(.25),{Size = UDim2.new(0, 500, 0, 38)}):Play()
                    TweenService:Create(Orientation,TweenInfo.new(.25),{Rotation = 0}):Play()  
             
                end
                end)
                function dropfunctions:Refresh(options)
                    local l = options.Items or {}
                    if not l then l = {} end 
                    if not is(l,"table") then l = {} end 

                    for i,v in pairs(DropdownContainer:GetChildren()) do
                            if v:IsA("TextButton") and v.Name ~= "Btn" then
                                v:Destroy()
                            end
                    end
                    genItems(l)
                end
                return dropfunctions
            end
            function Elements:NewSlider(options)

                options = options or {}
                if not options then options = {} end 
                 if not is(options,"table") then
                     error("Invalid usuage of argument (Options must be a table)")
                 end
                local slidertitle = options.Title or 'New Slider'
                local minvalue = options.Min or 16 
                local maxvalue = options.Max or 1000
                local callback = options.Callback or function() end 
                local default = options.Default 
                if not default then default = 0 end 
                if not slidertitle then
                    slidertitle = 'New Dropdown'
                end
                if not minvalue then
                    minvalue = 16
                end
                if not maxvalue then
                    maxvalue = 1000
                end
                if not callback then
                    callback = function() end
                end
                
                if not is(slidertitle,"string") then
                    error("Invalid usuage of argument (Title must be a string)")
                end
                if not is(minvalue,"number") then
                    error("Invalid usuage of argument (Min/Max must be a number (int))")
                end
                if not is(maxvalue,"number") then
                    error("Invalid usuage of argument (Min/Max must be a number (int))")
                end
                if not is(callback,"function") then
                    error("Invalid usuage of argument (Callback must be a function)")
                end
                if not is(default,"number") then
                    error("Invalid usuage of argument (Default must be a number (int))")
                end
                local SliderDef = math.clamp(default, minvalue, maxvalue) or math.clamp(50, minvalue, maxvalue)
			    local DefaultScale =  (SliderDef - minvalue) / (maxvalue - minvalue)

                if minvalue > maxvalue then
                    local ValueBefore = minvalue
                    minvalue, maxvalue = maxvalue, ValueBefore
                end

                local SliderContainer = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local SliderTitle = Instance.new("TextLabel")
                local SliderInt = Instance.new("TextBox")
                local SliderButton = Instance.new("TextButton")
                local UICorner_2 = Instance.new("UICorner")
                local SliderBack = Instance.new("Frame")
                local UICorner_3 = Instance.new("UICorner")

              
                SliderContainer.Name = "SliderContainer"
                SliderContainer.Parent = SectionContainer
                SliderContainer.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                SliderContainer.Size = UDim2.new(0, 500, 0, 47)

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = SliderContainer

                SliderTitle.Name = "SliderTitle"
                SliderTitle.Parent = SliderContainer
                SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderTitle.BackgroundTransparency = 1.000
                SliderTitle.Position = UDim2.new(0.0160000008, 0, 0, 0)
                SliderTitle.Size = UDim2.new(0, 435, 0, 32)
                SliderTitle.Font = Enum.Font.GothamSemibold
                SliderTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
                SliderTitle.TextSize = 14.000
                SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
		SliderTitle.Text = slidertitle
				
				
                SliderInt.Name = "SliderInt"
                SliderInt.Parent = SliderContainer
                SliderInt.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderInt.BackgroundTransparency = 1.000
                SliderInt.Position = UDim2.new(0.90199995, 0, 0, 0)
                SliderInt.Size = UDim2.new(0, 47, 0, 32)
                SliderInt.Font = Enum.Font.GothamSemibold
                SliderInt.Text = "1"
                SliderInt.TextColor3 = Color3.fromRGB(200, 200, 200)
                SliderInt.TextSize = 14.000
                SliderInt.TextTruncate = Enum.TextTruncate.AtEnd
                SliderInt.ClipsDescendants = true 
                
                SliderButton.Name = "SliderButton"
                SliderButton.Parent = SliderContainer
                SliderButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                SliderButton.Position = UDim2.new(0.00800000038, 0, 0.680851042, 0)
                SliderButton.Size = UDim2.new(0, 491, 0, 8)
                SliderButton.AutoButtonColor = false
                SliderButton.Font = Enum.Font.SourceSans
                SliderButton.Text = ""
                SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                SliderButton.TextSize = 14.000
                local MinSize = 10
                local MaxSize = 36

                UICorner_2.CornerRadius = UDim.new(0, 4)
                UICorner_2.Parent = SliderButton

                SliderBack.Name = "SliderBack"
                SliderBack.Parent = SliderButton
                SliderBack.BackgroundColor3 = Color3.fromRGB(137, 207, 240)
                SliderBack.BorderColor3 = Color3.fromRGB(43, 43, 43)
                SliderBack.Size = UDim2.fromScale(DefaultScale,1)

                UICorner_3.CornerRadius = UDim.new(0, 4)
                UICorner_3.Parent = SliderBack

                pcall(callback,default)
                SliderInt.Text = default
               

                SliderInt.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
                    if enterPressed then
                           numb = tonumber(SliderInt.Text)
                     
                          local function check()
                                if numb < minvalue and numb > maxvalue then
                                    warn("shoulden't run")
                                    return false 
                                    elseif numb >= minvalue and numb <= maxvalue then
                                        warn("should run")
                                        return true 
                                    end
                          end
                          if check() then
                            local oldSliderDef = math.clamp(SliderInt.Text, minvalue, maxvalue) or math.clamp(50, minvalue, maxvalue)
                            local oldDefaultScale =  (oldSliderDef - minvalue) / (maxvalue - minvalue)
                            TweenService:Create(SliderBack, TweenInfo.new(0.15), {Size = UDim2.fromScale(oldDefaultScale, 1)}):Play()
                          end
                    end  
                end)
                SliderButton.MouseButton1Down:Connect(function()
                    local MouseMove, MouseKill
                    MouseMove = Mouse.Move:Connect(function()
                        local Px = GetXY(SliderButton)
                        local SizeFromScale = (MinSize +  (MaxSize - MinSize)) * Px
                        local Value = math.floor(minvalue + ((maxvalue - minvalue) * Px))
                        SizeFromScale = SizeFromScale - (SizeFromScale % 2)
                        TweenService:Create(SliderBack, TweenInfo.new(0.15), {Size = UDim2.fromScale(Px, 1)}):Play()
                        SliderInt.Text = tostring(Value)
                        pcall(callback,Value)
                    end)
                    MouseKill = Input.InputEnded:Connect(function(UserInput)
                        if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                            MouseMove:Disconnect()
                            MouseKill:Disconnect()
                        end
                    end)
                end)


            end
            function Elements:NewLabel(options)
                local title = options.Title or 'NEW LABEL'
                if not title then title = "NEW LABEL" end 

                if not is(title, "string") then
                    title = 'NEW LABEL'
                end
				local ButtonContainer = Instance.new("Frame")
				local Btn = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				local UIPadding = Instance.new("UIPadding")
				local Sample = Instance.new("ImageLabel")
				local Shadow = Instance.new("ImageLabel")

				ButtonContainer.Name = "ButtonContainer"
				ButtonContainer.Parent = SectionContainer
				ButtonContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ButtonContainer.BackgroundTransparency = 1.000
				ButtonContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
				ButtonContainer.Size = UDim2.new(0, 500, 0, 38)

				Btn.Name = "Btn"
				Btn.Parent = ButtonContainer
				Btn.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
				Btn.Size = UDim2.new(0, 500, 0, 38) 				Btn.Font = Enum.Font.GothamSemibold
				Btn.Text = title
				Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
				Btn.TextSize = 14.000
				Btn.TextXAlignment = Enum.TextXAlignment.Left
				Btn.ClipsDescendants = true 
				
				Shadow.Name = "Shadow"
				Shadow.Parent = ButtonContainer
				Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Shadow.BackgroundTransparency = 1.000
				Shadow.BorderColor3 = Color3.fromRGB(27, 42, 53)
				Shadow.Position = UDim2.new(0, -15, 0, -15)
				Shadow.Size = UDim2.new(1, 30, 1, 30)
				Shadow.Image = "http://www.roblox.com/asset/?id=5554236805"
				Shadow.ImageColor3 = Color3.fromRGB(47, 47, 47)
				Shadow.ScaleType = Enum.ScaleType.Slice
				Shadow.SliceCenter = Rect.new(23, 23, 277, 277)

				Sample.Name = "Sample"
				Sample.Parent = Btn
				Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sample.BackgroundTransparency = 1.000
				Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
				Sample.ImageColor3 = Color3.fromRGB(75,75,75)
				Sample.ImageTransparency = 0.600

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Btn

				UIPadding.Parent = Btn
				UIPadding.PaddingLeft = UDim.new(0, 8)
            end
            function Elements:NewKeybind(options)
                options = options or {}
                if not options then options = {} end 
                 if not is(options,"table") then
                     error("Invalid usuage of argument (Options must be a table)")
                 end
                 local kbtitle = options.Title or 'New Keybind'
                 if not kbtitle then kbtitle = "New Keybind" end 
                 local callback = options.Callback or function() end 
                 if not callback then callback = function() end end 
                 local oldkey = options.Key or Enum.KeyCode.F
                 if not oldkey then  oldkey = Enum.KeyCode.F end 
                 if not is(kbtitle,"string") then
                         error("Invalid usuage of argument (Title must be a string )")                        
                 end
                 if not is(callback,"function") then
                     error("Invalid usuage of argument (Callback must be a function)")
                 end
                 local   oldKey =  oldkey.Name 


local KeybindContainer = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local KeybindBorder = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local TextButton = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local TextboxTitle = Instance.new("TextLabel")


KeybindContainer.Name = "KeybindContainer"
KeybindContainer.Parent = SectionContainer
KeybindContainer.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
KeybindContainer.Size = UDim2.new(0, 500, 0, 38)

UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = KeybindContainer

KeybindBorder.Name = "KeybindBorder"
KeybindBorder.Parent = KeybindContainer
KeybindBorder.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeybindBorder.Position = UDim2.new(0, 394, 0, 5)
KeybindBorder.Size = UDim2.new(0, 95, 0, 28)

UICorner_2.CornerRadius = UDim.new(0, 4)
UICorner_2.Parent = KeybindBorder

TextButton.Parent = KeybindBorder
TextButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TextButton.Position = UDim2.new(0, 1, 0, 1)
TextButton.Size = UDim2.new(0, 93, 0, 26)
TextButton.AutoButtonColor = false
TextButton.Font = Enum.Font.GothamSemibold
TextButton.Text = oldKey
TextButton.TextColor3 = Color3.fromRGB(200, 200, 200)
TextButton.TextSize = 12.000

UICorner_3.CornerRadius = UDim.new(0, 4)
UICorner_3.Parent = TextButton

TextboxTitle.Name = "TextboxTitle"
TextboxTitle.Parent = KeybindContainer
TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextboxTitle.BackgroundTransparency = 1.000
TextboxTitle.Position = UDim2.new(0.0160000008, 0, 0, 0)
TextboxTitle.Size = UDim2.new(0, 298, 0, 38)
TextboxTitle.Font = Enum.Font.GothamSemibold
TextboxTitle.Text = kbtitle
TextboxTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
TextboxTitle.TextSize = 14.000
TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

TextButton.MouseButton1Click:Connect(function()
                       
    TextButton.TextSize = 0 
    TweenService:Create(TextButton,TweenInfo.new(.2),{ TextSize = 15}):Play()
    TextButton.Text = "..."
    wait(.2)
    TweenService:Create(TextButton,TweenInfo.new(.2),{TextSize = 13}):Play()
    TextButton.Text = "..."
    local a, b = game:GetService('UserInputService').InputBegan:wait();
    if a.KeyCode.Name ~= "Unknown" then
        TextButton.Text = a.KeyCode.Name
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
            function Elements:NewColorpicker()
                
            end 
            function Elements:LargeTextbox()
                
            end
                return Elements
                end
                return Sections
            end 
            return Tabs
end
warn("xa1lt was here (when the dropdown don't work like it used to no mo) ⚔")
return Library
