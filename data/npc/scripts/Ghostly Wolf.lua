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
        if player:getStorageValue(Storage.ThreatenedDreams.TroubledMission02) == 2 then
            npcHandler:say("I'm heartbroken, traveler. Some months ago, I was taking care of my three newborn whelps. They just opened their eyes and started exploring the wilderness as a hunter came by. ...", cid)
            npcHandler:say("He shot me and took my three puppies with him. I have no idea where he brought them or whether they are still alive. This uncertainty harrows me and thus I'm unable to find peace. Will you help me?", cid)
            npcHandler.topic[cid] = 1
        elseif player:getStorageValue(Storage.ThreatenedDreams.TroubledMission02) == 5 then
            npcHandler:say("So one of my babies died and another one has to live with the orcs. This makes me very sad. But at least one of them could return to the forest and found a surrogate mother. I hope it will lead a long, happy and most of all free life. ...", cid)
            npcHandler:say("Please do one last thing for me: The fur you brought me, place it in this stone's mouth. This will be a worthy resting place.", cid)
            player:setStorageValue(Storage.ThreatenedDreams.TroubledMission02, 6)
        elseif player:getStorageValue(Storage.ThreatenedDreams.TroubledMission02) == 7 then
            npcHandler:say("I guess I will stick around for a time to watch over the grave. After this final watch I will find peace, I can feel this. Thank you, human being. You redeemed me.", cid)
            player:setStorageValue(Storage.ThreatenedDreams.TroubledMission02, 8)
        end
    elseif msgcontains(msg, 'yes') then
        if npcHandler.topic[cid] == 1 then
            player:setStorageValue(Storage.ThreatenedDreams.TroubledMission02, 3)
            npcHandler:say("I didn't dare hope for it! The man told something about selling my babies to the orcs so they could train them as war wolves. ...", cid)
            npcHandler:say("I guess he mentioned Ulderek's Rock. Please search for them and - be they alive or not - return and tell me what happened to them.", cid)
        end
    end
end

local function greetMessage()
    if player:getItemCount(28656) == 1 then
        return "You are speaking the language of animals? I'm surprised. But I'm not in the right mood for a chat."
    end

    return "Grrrr"
end

npcHandler:setMessage(MESSAGE_GREET, greetMessage)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
