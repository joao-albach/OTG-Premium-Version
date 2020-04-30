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
        if player:getStorageValue(Storage.ThreatenedDreams.TroubledMission03) == 1 then
            npcHandler:say("My sister Ikassis sent you? Blessed be her soul! Yes, it is true: I need help. Listen, I will tell you a secret but please don't break it. As you might already suspect I'm not really a swan but a fae. ...", cid)
            npcHandler:say("But other than many of my siblings I did not take over a swan's body. I'm a swan maiden and this is one of my two aspects. I can take the shape of a swan as well as that of a young maiden. ...", cid)
            npcHandler:say("But to do so I need a magical artefact: a cloak made of swan feathers. If I lose this cloak - or someone steals it from me - I'm stuck to the form of a swan and can't change shape anymore. And this is exactly what happened: ...", cid)
            npcHandler:say("A troll stalked me while I was bathing in the river and he stole my cloak. Now I am trapped in the form of a swan. Please, can you find the thief and bring back the cloak?", cid)
            npcHandler.topic[cid] = 1
        end
    elseif msgcontains(msg, "yes") then
        if npcHandler.topic[cid] == 1 then
            npcHandler:say("Thank you, human being! I guess the thieving troll headed to the mountains east of here.", cid)
            player:setStorageValue(Storage.ThreatenedDreams.TroubledMission03, 2)
        end
    end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
