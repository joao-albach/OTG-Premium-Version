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
        if not player:getStorageValue(Storage.ThreatenedDreams.Start) == 1 then
            npcHandler:say("I indeed have some troubles since I'm travelling this part of the world. When I took over the body of a white deer I wasn't aware that such an animal is a sought after quarry for hunters and poachers. ...", cid)
            npcHandler:say("Now I'm living in the constant danger of being caught and killed. Of course, I could just take over another animal but this deer has really grown on me. I'd like to help this beautiful stag but I need your assistance. Are you willing to help me?", cid)
            npcHandler.topic[cid] = 1
        elseif player:getStorageValue(Storage.ThreatenedDreams.TroubledMission01) == 4 then
            player:setStorageValue(Storage.ThreatenedDreams.TroubledMission01, 5)
            npcHandler:say("You succeeded! It seems the poachers have read your little faked story about killing white deer and the ensuing doom. They stopped chasing me. Thank you! ...", cid)
            npcHandler:say("You proved yourself trustworthy - at least as far as I am concerned. But as I told you I'm actually not a real animal. If you want to enter our hidden island, you must prove that you are also willing to help real animals. Would you do that?", cid)
            npcHandler.topic[cid] = 2
        elseif player:getStorageValue(Storage.ThreatenedDreams.TroubledMission01) == 5 then
            npcHandler:say("You proved yourself trustworthy - at least as far as I am concerned. But as I told you I'm actually not a real animal. If you want to enter our hidden island, you must prove that you are also willing to help real animals. Would you do that?", cid)
            npcHandler.topic[cid] = 2
        end
    elseif msgcontains(msg, 'yes') then
        if npcHandler.topic[cid] == 1 then
            player:setStorageValue(Storage.ThreatenedDreams.Start, 1)
            player:setStorageValue(Storage.ThreatenedDreams.TroubledMission01, 1)
            npcHandler:say("Your decision honours you. However, if you consider killing the poachers in question I ask you to halt. We, the fae, are rather peaceful beings and abhor bloodshed. Therefore, we must find another way to solve this problem. ...", cid)
            npcHandler:say("I already have an idea: Some birds told me that poachers are a superstitious lot. Perhaps we can get them with their own misbelief. I know that the poachers have a kind of camp north of the Green Claw Swamps. ...", cid)
            npcHandler:say("Please search it out and examine it closely. Perhaps you will find something you can use against them in order to stop them from hunting white deer.", cid)
        end
        if npcHandler.topic[cid] == 2 then
            player:setStorageValue(Storage.ThreatenedDreams.TroubledMission02, 1)
            npcHandler:say("I heard there is a problem with a wolf mother and her whelps. However, I don't know more about it. One of my sisters, Ikassis, has taken over the body of a snake. ...", cid)
            npcHandler:say("She knows more about the wolf. Seek her out in the north-west of Edron, near a circle of standing stones.", cid)
        end
    elseif msgcontains(msg, 'book') and player:getStorageValue(Storage.ThreatenedDreams.TroubledMission01) == 2 then
        npcHandler:say("I see, you found a book that contains old myths and legends about the woods and the forest animals. This could be of some use for us. If you find someone who could add a story ...", cid)
        npcHandler:say("Let's say about how it brings ill luck to kill a white deer. ...")
        npcHandler:say("As I said, poachers are rather superstitious. If they would read such a story in an old book, they probably would believe it to be true. In this case they might stop hunting me.", cid)
    end
end


npcHandler:addModule(FocusModule:new())
