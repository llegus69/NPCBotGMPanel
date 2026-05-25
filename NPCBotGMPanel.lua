-- =========================================================
-- SISTEMA DE TRADUCCIÓN (ESPAÑOL / INGLÉS)
-- =========================================================
local L = {
    es = {
        title = "NPCBot GM Panel",
        id_text = "ID del Bot:",
        spawn_btn = "Spawn Bot",
        delete_btn = "Borrar Bot",
        error_id = "|cffff0000[NPCBotGP]|r Introduce una ID válida.",
        loaded = "|cff00ff00[NPCBotGMPanel]|r Addon cargado con éxito. Escribe /npcbotgp para forzar la apertura.",
        tooltip_minimap_line1 = "Click: Abrir/Cerrar Panel",
        tooltip_minimap_line2 = "Arrastrar: Mover icono",
        tooltip_class = "Click para buscar bots de esta clase.",
        lang_btn = "ES",
    },
    en = {
        title = "NPCBot GM Panel",
        id_text = "Bot ID:",
        spawn_btn = "Spawn Bot",
        delete_btn = "Delete Bot",
        error_id = "|cffff0000[NPCBotGP]|r Please enter a valid ID.",
        loaded = "|cff00ff00[NPCBotGMPanel]|r Addon successfully loaded. Type /npcbotgp to force open.",
        tooltip_minimap_line1 = "Click: Open/Close Panel",
        tooltip_minimap_line2 = "Drag: Move icon",
        tooltip_class = "Click to lookup bots for this class.",
        lang_btn = "EN",
    }
}

-- Idioma por defecto (cambia a "en" si prefieres que empiece en inglés)
local currentLang = "es" 

-- =========================================================
-- VENTANA PRINCIPAL
-- =========================================================
local Panel = CreateFrame("Frame", "NPCBotGMPanelMain", UIParent)
Panel:SetSize(350, 260)
Panel:SetPoint("CENTER", UIParent, "CENTER")
Panel:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
})
Panel:SetMovable(true)
Panel:EnableMouse(true)
Panel:RegisterForDrag("LeftButton")
Panel:SetScript("OnDragStart", Panel.StartMoving)
Panel:SetScript("OnDragStop", Panel.StopMovingOrSizing)
Panel:Hide()

-- Título
local Title = Panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
Title:SetPoint("TOP", Panel, "TOP", 0, -15)

-- Botón Cerrar (X)
local CloseButton = CreateFrame("Button", nil, Panel, "UIPanelCloseButton")
CloseButton:SetPoint("TOPRIGHT", Panel, "TOPRIGHT", -5, -5)

---------------------------------------------------------
-- ICONOS DE CLASE
---------------------------------------------------------
local classes = {
    { id = 1,  name = "Warrior", icon = "Interface\\Icons\\Ability_Warrior_Revenge" },
    { id = 2,  name = "Paladin", icon = "Interface\\Icons\\Spell_Holy_LightsGrace" },
    { id = 3,  name = "Hunter",  icon = "Interface\\Icons\\INV_Weapon_Bow_07" },
    { id = 4,  name = "Rogue",   icon = "Interface\\Icons\\Ability_Rogue_Ambush" },
    { id = 5,  name = "Priest",  icon = "Interface\\Icons\\Spell_Holy_WordFortitude" },
    { id = 6,  name = "DK",      icon = "Interface\\Icons\\Spell_DeathKnight_ClassIcon" },
    { id = 7,  name = "Shaman",  icon = "Interface\\Icons\\Spell_Nature_BloodLust" },
    { id = 8,  name = "Mage",    icon = "Interface\\Icons\\Spell_Frost_FrostBolt02" },
    { id = 9,  name = "Warlock", icon = "Interface\\Icons\\Spell_Shadow_DeathCoil" },
    { id = 11, name = "Druid",   icon = "Interface\\Icons\\Ability_Druid_TravelForm" },
}

local startX = 35
local startY = -50
local buttonSize = 45
local spacing = 15
local classButtons = {}

for i, classData in ipairs(classes) do
    local row = math.floor((i - 1) / 5)
    local col = (i - 1) % 5

    local btn = CreateFrame("Button", nil, Panel)
    btn:SetSize(buttonSize, buttonSize)
    btn:SetPoint("TOPLEFT", Panel, "TOPLEFT", startX + (col * (buttonSize + spacing)), startY - (row * (buttonSize + spacing)))
    
    local t = btn:CreateTexture(nil, "BACKGROUND")
    t:SetTexture(classData.icon)
    t:SetAllPoints(btn)
    btn:SetNormalTexture(t)
    
    local highlight = btn:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
    highlight:SetAllPoints(btn)
    btn:SetHighlightTexture(highlight)

    local pushed = btn:CreateTexture(nil, "PUSHED")
    pushed:SetTexture("Interface\\Buttons\\UI-Quickslot-Depress")
    pushed:SetAllPoints(btn)
    btn:SetPushedTexture(pushed)

    btn:SetScript("OnClick", function()
        SendChatMessage(".npcbot lookup " .. classData.id, "SAY")
    end)
    
    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(classData.name, 1, 1, 1)
        GameTooltip:AddLine(L[currentLang].tooltip_class, 0.5, 0.5, 0.5)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    table.insert(classButtons, btn)
end

---------------------------------------------------------
-- CAJA DE TEXTO Y ACCIONES
---------------------------------------------------------
local EditBox = CreateFrame("EditBox", "NPCBotIDEditBox", Panel, "InputBoxTemplate")
EditBox:SetSize(80, 25)
EditBox:SetPoint("BOTTOMLEFT", Panel, "BOTTOMLEFT", 30, 30)
EditBox:SetAutoFocus(false)
EditBox:SetNumeric(true)
EditBox:SetMaxLetters(7)

local EditText = EditBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
EditText:SetPoint("BOTTOMLEFT", EditBox, "TOPLEFT", 0, 5)

local SpawnButton = CreateFrame("Button", nil, Panel, "UIPanelButtonTemplate")
SpawnButton:SetSize(90, 25)
SpawnButton:SetPoint("LEFT", EditBox, "RIGHT", 15, 0)
SpawnButton:SetScript("OnClick", function()
    local botID = EditBox:GetText()
    if botID and botID ~= "" then
        SendChatMessage(".npcb spawn " .. botID, "SAY")
        EditBox:SetText("")
        EditBox:ClearFocus()
    else
        print(L[currentLang].error_id)
    end
end)

local DeleteButton = CreateFrame("Button", nil, Panel, "UIPanelButtonTemplate")
DeleteButton:SetSize(90, 25)
DeleteButton:SetPoint("LEFT", SpawnButton, "RIGHT", 10, 0)
DeleteButton:SetScript("OnClick", function()
    SendChatMessage(".npcb delete", "SAY")
end)

---------------------------------------------------------
-- BOTÓN DE IDIOMA (Intercambiador ES / EN)
---------------------------------------------------------
local LangButton = CreateFrame("Button", nil, Panel, "UIPanelButtonTemplate")
LangButton:SetSize(35, 20)
LangButton:SetPoint("TOPLEFT", Panel, "TOPLEFT", 12, -12)

-- Función central para actualizar todos los textos dinámicamente
local function UpdatePanelTexts()
    Title:SetText(L[currentLang].title)
    EditText:SetText(L[currentLang].id_text)
    SpawnButton:SetText(L[currentLang].spawn_btn)
    DeleteButton:SetText(L[currentLang].delete_btn)
    LangButton:SetText(L[currentLang].lang_btn)
end

LangButton:SetScript("OnClick", function()
    if currentLang == "es" then
        currentLang = "en"
    else
        currentLang = "es"
    end
    UpdatePanelTexts()
end)

-- Ejecutar la actualización inicial de textos
UpdatePanelTexts()

---------------------------------------------------------
-- BOTÓN DEL MINIMAPA
---------------------------------------------------------
local MinimapBtn = CreateFrame("Button", "NPCBotGP_MinimapButton", Minimap)
MinimapBtn:SetSize(31, 31)
MinimapBtn:SetFrameStrata("HIGH")
MinimapBtn:SetFrameLevel(10)

local btnIcon = MinimapBtn:CreateTexture(nil, "BACKGROUND")
btnIcon:SetSize(20, 20)
btnIcon:SetTexture("Interface\\Icons\\INV_Misc_Gear_01")
btnIcon:SetPoint("CENTER", 0, 0)

local btnBorder = MinimapBtn:CreateTexture(nil, "OVERLAY")
btnBorder:SetSize(53, 53)
btnBorder:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
btnBorder:SetPoint("TOPLEFT", -7, 7)

local MinimapAngle = 45 
local function UpdateMinimapButtonPos()
    local x = math.cos(math.rad(MinimapAngle)) * 80
    local y = math.sin(math.rad(MinimapAngle)) * 80
    MinimapBtn:SetPoint("CENTER", Minimap, "CENTER", x, y)
end
UpdateMinimapButtonPos()

MinimapBtn:RegisterForDrag("LeftButton")
MinimapBtn:SetScript("OnDragStart", function(self)
    self:SetScript("OnUpdate", function()
        local mx, my = Minimap:GetCenter()
        local cx, cy = GetCursorPosition()
        local scale = Minimap:GetEffectiveScale()
        cx, cy = cx / scale, cy / scale
        MinimapAngle = math.deg(math.atan2(cy - my, cx - mx))
        UpdateMinimapButtonPos()
    end)
end)
MinimapBtn:SetScript("OnDragStop", function(self)
    self:SetScript("OnUpdate", nil)
end)

MinimapBtn:SetScript("OnClick", function()
    if Panel:IsShown() then Panel:Hide() else Panel:Show() end
end)

MinimapBtn:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText(L[currentLang].title, 1, 1, 1)
    GameTooltip:AddLine(L[currentLang].tooltip_minimap_line1, 0.5, 1, 0.5)
    GameTooltip:AddLine(L[currentLang].tooltip_minimap_line2, 0.5, 0.5, 0.5)
    GameTooltip:Show()
end)
MinimapBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

---------------------------------------------------------
-- COMANDO DE CONSOLA Y INICIO
---------------------------------------------------------
SLASH_NPCBOTGP1 = "/npcbotgp"
SlashCmdList["NPCBOTGP"] = function()
    if Panel:IsShown() then Panel:Hide() else Panel:Show() end
end

print(L[currentLang].loaded)