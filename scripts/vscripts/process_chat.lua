challenges = {
	"I accommodated the embarrassing pharaoh",
	"At the cemetery his conscientious pterodactyl lay",
	"Peter Piper picked a peck of pickled peppers",
	"The playwright’s handkerchief is recommended",
	"The disappearance of aggressive chauffeurs was foreseeable"
}

prompt = "Enter the following phrase in chat exactly:"
correct = "GOOD JOB!"
incorrect = "Ritual Failed!"

function clear()
	Notifications:ClearTopFromAll()
	Notifications:ClearBottomFromAll()
end


function ChatListened (eventInfo)
	if listening then
		if eventInfo.playerid == ritual_caster:GetPlayerOwnerID() then
			print("ChatListened")
			input = eventInfo.text
			check(phrase)
		end
	end
end

function test(hCaster)
	clear()
	ritual_caster = hCaster
	listening = true
	print("test")
	rand = math.random(1, 5)
	phrase = challenges[rand]
	print(phrase)
	Notifications:Top(hCaster:GetPlayerOwner(), {text=prompt, duration=10, style={color="white", ["font-size"]="50px"}})
	Notifications:Bottom(hCaster:GetPlayerOwner(), {text=phrase, duration=10, style={color="white", ["font-size"]="80px"}})
	ListenToGameEvent("player_chat", ChatListened, nil)
end

function check(correct_str)
	print("check")
	listening = false
	if input == correct_str then
		clear()
		Notifications:Bottom(ritual_caster:GetPlayerOwner(), {text=correct, duration=3, style={color="white", ["font-size"]="80px"}})
		ritual_caster:Interrupt()
		--and whatever else needs to happen for scorekeeping
	else
		clear()
		Notifications:Bottom(ritual_caster:GetPlayerOwner(), {text=incorrect, duration=3, style={color="white", ["font-size"]="80px"}})
	end
end
