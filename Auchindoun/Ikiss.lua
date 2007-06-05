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

	ae = "Arcane Explosion",
	ae_desc = "Warn for Arcane Explosion",
	ae_trigger = "Talon King Ikiss casts Blink.",
	ae_message = "Casting Arcane Explosion!",
} end )

L:RegisterTranslations("koKR", function() return {
	ae = "신비한 폭발",
	ae_desc = "신비한 폭발에 대한 경고입니다.",
	ae_trigger = "갈퀴대왕 이키스|1이;가; 점멸|1을;를; 시전합니다.", -- check
	ae_message = "신비한 폭발 시전!",
} end )

L:RegisterTranslations("zhTW", function() return {
	ae = "魔爆術",
	ae_desc = "魔爆術警報",
	ae_trigger = "鷹王伊奇斯開始施放魔爆術。",
	ae_message = "即將施放魔爆術！ 快找掩蔽物！",
} end )

L:RegisterTranslations("frFR", function() return {
	ae = "Explosion des arcanes",
	ae_desc = "Préviens quand Ikiss lance son Explosion des arcanes.",
	ae_trigger = "Roi-serre Ikiss lance Transfert.",
	ae_message = "Explosion des arcanes en incantation !",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
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
