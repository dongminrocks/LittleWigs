﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Sjonnir The Ironshaper"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Sjonnir",

	charge = "Static Charge",
	charge_desc = "Warn for who has the Static Charge.",

	chargeBar = "Static Charge Bar",
	chargeBar_desc = "Display a bar for the duration of the Static Charge debuff.",

	charge_message = "Static Charge: %s",

	ring = "Lightning Ring",
	ring_desc = "Warn for Lightning Ring.",

	ringBar = "Lightning Ring Cast Bar",
	ringBar_desc = "Display a channel casting bar for Lightning Ring.",

	ring_message = "Lightning Ring!",
} end)

L:RegisterTranslations("deDE", function() return {
	charge = "Statische Aufladung",
	charge_desc = "Warnt wer die Statische Aufladung hat.",

	chargeBar = "Statische Aufladung Bar",
	chargeBar_desc = "Zeigt eine Bar für die Dauer des Statische Aufladung Debuffs.",

	charge_message = "Statische Aufladung: %s",

	ring = "Blitzring",
	ring_desc = "Warnt vor dem Blitzring.",

	ringBar = "Blitzring Zauberleiste",
	ringBar_desc = "Zeigt eine Kanalisierungs-Zauberleiste für den Blitzring.",

	ring_message = "Blitzring!",
} end)

L:RegisterTranslations("frFR", function() return {
	charge = "Charge statique",
	charge_desc = "Prévient quand un joueur subit les effets de la Charge statique.",

	chargeBar = "Charge statique - Barre",
	chargeBar_desc = "Affiche une barre indiquant la durée de la Charge statique.",

	charge_message = "Charge statique : %s",

	ring = "Anneau de foudre",
	ring_desc = "Prévient de l'arrivée de l'Anneau de foudre.",

	ringBar = "Anneau de foudre - Barre",
	ringBar_desc = "Affiche une barre indiquant la durée de canalisation de l'Anneau de foudre.",

	ring_message = "Anneau de foudre !",
} end)

L:RegisterTranslations("koKR", function() return {
	charge = "전하 충전",
	charge_desc = "전하 충전에 걸린 플레이어를 알립니다.",

	chargeBar = "전하 충전 바",
	chargeBar_desc = "전하 충전 디버프가 지속 되는 바를 표시합니다.",

	charge_message = "전하 충전: %s",

	ring = "번개 고리",
	ring_desc = "번개 고리를 알립니다.",

	ringBar = "번개 고리 시전 바",
	ringBar_desc = "번개 고리 시전 바를 표시합니다.",

	ring_message = "번개 고리!",
} end)

L:RegisterTranslations("zhCN", function() return {
	charge = "静电充能",
	charge_desc = "当玩家中了静电充能时发出警报。",

	chargeBar = "静电充能计时条",
	chargeBar_desc = "当静电充能减益持续时显示计时条。",

	charge_message = ">%s<：静电充能！",

	ring = "闪电之环",
	ring_desc = "当施放闪电之环时发出警报。",

	ringBar = "施放闪电之环计时条",
	ringBar_desc = "当正在施放闪电之环时显示计时条。",

	ring_message = "闪电之环！",
} end)

L:RegisterTranslations("zhTW", function() return {
	charge = "靜電能量",
	charge_desc = "當玩家中了靜電能量時發出警報。",

	ringBar = "靜電能量計時條",
	ringBar_desc = "當靜電能量減益持續時顯示計時條。",

	charge_message = ">%s<：靜電能量！",

	ring = "閃電環",
	ring_desc = "當施放閃電環時發出警報。",

	ringBar = "施放閃電環計時條",
	ringBar_desc = "當正在施放閃電環時顯示計時條。",

	ring_message = "閃電環！",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	charge = "Статический заряд",
	charge_desc = "Предупреждать, когда кто-нибудь статически заряжен.",

	chargeBar = "Полоса Статического заряда",
	chargeBar_desc = "Отображение полосы продолжительности дебаффа Статического заряда.",

	charge_message = "%s: статически заряжен",

	ring = "Кольцо молний",
	ring_desc = "Предупреждать о кольце молний.",

	ringBar = "Полоса Кольца молний",
	ringBar_desc = "Отображать полосу применения Кольца молний.",

	ring_message = "Кольцо молний!",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Ulduar"
mod.zonename = BZ["Halls of Stone"]
mod.enabletrigger = boss
mod.guid = 27978
mod.toggleoptions = {"charge","ring","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Charge", 50834, 59846)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Ring", 50840, 59848, 59861, 51849)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Charge(player, spellId)
	if self.db.profile.charge then
		self:IfMessage(L["charge_message"]:format(player), "Urgent", spellId)
	end
	if self.db.profile.chargeBar then
		self:Bar(L["charge_message"]:format(player), 10, spellId)
	end
end

function mod:Ring(_, spellId)
	if self.db.profile.ring then
		self:IfMessage(L["ring_message"], "Urgent", spellId)
	end
	if self.db.profile.ringBar then
		self:Bar(L["ring_message"], 10, spellId)
	end
end