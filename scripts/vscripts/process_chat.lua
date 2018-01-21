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
	print("ChatListened")
	input = eventInfo.text
	listening = false;
	check(phrase)
end

function channelFinished() 
	print("herp derp")	
	if listening then
		clear()		
		Notifications:Bottom(PlayerResource:GetPlayer(0), {text=incorrect, duration=3, style={color="white", ["font-size"]="80px"}})
	end
end


function test(caster)
	ritual_caster = caster
	print("test")
	rand = math.random(1, 5)
	phrase = challenges[rand]
	print(phrase)
	Notifications:Top(PlayerResource:GetPlayer(0), {text=prompt, duration=10, style={color="white", ["font-size"]="50px"}})
	Notifications:Bottom(PlayerResource:GetPlayer(0), {text=phrase, duration=10, style={color="white", ["font-size"]="80px"}})
	listening = true;
	ListenToGameEvent("player_chat", ChatListened, nil)
end

function check(correct_str)
	print("check")
	if input == correct_str then
		clear()
		Notifications:Bottom(PlayerResource:GetPlayer(0), {text=correct, duration=3, style={color="white", ["font-size"]="80px"}})
		ritual_caster.Interrupt()
		--and whatever else needs to happen for scorekeeping
	else
		clear()
		Notifications:Bottom(PlayerResource:GetPlayer(0), {text=incorrect, duration=3, style={color="white", ["font-size"]="80px"}})
	end
end
