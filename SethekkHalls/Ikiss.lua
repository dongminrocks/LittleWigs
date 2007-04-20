﻿------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Talon King Ikiss"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Ikiss",

	ae = "Arcane Explosion Alert",
	ae_desc = "Warn for Arcane Explosion",
	ae_trigger = "Talon King Ikiss begins to cast Arcane Explosion.",
	ae_message = "Casting Arcane Explosion!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.zonename = AceLibrary("Babble-Zone-2.2")["Sethekk Halls"]
mod.enabletrigger = boss 
mod.toggleoptions = {"ae", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE(msg)
	if self.db.profile.ae and msg == L["ae_trigger"] then
		self:Message(L["ae_message"], "Attention")
	end
end