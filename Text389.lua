repeat task.wait() until game:IsLoaded()

local Enemies = workspace:WaitForChild("Enemies")

if _G.NPC_NAME_ESP == nil then
	_G.NPC_NAME_ESP = false
end

_G.NPC_NAME_ESP = not _G.NPC_NAME_ESP

if not _G.NPC_NAME_CONNS then
	_G.NPC_NAME_CONNS = {}
end

--------------------------------------------------
-- COLORES
--------------------------------------------------
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

--------------------------------------------------
-- CREAR ESP
--------------------------------------------------
local function create(NPC)
	if not _G.NPC_NAME_ESP then return end
	if NPC:FindFirstChild("ESP_NAME") then return end
	
	local head = NPC:FindFirstChild("Head")
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
	txt.Text = NPC.Name
	txt.TextScaled = false
	txt.TextSize = 14
	txt.Font = Enum.Font.SourceSansBold
	txt.TextColor3 = getColor(NPC.Name)
	txt.TextStrokeTransparency = 0
	txt.TextStrokeColor3 = Color3.new(0,0,0)
	txt.Parent = bill
	
	bill.Parent = head
end

--------------------------------------------------
-- LIMPIAR
--------------------------------------------------
local function remove(NPC)
	local head = NPC:FindFirstChild("Head")
	if head then
		local esp = head:FindFirstChild("ESP_NAME")
		if esp then esp:Destroy() end
	end
end

--------------------------------------------------
-- ACTIVAR
--------------------------------------------------
if _G.NPC_NAME_ESP then

	print("NPC NAME ESP ACTIVADO")

	-- existentes
	for _,v in ipairs(Enemies:GetChildren()) do
		create(v)
	end

	-- nuevos
	table.insert(_G.NPC_NAME_CONNS,
		Enemies.ChildAdded:Connect(function(v)
			task.wait(0.2)
			create(v)
		end)
	)

else

	print("NPC NAME ESP DESACTIVADO")

	-- desconectar
	for _,c in pairs(_G.NPC_NAME_CONNS) do
		pcall(function()
			c:Disconnect()
		end)
	end

	_G.NPC_NAME_CONNS = {}

	-- borrar todos
	for _,v in ipairs(Enemies:GetChildren()) do
		remove(v)
	end

end
