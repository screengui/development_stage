-- DEV_Test-Build001b



local gui = Instance.new("ScreenGui")

gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")



local frame = Instance.new("Frame")

frame.Size = UDim2.new(0, 150, 0, 50) 

frame.Position = UDim2.new(0, 20, 0.5, -25) 

frame.AnchorPoint = Vector2.new(0, 0.5) 

frame.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) 

frame.BackgroundTransparency = 0.5 

frame.BorderSizePixel = 0 

frame.Parent = gui



local corner = Instance.new("UICorner")

corner.CornerRadius = UDim.new(0, 10) 

corner.Parent = frame



local button = Instance.new("TextButton")

button.Name = "MyButton"

button.Size = UDim2.new(1, 0, 1, 0)

button.BackgroundTransparency = 1

button.Text = "Open"

button.TextColor3 = Color3.new(1, 1, 1) 

button.TextScaled = true 

button.Font = Enum.Font.SourceSansBold 

button.TextWrapped = true 


button.Parent = frame



local secondUI = Instance.new("Frame")

secondUI.Name = "SecondUI"

secondUI.Size = UDim2.new(0, 400, 0, 300)

secondUI.Position = UDim2.new(0.5, -200, 0.5, -150) 

secondUI.BackgroundColor3 = Color3.fromRGB(30, 30, 30) 

secondUI.Active = true 

secondUI.Parent = gui



local title = Instance.new("TextLabel")

title.Name = "Title"

title.Size = UDim2.new(1, 0, 0, 30) 

title.BackgroundTransparency = 1 

title.Text = "Second UI"

title.TextColor3 = Color3.new(1, 1, 1) 

title.Font = Enum.Font.SourceSansBold 

title.TextScaled = true 

title.Parent = secondUI



local corner2 = Instance.new("UICorner")

corner2.CornerRadius = UDim.new(0, 10)

corner2.Parent = secondUI



secondUI.Visible = false



local function onClick()

    print("Button clicked!")

    if secondUI.Visible then

        

        secondUI:TweenSizeAndPosition(UDim2.new(0, 0, 0, 0), UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true, function()

            secondUI.Visible = false

        end)

    else

        

        secondUI.Visible = true

        secondUI.Size = UDim2.new(0, 0, 0, 0)

        secondUI.Position = UDim2.new(0.5, 0, 0.5, 0)

        secondUI:TweenSizeAndPosition(UDim2.new(0, 400, 0, 300), UDim2.new(0.5, -200, 0.5, -150), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)

    end

end



button.MouseButton1Click:Connect(onClick)



local dragging = false

local dragStartPos = nil

local function startDrag(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true

        dragStartPos = input.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then

                dragging = false

            end

        end)

    end

end

local function updateDrag(input)

    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then

        local dragDelta = input.Position - dragStartPos

        secondUI.Position = UDim2.new(

            secondUI.Position.X.Scale,

            secondUI.Position.X.Offset + dragDelta.X,

            secondUI.Position.Y.Scale,

            secondUI.Position.Y.Offset + dragDelta.Y

        )

        dragStartPos = input.Position

    end

end



secondUI.InputBegan:Connect(startDrag)

secondUI.InputChanged:Connect(updateDrag)



local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

-- Whitelist of supported game IDs

local supportedGameIDs = {

    123456789, -- Replace with the actual game IDs

    987654321,

    456789123

}



local isSupportedGame = false

for _, supportedGameID in ipairs(supportedGameIDs) do

    if game.PlaceId == supportedGameID then

        isSupportedGame = true

        break

    end

end



if isSupportedGame then

    title.Text = gameName .. " - Supported"

else

    title.Text = gameName .. " - Unsupported"

end
