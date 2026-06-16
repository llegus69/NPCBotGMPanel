-- =========================================================
-- SISTEMA DE TRADUCCIÓN (ESPAÑOL / INGLÉS)
-- =========================================================
local L = {
    es = {
        title = "NPCBot GM Panel",
        id_text = "ID del Bot:",
        spawn_btn = "Spawn",
        delete_btn = "Borrar",
        error_id = "|cffff0000[NPCBotGP]|r Introduce una ID válida.",
        loaded = "|cff00ff00[NPCBotGMPanel]|r Addon cargado con éxito. Escribe /npcbotgp para forzar la apertura.",
        tooltip_minimap_line1 = "Click: Abrir/Cerrar Panel",
        tooltip_minimap_line2 = "Arrastrar: Mover icono",
        tooltip_class = "Click para buscar bots de esta clase.",
        lang_btn = "ES",
        -- Traducciones para el Servicio de Equipamiento (Descripciones completas)
        equip_service_btn = "Equipar",
        equip_title = "EQUIPAMIENTO DE BOTS",
        sec_rare = "- Sets Raros (Nivel Bajo) -",
        sec_epic = "- Sets Épicos (Nivel 80) -",
        sec_weapons = "- Armas y Munición -",
        btn_caster = "Hechicero",
        btn_tank = "Tanque",
        btn_plate = "Placas DPS",
        btn_leather = "Cuero DPS",
        btn_mail = "Malla DPS",
        btn_1h = "Armas 1M",
        btn_2h = "Armas 2M",
        btn_ranged = "A Distancia",
        btn_ammo = "Flechas/Balas",
        -- Ayuda
        help_title = "Guía de Equipamiento",
        help_text = "Para equipar un bot, tendrás que tener seleccionado el bot en tu objetivo (target) y elegir el equipamiento para recibir dichos ítems.",
    },
    en = {
        title = "NPCBot GM Panel",
        id_text = "Bot ID:",
        spawn_btn = "Spawn",
        delete_btn = "Delete",
        error_id = "|cffff0000[NPCBotGP]|r Please enter a valid ID.",
        loaded = "|cff00ff00[NPCBotGMPanel]|r Addon successfully loaded. Type /npcbotgp to force open.",
        tooltip_minimap_line1 = "Click: Open/Close Panel",
        tooltip_minimap_line2 = "Drag: Move icon",
        tooltip_class = "Click to lookup bots for this class.",
        lang_btn = "EN",
        -- Translations for the Equipment Service
        equip_service_btn = "Equip",
        equip_title = "BOT EQUIPMENT PANEL",
        sec_rare = "- Rare Sets (Low Level) -",
        sec_epic = "- Epic Sets (Level 80) -",
        sec_weapons = "- Weapons & Ammo -",
        btn_caster = "Caster",
        btn_tank = "Tank",
        btn_plate = "Plate DPS",
        btn_leather = "Leather DPS",
        btn_mail = "Mail DPS",
        btn_1h = "1H Weapons",
        btn_2h = "2H Weapons",
        btn_ranged = "Ranged",
        btn_ammo = "Ammo/Arrows",
        -- Help
        help_title = "Equipment Guide",
        help_text = "To equip a bot, you must have the bot selected as your target and choose the equipment to receive those items.",
    }
}

-- Idioma por defecto
local currentLang = "es" 
local EquipPanel -- Declaración anticipada para el botón de cierre

-- =========================================================
-- VENTANA PRINCIPAL (Panel Izquierdo)
-- =========================================================
local Panel = CreateFrame("Frame", "NPCBotGMPanelMain", UIParent)
Panel:SetSize(350, 275)
Panel:SetPoint("CENTER", UIParent, "CENTER", -150, 0)
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

local Title = Panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
Title:SetPoint("TOP", Panel, "TOP", 0, -18)

-- Botón Cerrar (X) - Oculta todo
local CloseButton = CreateFrame("Button", nil, Panel, "UIPanelCloseButton")
CloseButton:SetPoint("TOPRIGHT", Panel, "TOPRIGHT", -5, -5)
CloseButton:SetScript("OnClick", function()
    Panel:Hide()
    if EquipPanel then EquipPanel:Hide() end
end)

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
end

---------------------------------------------------------
-- CAJA DE TEXTO Y BOTONES INFERIORES
---------------------------------------------------------
local EditBox = CreateFrame("EditBox", "NPCBotIDEditBox", Panel, "InputBoxTemplate")
EditBox:SetSize(65, 25)
EditBox:SetPoint("BOTTOMLEFT", Panel, "BOTTOMLEFT", 25, 55)
EditBox:SetAutoFocus(false)
EditBox:SetNumeric(true)
EditBox:SetMaxLetters(7)

local EditText = EditBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
EditText:SetPoint("BOTTOMLEFT", EditBox, "TOPLEFT", 0, 5)

local SpawnButton = CreateFrame("Button", nil, Panel, "UIPanelButtonTemplate")
SpawnButton:SetSize(75, 25)
SpawnButton:SetPoint("LEFT", EditBox, "RIGHT", 10, 0)
SpawnButton:SetScript("OnClick", function()
    local botID = EditBox:GetText()
    if botID and botID ~= "" then
        SendChatMessage(".npcbot spawn " .. botID, "SAY")
        EditBox:SetText("")
        EditBox:ClearFocus()
    else
        print(L[currentLang].error_id)
    end
end)

local DeleteButton = CreateFrame("Button", nil, Panel, "UIPanelButtonTemplate")
DeleteButton:SetSize(75, 25)
DeleteButton:SetPoint("LEFT", SpawnButton, "RIGHT", 5, 0)
DeleteButton:SetScript("OnClick", function()
    SendChatMessage(".npcbot delete", "SAY")
end)

local EquipServiceButton = CreateFrame("Button", nil, Panel, "UIPanelButtonTemplate")
EquipServiceButton:SetSize(75, 25)
EquipServiceButton:SetPoint("LEFT", DeleteButton, "RIGHT", 5, 0)

local LangButton = CreateFrame("Button", nil, Panel, "UIPanelButtonTemplate")
LangButton:SetSize(40, 20)
LangButton:SetPoint("BOTTOMRIGHT", Panel, "BOTTOMRIGHT", -20, 15)

-- =========================================================
-- VENTANA DE EQUIPAMIENTO (Altura Máxima: 360x460)
-- =========================================================
EquipPanel = CreateFrame("Frame", "NPCBotGP_EquipPanel", Panel)
EquipPanel:SetSize(360, 460) 
EquipPanel:SetPoint("LEFT", Panel, "RIGHT", -10, 0) 
EquipPanel:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
})
EquipPanel:Hide()

-- Título del panel de equipamiento
local EquipTitle = EquipPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
EquipTitle:SetPoint("TOP", EquipPanel, "TOP", 0, -22)

-- BOTÓN DE AYUDA [?] (Corregido y verificado para que muestre el texto siempre)
local HelpButton = CreateFrame("Button", nil, EquipPanel, "UIPanelButtonTemplate")
HelpButton:SetSize(22, 22)
HelpButton:SetPoint("TOPLEFT", EquipPanel, "TOPLEFT", 18, -18)
HelpButton:SetText("?")

HelpButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 5)
    GameTooltip:ClearLines()
    -- Título del Tooltip
    GameTooltip:AddLine(L[currentLang].help_title, 1, 0.82, 0) 
    -- Cuerpo del mensaje con forzado de salto de línea automático (true al final)
    GameTooltip:AddLine(L[currentLang].help_text, 1, 1, 1, true) 
    GameTooltip:Show()
end)
HelpButton:SetScript("OnLeave", function() 
    GameTooltip:Hide() 
end)

-- Función para crear botones con excelente espaciado
local function CreateEquipButton(text, parent, xOffset, yOffset, command)
    local btn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    btn:SetSize(130, 24)
    btn:SetPoint("TOP", parent, "TOP", xOffset, yOffset)
    btn:SetText(text)
    btn:SetScript("OnClick", function()
        SendChatMessage(command, "SAY")
    end)
    return btn
end

-- --- SECCIÓN 1: RAROS ---
local TextRare = EquipPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
TextRare:SetPoint("TOP", EquipTitle, "BOTTOM", 0, -20)

local btnCasterRare  = CreateEquipButton("Hechicero", EquipPanel, -75, -70, ".bot items caster rare")
local btnTankRare    = CreateEquipButton("Tanque", EquipPanel, 75, -70, ".bot items tank rare")
local btnPlateRare   = CreateEquipButton("Placas dps", EquipPanel, -75, -102, ".bot items platedps rare")
local btnLeatherRare = CreateEquipButton("Cuero dps", EquipPanel, 75, -102, ".bot items leatherdps rare")
local btnMailRare    = CreateEquipButton("Malla dps", EquipPanel, -75, -134, ".bot items maildps rare")

-- --- SECCIÓN 2: ÉPICOS (NIVEL 80) ---
local TextEpic = EquipPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
TextEpic:SetPoint("TOP", EquipPanel, "TOP", 0, -180)

local btnCasterEpic  = CreateEquipButton("Hechicero", EquipPanel, -75, -205, ".bot items caster epic")
local btnTankEpic    = CreateEquipButton("Tanque", EquipPanel, 75, -205, ".bot items tank epic")
local btnPlateEpic   = CreateEquipButton("Placas dps", EquipPanel, -75, -237, ".bot items platedps epic")
local btnLeatherEpic = CreateEquipButton("Cuero dps", EquipPanel, 75, -237, ".bot items leatherdps epic")
local btnMailEpic    = CreateEquipButton("Malla dps", EquipPanel, -75, -269, ".bot items maildps epic")

-- --- SECCIÓN 3: ARMAS Y MUNICIÓN ---
local TextWeapons = EquipPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
TextWeapons:SetPoint("TOP", EquipPanel, "TOP", 0, -315)

local btnW1h      = CreateEquipButton("Armas 1M", EquipPanel, -75, -340, ".bot items onehanders")
local btnW2h      = CreateEquipButton("Armas 2M", EquipPanel, 75, -340, ".bot items twohanders")
local btnRanged   = CreateEquipButton("A Distancia", EquipPanel, -75, -372, ".bot items ranged")
local btnAmmo     = CreateEquipButton("Flechas/Balas", EquipPanel, 75, -372, ".bot items arrows")

-- Mostrar/Ocultar ventana de equipamiento
EquipServiceButton:SetScript("OnClick", function()
    if EquipPanel:IsShown() then
        EquipPanel:Hide()
    else
        EquipPanel:Show()
    end
end)

-- Actualización de idiomas completa
local function UpdatePanelTexts()
    Title:SetText(L[currentLang].title)
    EditText:SetText(L[currentLang].id_text)
    SpawnButton:SetText(L[currentLang].spawn_btn)
    DeleteButton:SetText(L[currentLang].delete_btn)
    LangButton:SetText(L[currentLang].lang_btn)
    
    EquipServiceButton:SetText(L[currentLang].equip_service_btn)
    EquipTitle:SetText(L[currentLang].equip_title)
    TextRare:SetText(L[currentLang].sec_rare)
    TextEpic:SetText(L[currentLang].sec_epic)
    TextWeapons:SetText(L[currentLang].sec_weapons)
    
    -- Botones Raros
    btnCasterRare:SetText(L[currentLang].btn_caster)
    btnTankRare:SetText(L[currentLang].btn_tank)
    btnPlateRare:SetText(L[currentLang].btn_plate)
    btnLeatherRare:SetText(L[currentLang].btn_leather)
    btnMailRare:SetText(L[currentLang].btn_mail)
    
    -- Botones Épicos
    btnCasterEpic:SetText(L[currentLang].btn_caster)
    btnTankEpic:SetText(L[currentLang].btn_tank)
    btnPlateEpic:SetText(L[currentLang].btn_plate)
    btnLeatherEpic:SetText(L[currentLang].btn_leather)
    btnMailEpic:SetText(L[currentLang].btn_mail)
    
    -- Botones Armas
    btnW1h:SetText(L[currentLang].btn_1h)
    btnW2h:SetText(L[currentLang].btn_2h)
    btnRanged:SetText(L[currentLang].btn_ranged)
    btnAmmo:SetText(L[currentLang].btn_ammo)
end

LangButton:SetScript("OnClick", function()
    currentLang = (currentLang == "es") and "en" or "es"
    UpdatePanelTexts()
end)

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
    if Panel:IsShown() then 
        Panel:Hide() 
        EquipPanel:Hide()
    else 
        Panel:Show() 
    end
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
    if Panel:IsShown() then 
        Panel:Hide() 
        EquipPanel:Hide()
    else 
        Panel:Show() 
    end
end

print(L[currentLang].loaded)
