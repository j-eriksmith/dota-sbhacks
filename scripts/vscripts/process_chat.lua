challenges = {
	"I accommodated the embarrassing pharaoh",
	"At the cemetery his conscientious pterodactyl lay",
	"Peter Piper picked a peck of pickled peppers",
	"The playwright’s handkerchief is recommended",
	"The disappearance of aggressive chauffeurs was foreseeable"
}

prompt = "Enter the following phrase in chat exactly:"
correct = "GOOD JOB!"
incorrect = "Your input did not match! try again!"

function clear()
	Notifications:ClearTopFromAll()
	Notifications:ClearBottomFromAll()
end

function test(fixed)
	print("test")
	rand = math.random(1, 5)
	if fixed ~= 0 then--to repeat the same test
		rand = fixed 
	end
	phrase = challenges[rand]
	print(phrase)
	Notifications:Top(PlayerResource:GetPlayer(0), {text=prompt, duration=20, style={color="white", ["font-size"]="50px"}})
	Notifications:Bottom(PlayerResource:GetPlayer(0), {text=phrase, duration=20, style={color="white", ["font-size"]="80px"}})
	ListenToGameEvent("player_chat", ChatListened, nil)
end

function ChatListened (eventInfo)
	print("ChatListened")
     input = eventInfo.text
     check(phrase)
end

function check(correct_str)
	print("check")
	if input == correct_str then
		clear()
		Notifications:Bottom(PlayerResource:GetPlayer(0), {text=correct, duration=3, style={color="white", ["font-size"]="80px"}})
		--sleep(3)
	else
		clear()
		Notifications:Bottom(PlayerResource:GetPlayer(0), {text=incorrect, duration=3, style={color="white", ["font-size"]="80px"}})
		--sleep(3)
		test(0)
	end
end

function sleep(n)
    os.execute("timeout " .. tonumber(n)) -- specific to win7 (and probably higher) 
end
