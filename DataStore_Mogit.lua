if not DataStore then return end

local addonName = "DataStore_Mogit"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0", "AceSerializer-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local AddonDB_Defaults = {
	global = {
		Reference = {
			Appearances = {},
		},
	}
}

function scanAppearances()
  local appearances = addon.db.global.Reference.Appearances
  
  for i=2, 100, 1 do
    sources = C_TransmogSets.GetAppearanceSources()
    if not sources then break end
    appearances[i] = appearances[i] or {}
    for _, source in pairs(sources) do
      appearances[i][source.sourceID] = source.isCollected
    end
  end
end

local function OnPlayerAlive()
	scanAppearances()
end

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	-- DataStore:RegisterModule(addonName, addon, PublicMethods)
end

function addon:OnEnable()
  addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
  -- addon:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", OnPlayerEquipmentChanged)
  -- addon:RegisterEvent("TRANSMOG_COLLECTION_UPDATED", OnTransmogCollectionUpdated)
end

function addon:OnDisable()
  addon:UnregisterEvent("PLAYER_ALIVE")
	-- addon:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED")
end