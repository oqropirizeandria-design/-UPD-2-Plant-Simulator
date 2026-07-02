local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "c00lkidd"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 160)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Color = Color3.fromRGB(45, 45, 52)
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -40, 0, 35)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.Text = "EVIL PANEL"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 13
TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1
TitleLabel.Parent = MainFrame

local dragging = false
local dragStart, startPos

MainFrame.InputBegan:Connect(function(input, gameProcessedEvent)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not gameProcessedEvent then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)

MainFrame.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

MainFrame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 24, 0, 24)
closeButton.Position = UDim2.new(1, -32, 0, 6)
closeButton.Text = "×"
closeButton.Font = Enum.Font.GothamMedium
closeButton.TextSize = 18
closeButton.TextColor3 = Color3.fromRGB(150, 150, 160)
closeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
closeButton.BorderSizePixel = 0
closeButton.Parent = MainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

closeButton.MouseEnter:Connect(function() closeButton.TextColor3 = Color3.fromRGB(255, 100, 100) end)
closeButton.MouseLeave:Connect(function() closeButton.TextColor3 = Color3.fromRGB(150, 150, 160) end)

local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, -24, 1, -45)
ButtonContainer.Position = UDim2.new(0, 12, 0, 35)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ButtonContainer

local function styleButton(btn, text)
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.Text = text
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 12
	btn.BorderSizePixel = 0
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = btn
end

local abyssalButton = Instance.new("TextButton")
styleButton(abyssalButton, "Abyssal Heart Replace")
abyssalButton.BackgroundColor3 = Color3.fromRGB(38, 38, 44)
abyssalButton.TextColor3 = Color3.fromRGB(230, 230, 240)
abyssalButton.LayoutOrder = 1
abyssalButton.Parent = ButtonContainer

abyssalButton.MouseButton1Click:Connect(function()
	local plantsFolder = workspace:FindFirstChild("Plants")
	if plantsFolder and plantsFolder:IsA("Folder") then
		for _, model in ipairs(plantsFolder:GetChildren()) do
			if model:IsA("Model") then
				model.Name = "AbyssalHeart"
			end
		end
	end
    
    local origColor = abyssalButton.BackgroundColor3
    abyssalButton.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    task.wait(0.1)
    abyssalButton.BackgroundColor3 = origColor
end)

local autoPlantingButton = Instance.new("TextButton")
styleButton(autoPlantingButton, "Enable Auto Planting")
autoPlantingButton.LayoutOrder = 2
autoPlantingButton.Parent = ButtonContainer

local function updateAutoPlantingButton()
	local state = Player:GetAttribute("AutoPlanting")
	local targetColor, targetText, targetTextColor
	
	if state then
		targetText = "Disable Auto Planting"
		targetColor = Color3.fromRGB(46, 125, 50)
		targetTextColor = Color3.fromRGB(255, 255, 255)
	else
		targetText = "Enable Auto Planting"
		targetColor = Color3.fromRGB(38, 38, 44)
		targetTextColor = Color3.fromRGB(230, 230, 240)
	end
	
	autoPlantingButton.Text = targetText
	TweenService:Create(autoPlantingButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
		BackgroundColor3 = targetColor,
		TextColor3 = targetTextColor
	}):Play()
end

autoPlantingButton.MouseButton1Click:Connect(function()
	local current = Player:GetAttribute("AutoPlanting")
	Player:SetAttribute("AutoPlanting", not current)
	updateAutoPlantingButton()
end)

if Player:GetAttribute("AutoPlanting") == nil then
	Player:SetAttribute("AutoPlanting", false)
end

updateAutoPlantingButton()
