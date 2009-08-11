﻿----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["The Black Knight"]
local mod = BigWigs:New(boss, tonumber(("$Revision: 550 $"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Icecrown"
mod.zonename = BZ["Trial of the Champion"]
mod.enabletrigger = boss
mod.guid = 35451
mod.toggleoptions = {"explode", "explodeBar", "bosskill"}

--------------------------------
--        Localization        --
--------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return {
	cmd = "The Black Knight",
	explode = "Ghoul Explode",
	explodeBar = "Ghoul Explode Bar",
	explodeBar_desc = "Display a casting bar for Ghoul Explode.",
	explode_desc = "Warn when The Black Knight is going to shatter his ghouls.",
	explode_message = "Casting Ghoul Explode!",
	death_trigger = "Nein! Ich darf nicht... wieder... versagen...";-- needs the english version 
}
end )

L:RegisterTranslations("deDE", function() return {
	explode = "Ghulexplosion",
	explodeBar = "Ghulexplosion-Anzeige",
	explodeBar_desc = "Eine Zauberleiste für Ghulexplosion anzeigen.",
	explode_desc = "Warnen wenn der Schwarze Ritter seine Ghule zerschmettert.",
	explode_message = "Zaubert Ghoulexplosion!",
	death_trigger = "Nein! Ich darf nicht... wieder... versagen...", -- needs check
}
end )

L:RegisterTranslations("zhCN", function() return {
	explode = "食尸鬼爆炸",
	explodeBar = "食尸鬼爆炸计时条",
	explodeBar_desc = "当正在施放食尸鬼爆炸时显示计时条。",
	explode_desc = "当黑骑士粉碎他的食尸鬼时发出警报。",
	explode_message = "正在施放 食尸鬼爆炸！",
	death_trigger = "Nein! Ich darf nicht... wieder... versagen...";-- needs the english version 
}
end )

L:RegisterTranslations("zhTW", function() return {
	explode = "食屍鬼爆炸",
	explodeBar = "食屍鬼爆炸計時條",
	explodeBar_desc = "當正在施放食屍鬼爆炸時顯示計時條。",
	explode_desc = "當黑騎士準備粉碎他的食屍鬼時發出警報。",
	explode_message = "正在施放 食屍鬼爆炸！",
	death_trigger = "Nein! Ich darf nicht... wieder... versagen...";-- needs the english version 
}
end )

L:RegisterTranslations("ruRU", function() return {
	explode = "Взрыв вурдалака",
	explodeBar = "Полоса Взрыва вурдалака",
	explodeBar_desc = "Отображать полосу применения Взрыва вурдалака.",
	explode_desc = "Предупреждать когда Черный рыцарь взрывает приспешника-вурдалака.",
	explode_message = "Применение Взрыва вурдалака!",
	--death_trigger = "Nein! Ich darf nicht... wieder... versagen...";
}
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "explode", 67886, 51874, 47496, 67729, 67751)
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:explode(_, spellId, _, _, spellName)
	if self.db.profile.explode then
		self:IfMessage(L["explode_message"], "Urgent", spellId)
	end
	if self.db.profile.explodeBar then
		self:Bar(spellName, 4, spellId)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["death_trigger"] then
		self:BossDeath(nil, self.guid)
	end
end