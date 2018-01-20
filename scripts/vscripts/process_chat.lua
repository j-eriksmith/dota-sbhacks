function ChatListened (eventInfo)
     input = eventInfo.text
     check("I accommodated the embarrassing pharaoh at the cemetery where his conscientious pterodactyl forever lay")
end

--this function to test if input is globally accessible
function prent()
  print(input)
  print("prent")
end

function check(correct_str)
	if input == correct_str then
		print("good job!")
	else
		print("your input did not match!")
	end
end