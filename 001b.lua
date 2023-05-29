-- DEV_Test-Build001b

-- Create a ScreenGui to hold the button and the second UI

local gui = Instance.new("ScreenGui")

gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create a Frame to hold the button

local frame = Instance.new("Frame")

frame.Size = UDim2.new(0, 150, 0, 50) -- Button size

frame.Position = UDim2.new(0, 20, 0.5, -25) -- Positioned on the left side of the screen

frame.AnchorPoint = Vector2.new(0, 0.5) -- Anchor to the left side of the button

frame.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) -- Gray background color

frame.BackgroundTransparency = 0.5 -- Semi-transparent background

frame.BorderSizePixel = 0 -- No border

frame.Parent = gui

-- Apply rounded corners to the button frame

local corner = Instance.new("UICorner")

corner.CornerRadius = UDim.new(0, 10) -- Set the corner radius

corner.Parent = frame

-- Create a TextButton inside the frame

local button = Instance.new("TextButton")

button.Name = "MyButton"

button.Size = UDim2.new(1, 0, 1, 0)

button.BackgroundTransparency = 1 -- Make the button transparent

button.Text = "Open"

button.TextColor3 = Color3.new(1, 1, 1) -- White text color

button.TextScaled = true -- Adjust text size automatically

button.Font = Enum.Font.SourceSansBold -- Set the font

button.TextWrapped = true -- Wrap text if it exceeds the button size

button.Parent = frame

-- Create a Frame for the second UI

local secondUI = Instance.new("Frame")

secondUI.Name = "SecondUI"

secondUI.Size = UDim2.new(0, 400, 0, 300) -- Increased size of the second UI

secondUI.Position = UDim2.new(0.5, -200, 0.5, -150) -- Center the second UI

secondUI.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Lighter black background color

secondUI.Active = true -- Allow interaction with the second UI

secondUI.Parent = gui

-- Create a title bar for the second UI

local title = Instance.new("TextLabel")

title.Name = "Title"

title.Size = UDim2.new(1, 0, 0, 30) -- Size of the title bar

title.BackgroundTransparency = 1 -- Transparent title background

title.Text = "Second UI"

title.TextColor3 = Color3.new(1, 1, 1) -- White text color

title.Font = Enum.Font.SourceSansBold -- Set the font

title.TextScaled = true -- Adjust text size automatically

title.Parent = secondUI

-- Apply rounded corners to the second UI

local corner2 = Instance.new("UICorner")

corner2.CornerRadius = UDim.new(0, 10) -- Set the corner radius

corner2.Parent = secondUI

-- Hide the second UI initially

secondUI.Visible = false

-- Function to execute when the button is clicked

local function onClick()

    print("Button clicked!")

    if secondUI.Visible then

        -- Close the second UI with a tweening animation

        secondUI:TweenSizeAndPosition(UDim2.new(0, 0, 0, 0), UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true, function()

            secondUI.Visible = false

        end)

    else

        -- Open the second UI with a tweening animation

        secondUI.Visible = true

        secondUI.Size = UDim2.new(0, 0, 0, 0)

        secondUI.Position = UDim2.new(0.5, 0, 0.5, 0)

        secondUI:TweenSizeAndPosition(UDim2.new(0, 400, 0, 300), UDim2.new(0.5, -200, 0.5, -150), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)

    end

end

-- Connect the function to the button's MouseButton1Click event

button.MouseButton1Click:Connect(onClick)

-- Custom dragging behavior for the second UI element

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

-- Bind the dragging events

secondUI.InputBegan:Connect(startDrag)

secondUI.InputChanged:Connect(updateDrag)

-- Detect the current game

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

-- Whitelist of supported game IDs

local supportedGameIDs = {

    123456789, -- Replace with the actual game IDs

    987654321,

    456789123

}

-- Check if the current game ID is in the supported game IDs list

local isSupportedGame = false

for _, supportedGameID in ipairs(supportedGameIDs) do

    if game.PlaceId == supportedGameID then

        isSupportedGame = true

        break

    end

end

-- Update the title based on game support

if isSupportedGame then

    title.Text = gameName .. " - Supported"

else

    title.Text = gameName .. " - Unsupported"

end
