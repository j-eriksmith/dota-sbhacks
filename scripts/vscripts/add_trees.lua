coords = {
	{-2614, -1311}, --1
	{-2077, -1889},
	{-950, -1600},
	{-1375, -950},
	{-1750, -175},
	{-1293, 793}, --6
	{-530, -135},
	{337, -919},
	{720, -1415},
	{1101, -651},
	{630, 300}, --11
	{7, 752},
	{710, 917},
	{1370, 236},
	{2000, 630},
	{1890, 1475}, --16
	{2442, 1701}
}

function addTree()
	rand = math.random(1, 17)
	print(coords[rand][1])
	print(coords[rand][2])
	vec = {}
	vec[1] = coords[rand][1]
	vec[2] = coords[rand][2]
	print("tree added?")
	CreateTempTree(Vector(coords[rand][1], coords[rand][2], 0), 100000)
end

Timers: CreateTimer(5, addTree)
