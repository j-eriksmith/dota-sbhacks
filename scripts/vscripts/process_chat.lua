challenges = {
	"I accommodated the embarrassing pharaoh",
	"At the cemetery his conscientious pterodactyl lay",
	"Peter Piper picked a peck of pickled peppers",
	"The Playwright Handkerchief is recommended",
	"The disappearance of aggressive chauffeurs was foreseeable",
	"His righteous ignorance led to indispensable intelligence",
	"Mischievous judgement brought the neighbor to maneuver",
	"Pronunciation is a reference as rhyme is to rhythm",
	"Separate schedules create a threshold of tyranny at the restaurant",
	"Penelope pondered in her backyard hammock with sunlight bathing the sky",
	"Buffering the woods and my colleague concealed in government drunkenness"
}

spellbreak_challenges = {
	"assassination", "argument","colleague","definitely",
	"dilemma", "foreseeable", "government", "liaison",
	"Neanderthal", "necessary", "occasion", "occurrence",
	"Portuguese", "possession", "propoganda", "supersede",
	"tendency", "unforeseen", "unfortunately","wherever",
	"pharaoh", "Arctic", "deductible", "maintenance",
	"bellwether", "changeable", "committed", "consensus",
	"daiquiri", "drunkenness", "dumbbell"
}

MAX_SPELLBREAK = 2

prompt = "Enter the following phrase in chat exactly:"
spellbreaker_prompt = "Enter the words in chat! (%d of %d)"

input = ""
spellbreaker_input = ""
phrase = ""
spellbreaker_phrase = ""

correct_ritualist = "GOOD JOB!"
correct_breaker = "Opponent completed the Ritual!"
spellbreaker_win_breaker = "You got the Spellbreak!"
spellbreaker_win_ritualist = "You got Spellbroken!"
incorrect_ritualist = "Ritual Failed!"
incorrect_breaker = "Opponent failed their Ritual!"
incorrect_spellbreak = "Spellbreak failed!"

ritual_caster = nil
spellbreaker = nil
listening = false --Process chat is listening for chat responses

function resetChatVars()
	input = ""
	spellbreaker_input = ""
	phrase = ""
	spellbreaker_phrase = ""
	ritual_caster = nil
	spellbreaker = nil
	current = 1
end

function clear()
	Notifications:ClearTopFromAll()
	Notifications:ClearBottomFromAll()
end

function clearFor(iPlayerID)
	Notifications:ClearTop(iPlayerID)
	Notifications:ClearBottom(iPlayerID)
end

function ChatListened (eventInfo)
	if listening and eventInfo.playerid == ritual_caster:GetPlayerOwnerID() then
			print("RitualChatListened")
			input = eventInfo.text
			check(phrase)
	elseif listening and spellbreaker and eventInfo.playerid == spellbreaker:GetPlayerOwnerID() then
			print("SpellbreakerChatListened")
			spellbreaker_input = eventInfo.text
			print(spellbreaker_phrase, spellbreaker_input)
			if spellbreaker_phrase == spellbreaker_input then
				current = current + 1
				generate_spellbreak()
			else --Spellbreaker fails, but ritual can still be completed
				spellbreaker:Interrupt()
				clearFor(spellbreaker:GetPlayerOwnerID())
				Notifications:Bottom(spellbreaker:GetPlayerOwner(), {text=incorrect_spellbreak, duration=3, style={color="white", ["font-size"]="80px"}})
			end
	end
end

function test(hCaster)
	clear()
	ritual_caster = hCaster
	listening = true
	print("test")
	rand = math.random(1, table.getn(challenges))
	phrase = challenges[rand]
	print(phrase)
	Notifications:Top(ritual_caster:GetPlayerOwner(), {text=prompt, duration=10, style={color="white", ["font-size"]="50px"}})
	Notifications:Bottom(ritual_caster:GetPlayerOwner(), {text=phrase, duration=10, style={color="white", ["font-size"]="80px"}})
end

function spellbreak(hCaster) --Spellbreaker registered and starts his channel
	spellbreaker = hCaster
	current = 1
	generate_spellbreak()
end
	
function generate_spellbreak() --Generates a new word for the spellbreaker to spell
	clearFor(spellbreaker:GetPlayerOwnerID())	
	if current <= MAX_SPELLBREAK then
		challengeIndex = math.random(1, table.getn(spellbreak_challenges))
		spellbreaker_phrase = spellbreak_challenges[challengeIndex]
		Notifications:Top(spellbreaker:GetPlayerOwner(), {text=string.format(spellbreaker_prompt, current, MAX_SPELLBREAK), duration=10, style={color="white", ["font-size"]="50px"}})
		Notifications:Bottom(spellbreaker:GetPlayerOwner(), {text=spellbreaker_phrase, duration=10, style={color="white", ["font-size"]="80px"}})
	else
		spellbreakWin()
	end
end	

function spellbreakWin() --Spellbreaker win
	listening = false
	clear()
	ritual_caster:Interrupt()
	spellbreaker:Interrupt()
	Notifications:Bottom(ritual_caster:GetPlayerOwner(), {text=spellbreaker_win_ritualist, duration=3, style={color="white", ["font-size"]="80px"}})	
	Notifications:Bottom(spellbreaker:GetPlayerOwner(), {text=spellbreaker_win_breaker, duration=3, style={color="white", ["font-size"]="80px"}})	
	resetChatVars()
end
	
function check(correct_str)
	print("check")
	listening = false
	clear()
	ritual_caster:Interrupt()
	if spellbreaker then spellbreaker:Interrupt() end
	if input == correct_str then --Ritualist win
		Notifications:Bottom(ritual_caster:GetPlayerOwner(), {text=correct_ritualist, duration=3, style={color="white", ["font-size"]="80px"}})
		if spellbreaker then Notifications:Bottom(spellbreaker:GetPlayerOwner(), {text=correct_breaker, duration=3, style={color="white", ["font-size"]="80px"}})	end	
		--and whatever else needs to happen for scorekeeping
	else --Ritualist made an error = ritualist lose
		Notifications:Bottom(ritual_caster:GetPlayerOwner(), {text=incorrect_ritualist, duration=3, style={color="white", ["font-size"]="80px"}})
		if spellbreaker then Notifications:Bottom(spellbreaker:GetPlayerOwner(), {text=incorrect_breaker, duration=3, style={color="white", ["font-size"]="80px"}}) end
	end
	resetChatVars()
end