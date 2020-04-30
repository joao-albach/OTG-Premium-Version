local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
    end

    local player = Player(cid)
    if msgcontains(msg, 'mission') then
        if player:getStorageValue(Storage.ThreatenedDreams.TroubledMission02) == 1 then
            npcHandler:say("One of my sisters, in the disguise of a nightingale, told me that Alkestios would send you. There is a problem which is not concerning me but a wolf mother on the small island Cormaya. ...", cid)
            npcHandler:say("As we, the fae, consider ourselves guardians and protectors of plants and animals, it is important for me to help this wolf. Unfortunately, I can't do it myself because at the moment I'm bound to this vessel, this snake. ...", cid)
            npcHandler:say("Thus I can't cross the ocean to reach Cormaya. Will you help me?", cid)
            npcHandler.topic[cid] = 1
        elseif player:getStorageValue(Storage.ThreatenedDreams.TroubledMission02) == 8 then
            npcHandler:say("The wolf's ghost has found peace. Thank you, human being. However, there is someone else who needs help: A sister of mine who's bereft of something very precious. You'll find her in the guise of a swan at a small river south-east of here.", cid)
            player:setStorageValue(Storage.ThreatenedDreams.TroubledMission02, 9)
            player:setStorageValue(Storage.ThreatenedDreams.TroubledMission03, 1)
        end
    elseif msgcontains(msg, 'yes') then
        if npcHandler.topic[cid] == 1 then
            player:setStorageValue(Storage.ThreatenedDreams.TroubledMission02, 2)
            player:addItem(28656, 1)
            npcHandler:say("Nature's blessings! You may find the desperate wolf mother in the south of Cormaya. You will know the place because there is a big stone that looks like a grumpy face. ...", cid)
            npcHandler:say("At night it will weep bloody tears and only at night you will meet the ghost there. Take this talisman so you may be able to talk with animals and even plants and stones. Just don't expect that all of them will answer you.", cid)
        end
    end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
