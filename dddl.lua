-- 👆 GUI appears BEFORE Rayfield loading UI starts

task.defer(function()
   local Players = game:GetService("Players")
   local TweenService = game:GetService("TweenService")

   local player = Players.LocalPlayer
   local PlayerGui = player:WaitForChild("PlayerGui")

   local discordLink = "https://discord.gg/zVQZ62Kefr"

   local translations = {
       ["en"] = { join = "Join our Discord!", copy = "Copy Link", copied = "Copied Discord Link!" },
       ["ar"] = { join = "انضم إلى ديسكوردنا!", copy = "نسخ الرابط", copied = "تم نسخ رابط الديسكورد!" },
       ["fil"] = { join = "Sumali sa aming Discord!", copy = "Kopyahin ang Link", copied = "Nai-copy ang Discord Link!" },
       ["pt"] = { join = "Junte-se ao nosso Discord!", copy = "Copiar Link", copied = "Link do Discord copiado!" },
       ["es"] = { join = "¡Únete a nuestro Discord!", copy = "Copiar enlace", copied = "¡Enlace de Discord copiado!" },
       ["fr"] = { join = "Rejoignez notre Discord !", copy = "Copier le lien", copied = "Lien Discord copié !" },
       ["ru"] = { join = "Присоединяйтесь к нашему Discord!", copy = "Скопировать ссылку", copied = "Ссылка Discord скопирована!" },
   }

   local locale = player.LocaleId:sub(1,2):lower()
   local texts = translations[locale] or translations["en"]

   local function rainbowColor(t)
       local r = (math.sin(t) * 0.5 + 0.5)
       local g = (math.sin(t + 2 * math.pi / 3) * 0.5 + 0.5)
       local b = (math.sin(t + 4 * math.pi / 3) * 0.5 + 0.5)
       return Color3.new(r, g, b)
   end

   local ScreenGui = Instance.new("ScreenGui")
   ScreenGui.Name = "DiscordInviteGUI"
   ScreenGui.IgnoreGuiInset = true
   ScreenGui.ResetOnSpawn = false
   ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
   ScreenGui.DisplayOrder = 999
   ScreenGui.Parent = PlayerGui

   local Frame = Instance.new("Frame")
   Frame.Size = UDim2.new(0, 320, 0, 110)
   Frame.Position = UDim2.new(0.5, -160, 0.05, 0)
   Frame.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
   Frame.BackgroundTransparency = 1
   Frame.BorderSizePixel = 0
   Frame.AnchorPoint = Vector2.new(0.5, 0)
   Frame.ClipsDescendants = true
   Frame.Active = true
   Frame.Draggable = true
   Frame.ZIndex = 100
   Frame.Parent = ScreenGui

   Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 20)

   local Glow = Instance.new("Frame", Frame)
   Glow.Size = UDim2.new(1, 14, 1, 14)
   Glow.Position = UDim2.new(0, -7, 0, -7)
   Glow.BackgroundTransparency = 1
   Glow.ZIndex = 99

   local GlowStroke = Instance.new("UIStroke", Glow)
   GlowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
   GlowStroke.Thickness = 4
   GlowStroke.Transparency = 0
   GlowStroke.Color = Color3.fromRGB(255, 0, 0)

   Instance.new("UICorner", Glow).CornerRadius = UDim.new(0, 20)

   local TitleLabel = Instance.new("TextLabel", Frame)
   TitleLabel.Size = UDim2.new(1, -20, 0, 30)
   TitleLabel.Position = UDim2.new(0, 10, 0, 10)
   TitleLabel.BackgroundTransparency = 1
   TitleLabel.Text = texts.join
   TitleLabel.Font = Enum.Font.GothamBold
   TitleLabel.TextSize = 22
   TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
   TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
   TitleLabel.TextTransparency = 1
   TitleLabel.ZIndex = 101

   local CopyButton = Instance.new("TextButton", Frame)
   CopyButton.Size = UDim2.new(0, 150, 0, 45)
   CopyButton.Position = UDim2.new(0.5, -75, 0, 55)
   CopyButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
   CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
   CopyButton.TextSize = 18
   CopyButton.Font = Enum.Font.GothamSemibold
   CopyButton.Text = texts.copy
   CopyButton.AutoButtonColor = true
   CopyButton.BorderSizePixel = 0
   CopyButton.BackgroundTransparency = 1
   CopyButton.TextTransparency = 1
   CopyButton.ZIndex = 101
   Instance.new("UICorner", CopyButton).CornerRadius = UDim.new(0, 15)

   TweenService:Create(Frame, TweenInfo.new(1), {BackgroundTransparency = 0.1}):Play()
   TweenService:Create(TitleLabel, TweenInfo.new(1), {TextTransparency = 0}):Play()
   TweenService:Create(CopyButton, TweenInfo.new(1), {BackgroundTransparency = 0, TextTransparency = 0}):Play()

   local start = tick()
   game:GetService("RunService").Heartbeat:Connect(function()
       local t = tick() - start
       GlowStroke.Color = rainbowColor(t * 2)
   end)

   local function fadeOut()
       TweenService:Create(Frame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
       TweenService:Create(TitleLabel, TweenInfo.new(1), {TextTransparency = 1}):Play()
       TweenService:Create(CopyButton, TweenInfo.new(1), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
       task.delay(1, function()
           ScreenGui:Destroy()
       end)
   end

   CopyButton.MouseButton1Click:Connect(function()
       if setclipboard then setclipboard(discordLink) end
       pcall(function()
           game:GetService("StarterGui"):SetCore("SendNotification", {
               Title = "Discord",
               Text = texts.copied,
               Duration = 3,
               Icon = "rbxassetid://13412031254"
           })
       end)
       fadeOut()
   end)

   task.delay(10, fadeOut)
end)

-- GUI with Draggable Circular ImageButton to simulate pressing K key
local ScreenGui = Instance.new("ScreenGui")
local KButton = Instance.new("ImageButton")

-- Parent GUI to CoreGui (requires exploit environment like Synapse)
ScreenGui.Name = "KKeyGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Configure circular image button (11% smaller than 78 → ~69px)
KButton.Parent = ScreenGui
KButton.Size = UDim2.new(0, 69, 0, 69)
KButton.Position = UDim2.new(0, 40, 0.4, -34)
KButton.BackgroundTransparency = 1
KButton.Image = "rbxassetid://140630645393629"
KButton.ScaleType = Enum.ScaleType.Fit
KButton.ClipsDescendants = true

-- Make it circular
local corner = Instance.new("UICorner", KButton)
corner.CornerRadius = UDim.new(1, 0)

-- Draggable (supports both Mouse & Touch)
local dragging = false
local dragStart, startPos

local function inputPosition(input)
	return input.Position or input.TouchPosition or Vector2.zero
end

KButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = inputPosition(input)
		startPos = KButton.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = inputPosition(input) - dragStart
		KButton.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Simulate pressing the K key
KButton.MouseButton1Click:Connect(function()
	local vim = game:GetService("VirtualInputManager")
	vim:SendKeyEvent(true, Enum.KeyCode.K, false, game)  -- Key down
	vim:SendKeyEvent(false, Enum.KeyCode.K, false, game) -- Key up
end)

-- AIR HUB - base finder, push system, ESP with hitbox + Speed Coil boost
-- made by manager104 (me)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local p = Players.LocalPlayer
local char = p.Character or p.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local pushing = false
local myBase = nil
local speed = 65
local jumpVal = hum.JumpPower
local baseWalkSpeed = hum.WalkSpeed or 16

local ray = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local win = ray:CreateWindow({
	Name = "AIR HUB",
	LoadingTitle = "Loading...",
	LoadingSubtitle = "Made by @manager104",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "PrimeFiles",
		FileName = "Config1"
	},
	KeySystem = false
})

hum.UseJumpPower = true
hum.JumpPower = jumpVal

-- ESP with hitbox
local espEnabled = false
local espList = {}
local espColor = Color3.fromRGB(170, 0, 255)
local espSize = 18
local hitboxEnabled = false
local hitboxList = {}

local function createHitbox(plr)
	if hitboxList[plr] then return end
	local c = plr.Character
	if not c then return end
	local hrp = c:FindFirstChild("HumanoidRootPart")
	local hum = c:FindFirstChild("Humanoid")
	if not hrp or not hum then return end

	local box = Instance.new("BoxHandleAdornment")
	box.Adornee = hrp
	box.AlwaysOnTop = true
	box.ZIndex = 10
	box.Size = Vector3.new(4, 5, 4)
	box.Color3 = espColor
	box.Transparency = 0.5
	box.Parent = hrp

	hitboxList[plr] = box
end

local function removeHitbox(plr)
	if hitboxList[plr] then
		hitboxList[plr]:Destroy()
		hitboxList[plr] = nil
	end
end

local function addESP(plr)
	if plr == p or espList[plr] then return end
	local c = plr.Character
	if not c or not c:FindFirstChild("HumanoidRootPart") then return end

	local gui = Instance.new("BillboardGui")
	gui.Size = UDim2.new(0, 130, 0, 40)
	gui.StudsOffset = Vector3.new(0, 3, 0)
	gui.Adornee = c.HumanoidRootPart
	gui.AlwaysOnTop = true

	local txt = Instance.new("TextLabel", gui)
	txt.Size = UDim2.new(1, 0, 1, 0)
	txt.BackgroundTransparency = 1
	txt.Text = plr.Name
	txt.TextColor3 = espColor
	txt.Font = Enum.Font.GothamBlack
	txt.TextSize = espSize
	txt.TextStrokeTransparency = 0.5

	gui.Parent = c.HumanoidRootPart
	espList[plr] = gui

	if hitboxEnabled then
		createHitbox(plr)
	end

	plr.AncestryChanged:Connect(function(_, par)
		if not par then
			if espList[plr] then
				espList[plr]:Destroy()
				espList[plr] = nil
			end
			removeHitbox(plr)
		end
	end)
end

local function clearESP()
	for _, g in pairs(espList) do
		if g then g:Destroy() end
	end
	espList = {}

	for plr, _ in pairs(hitboxList) do
		removeHitbox(plr)
	end
	hitboxList = {}
end

local function toggleESP(state)
	espEnabled = state
	if state then
		for _, other in pairs(Players:GetPlayers()) do
			addESP(other)
		end
		Players.PlayerAdded:Connect(addESP)
	else
		clearESP()
	end
end

local function toggleHitbox(state)
	hitboxEnabled = state
	if hitboxEnabled then
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= p then
				createHitbox(plr)
			end
		end
	else
		for plr, _ in pairs(hitboxList) do
			removeHitbox(plr)
		end
	end
end

-- Base finder
local function findBase()
	local name = p.Name:upper()
	local possible = {}

	for _, o in pairs(workspace:GetDescendants()) do
		if o:IsA("TextLabel") or o:IsA("TextBox") then
			local text = (o.Text or ""):upper()
			if text:find("YOUR BASE") or text:find("BASE OF "..name) then
				local part = o:FindFirstAncestorWhichIsA("BasePart")
				if part then table.insert(possible, part) end
			end
		elseif o:IsA("BillboardGui") then
			local lbl = o:FindFirstChildWhichIsA("TextLabel")
			if lbl then
				local txt = (lbl.Text or ""):upper()
				if txt:find("YOUR BASE") or txt:find("BASE OF "..name) then
					local part = o.Adornee or o:FindFirstAncestorWhichIsA("BasePart")
					if part then table.insert(possible, part) end
				end
			end
		end
	end

	if #possible > 0 then
		local closest = nil
		local dist = math.huge
		for _, b in pairs(possible) do
			local d = (b.Position - hrp.Position).Magnitude
			if d < dist then
				closest = b
				dist = d
			end
		end
		myBase = closest
		ray:Notify({ Title = "Base", Content = "Found your base!", Duration = 3 })
	else
		ray:Notify({ Title = "Not Found", Content = "Couldn't find your base", Duration = 3 })
	end
end

local function startPush()
	if not myBase then return end
	pushing = true
	while pushing and myBase do
		local dir = (myBase.Position - hrp.Position).Unit
		hrp.Velocity = dir * speed
		task.wait()
	end
end

local function stopPush()
	pushing = false
end

-- Speed Coil Boost
local speedCoilName = "Speed Coil"
local boostedSpeed = 65
local baseSpeed = hum.WalkSpeed or 16
local speedBoostActive = false
local speedBoostConn = nil

local function equipSpeedCoil()
	local backpack = p:WaitForChild("Backpack")
	local tool = backpack:FindFirstChild(speedCoilName)
	if not tool then
		local starterPack = game:GetService("StarterPack")
		local spTool = starterPack:FindFirstChild(speedCoilName)
		if spTool then
			spTool:Clone().Parent = backpack
			tool = backpack:FindFirstChild(speedCoilName)
		end
	end
	if tool then
		hum.Parent.Humanoid:EquipTool(tool)
		return tool
	end
	return nil
end

local function unequipSpeedCoil()
	hum.Parent.Humanoid:UnequipTools()
end

local function startSpeedBoost()
	if speedBoostActive then return end
	speedBoostActive = true
	local tool = equipSpeedCoil()
	if not tool then
		ray:Notify({Title="Speed Boost", Content="Speed Coil not found", Duration=3})
		speedBoostActive = false
		return
	end
	task.wait(0.5)
	hum.WalkSpeed = boostedSpeed
	unequipSpeedCoil()

	speedBoostConn = hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		if not speedBoostActive then return end
		if hum.WalkSpeed ~= boostedSpeed then
			hum.WalkSpeed = boostedSpeed
		end
	end)
end

local function stopSpeedBoost()
	if not speedBoostActive then return end
	speedBoostActive = false
	if speedBoostConn then
		speedBoostConn:Disconnect()
		speedBoostConn = nil
	end
	hum.WalkSpeed = baseWalkSpeed
end

-- UI Setup

local tab1 = win:CreateTab("Base", 4483362458)
tab1:CreateButton({ Name = "Find My Base", Callback = findBase })
tab1:CreateButton({ Name = "Push to Base", Callback = function() if myBase then coroutine.wrap(startPush)() end end })
tab1:CreateButton({ Name = "Stop Push", Callback = stopPush })
tab1:CreateSlider({
	Name = "Push Speed",
	Range = {20, 150},
	Increment = 5,
	Suffix = " u/s",
	CurrentValue = speed,
	Callback = function(v) speed = v end
})

local tab2 = win:CreateTab("Movement", 4483362458)
tab2:CreateSlider({
	Name = "Jump Power",
	Range = {50, 500},
	Increment = 10,
	Suffix = "",
	CurrentValue = jumpVal,
	Callback = function(v)
		jumpVal = v
		hum.JumpPower = v
	end
})

tab2:CreateToggle({
	Name = "Enable Speed Coil Boost",
	CurrentValue = false,
	Callback = function(state)
		if state then
			startSpeedBoost()
		else
			stopSpeedBoost()
		end
	end
})


local ShopTab = win:CreateTab("Shop", 4483362458)
ShopTab:CreateButton({
Name = "All Seeing Sentry",
Callback = function()
local args = { "All Seeing Sentry" }
local success, err = pcall(function()
game:GetService("ReplicatedStorage")
.Packages.Net:FindFirstChild("RF/CoinsShopService/RequestBuy")
:InvokeServer(unpack(args))
end)
if not success then
warn("Failed to purchase All Seeing Sentry:", err)
end
end

})

ShopTab:CreateButton({
Name = "Invisibility Cloak",
Callback = function()
local args = { "Invisibility Cloak" }
local success, err = pcall(function()
game:GetService("ReplicatedStorage")
.Packages.Net:FindFirstChild("RF/CoinsShopService/RequestBuy")
:InvokeServer(unpack(args))
end)
if not success then
warn("Failed to purchase All Seeing Sentry:", err)
end
end

}) 

ShopTab:CreateButton({
Name = "Trap",
Callback = function()
local args = { "Trap" }
local success, err = pcall(function()
game:GetService("ReplicatedStorage")
.Packages.Net:FindFirstChild("RF/CoinsShopService/RequestBuy")
:InvokeServer(unpack(args))
end)
if not success then
warn("Failed to purchase All Seeing Sentry:", err)
end
end

})

ShopTab:CreateButton({
Name = "Medusa",
Callback = function()
local args = {"Medusa's Head" }
local success, err = pcall(function()
game:GetService("ReplicatedStorage")
.Packages.Net:FindFirstChild("RF/CoinsShopService/RequestBuy")
:InvokeServer(unpack(args))
end)
if not success then
warn("Failed to purchase All Seeing Sentry:", err)
end
end

})

ShopTab:CreateButton({
Name = "Quantum Cloner",
Callback = function()
local args = {"Quantum Cloner"}
local success, err = pcall(function()
game:GetService("ReplicatedStorage")
.Packages.Net:FindFirstChild("RF/CoinsShopService/RequestBuy")
:InvokeServer(unpack(args))
end)
if not success then
warn("Failed to purchase All Seeing Sentry:", err)
end
end

})

ShopTab:CreateButton({
Name = "Web Slinger",
Callback = function()
local args = {"Web Slinger"}
local success, err = pcall(function()
game:GetService("ReplicatedStorage")
.Packages.Net:FindFirstChild("RF/CoinsShopService/RequestBuy")
:InvokeServer(unpack(args))
end)
if not success then
warn("Failed to purchase All Seeing Sentry:", err)
end
end

})

ShopTab:CreateButton({
Name = "Rainbowrath Sword",
Callback = function()
local args = {"Rainbowrath Sword"}
local success, err = pcall(function()
game:GetService("ReplicatedStorage")
.Packages.Net:FindFirstChild("RF/CoinsShopService/RequestBuy")
:InvokeServer(unpack(args))
end)
if not success then
warn("Failed to purchase All Seeing Sentry:", err)
end
end

})

ShopTab:CreateButton({
Name = "Galaxy Slap",
Callback = function()
local args = {"Galaxy Slap"}
local success, err = pcall(function()
game:GetService("ReplicatedStorage")
.Packages.Net:FindFirstChild("RF/CoinsShopService/RequestBuy")
:InvokeServer(unpack(args))
end)
if not success then
warn("Failed to purchase All Seeing Sentry:", err)
end
end

})

ShopTab:CreateButton({
Name = "Nuclear Slap",
Callback = function()
local args = {"Nuclear Slap"}
local success, err = pcall(function()
game:GetService("ReplicatedStorage")
.Packages.Net:FindFirstChild("RF/CoinsShopService/RequestBuy")
:InvokeServer(unpack(args))
end)
if not success then
warn("Failed to purchase All Seeing Sentry:", err)
end
end

})

ShopTab:CreateButton({
Name = "Dark Matter Slap",
Callback = function()
local args = {"Dark Matter Slap"}
local success, err = pcall(function()
game:GetService("ReplicatedStorage")
.Packages.Net:FindFirstChild("RF/CoinsShopService/RequestBuy")
:InvokeServer(unpack(args))
end)
if not success then
warn("Failed to purchase All Seeing Sentry:", err)
end
end

})

ShopTab:CreateButton({
Name = "Body Swap Potion",
Callback = function()
local args = {"Body Swap Potion"}
local success, err = pcall(function()
game:GetService("ReplicatedStorage")
.Packages.Net:FindFirstChild("RF/CoinsShopService/RequestBuy")
:InvokeServer(unpack(args))
end)
if not success then
warn("Failed to purchase All Seeing Sentry:", err)
end
end

})

ShopTab:CreateButton({
Name = "Splatter Slap",
Callback = function()
local args = {"Splatter Slap"}
local success, err = pcall(function()
game:GetService("ReplicatedStorage")
.Packages.Net:FindFirstChild("RF/CoinsShopService/RequestBuy")
:InvokeServer(unpack(args))
end)
if not success then
warn("Failed to purchase All Seeing Sentry:", err)
end
end

})



local tab3 = win:CreateTab("Visuals", 4483362458)
tab3:CreateToggle({
	Name = "ESP (Player Names)",
	CurrentValue = false,
	Callback = toggleESP
})
tab3:CreateToggle({
	Name = "Hitbox Overlay",
	CurrentValue = false,
	Callback = toggleHitbox
})
tab3:CreateColorPicker({
	Name = "ESP Color",
	Color = espColor,
	Callback = function(c)
		espColor = c
		if espEnabled then
			toggleESP(false)
			toggleESP(true)
		end
		if hitboxEnabled then
			toggleHitbox(false)
			toggleHitbox(true)
		end
	end
})
tab3:CreateSlider({
	Name = "ESP Text Size",
	Range = {12, 30},
	Increment = 1,
	CurrentValue = espSize,
	Callback = function(s)
		espSize = s
		if espEnabled then
			toggleESP(false)
			toggleESP(true)
		end
	end
})
tab3:CreateToggle({
   Name = "☠️ Brainrot God Esp",
   CurrentValue = false,
   Flag = "BrainrotGodESP",
   Callback = function(state)
       if state then
           enableGodESP()
       else
           disableGodESP()
       end
   end,
})

local secretBrainrots = {
   ["La Vacca Saturno Saturnita"] = true,
   ["Los Tralaleritos"] = true,
   ["Sammyni Spyderini"] = true,
   ["Graipuss Medussi"] = true,
   ["La Grande Combinazione"] = true,
   ["Garama and Madundung"] = true,
}

local secretESPObjects = {}
local secretESPEnabled = false

local function getAttachmentPart(model)
   if model.PrimaryPart then return model.PrimaryPart end
   for _, part in ipairs(model:GetDescendants()) do
       if part:IsA("BasePart") then
           return part
       end
   end
   return nil
end

local function createSecretESP(model)
   if model:FindFirstChild("SecretBrainrotESP") then return end
   local adorneePart = getAttachmentPart(model)
   if not adorneePart then return end

   local billboard = Instance.new("BillboardGui")
   billboard.Name = "SecretBrainrotESP"
   billboard.Adornee = adorneePart
   billboard.Size = UDim2.new(0, 166, 0, 33)
   billboard.StudsOffset = Vector3.new(0, 5, 0)
   billboard.AlwaysOnTop = true
   billboard.LightInfluence = 0
   billboard.Parent = model

   local label = Instance.new("TextLabel")
   label.Size = UDim2.new(1, 0, 1, 0)
   label.BackgroundTransparency = 1
   label.Text = "ðŸ¤« " .. model.Name
   label.TextColor3 = Color3.fromRGB(255, 128, 0)
   label.TextStrokeTransparency = 0
   label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
   label.Font = Enum.Font.GothamBold
   label.TextSize = 16
   label.ZIndex = 10
   label.ClipsDescendants = true
   label.Parent = billboard

   secretESPObjects[model] = billboard
end

local function enableSecretESP()
   secretESPEnabled = true
   for _, model in ipairs(workspace:GetChildren()) do
       if model:IsA("Model") and secretBrainrots[model.Name] then
           createSecretESP(model)
       end
   end
end

local function disableSecretESP()
   secretESPEnabled = false
   for model, billboard in pairs(secretESPObjects) do
       if billboard and billboard.Parent then
           billboard:Destroy()
       end
   end
   secretESPObjects = {}
end

workspace.ChildAdded:Connect(function(child)
   if secretESPEnabled and child:IsA("Model") and secretBrainrots[child.Name] then
       createSecretESP(child)
   end
end)

-- Replace 'EspTab' with your actual Rayfield tab variable
tab3:CreateToggle({
   Name = "🤫Secret Brainrot Esp",
   CurrentValue = false,
   Flag = "SecretBrainrotESP",
   Callback = function(state)
       if state then
           enableSecretESP()
       else
           disableSecretESP()
       end
   end,
})

local tab4 = win:CreateTab("Credits", 4483362458)
tab4:CreateButton({
	Name = "Show Credits",
	Callback = function()
		ray:Notify({
			Title = "Credits",
			Content = "Made by @manager104, @npolarisekk",
			Duration = 5
		})
	end
})
