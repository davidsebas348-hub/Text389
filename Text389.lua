-- TOGGLE
getgenv().NPC_NAME = not getgenv().NPC_NAME
if not getgenv().NPC_NAME then
	for _,v in pairs(workspace:GetDescendants()) do
		if v.Name == "ESP_NAME" then
			v:Destroy()
		end
	end
	return
end

repeat task.wait() until game:IsLoaded()

local Enemies = workspace:WaitForChild("Enemies")

local function getColor(name)
	name = string.lower(name)

	if string.find(name, "buffemployee") then
		return Color3.fromRGB(255,140,0)
	elseif string.find(name, "employee") then
		return Color3.fromRGB(255,0,0)
	elseif string.find(name, "manager") then
		return Color3.fromRGB(0,0,0)
	elseif string.find(name, "roach") then
		return Color3.fromRGB(139,69,19)
	else
		return Color3.fromRGB(255,0,0)
	end
end

local function create(npc)
	if not getgenv().NPC_NAME then return end
	if npc:FindFirstChild("ESP_NAME") then return end

	local head = npc:FindFirstChild("Head")
	if not head then return end

	local bill = Instance.new("BillboardGui")
	bill.Name = "ESP_NAME"
	bill.Adornee = head
	bill.Size = UDim2.new(0,100,0,20)
	bill.StudsOffset = Vector3.new(0,2,0)
	bill.AlwaysOnTop = true

	local txt = Instance.new("TextLabel")
	txt.Size = UDim2.new(1,0,1,0)
	txt.BackgroundTransparency = 1
	txt.Text = npc.Name
	txt.TextSize = 14
	txt.Font = Enum.Font.SourceSansBold
	txt.TextColor3 = getColor(npc.Name)
	txt.TextStrokeTransparency = 0
	txt.TextStrokeColor3 = Color3.new(0,0,0)
	txt.Parent = bill

	bill.Parent = npc
end

for _,v in ipairs(Enemies:GetChildren()) do
	create(v)
end

Enemies.ChildAdded:Connect(function(v)
	task.wait(0.2)
	create(v)
end)
