function drop(x, y)
	dist = 100
	for i=-1,1,2
		for j=-1,1,2
			CreateTempTree(x+i*dist, y+j*dist, 0), 3)
		end
		CreateTempTree(x+i*dist, y, 0), 3)
		CreateTempTree(x, y+i*dist, 0), 3)
	end
end

function trap()
	local vTargetPosition = self:GetCursorPosition()
	first = vTargetPosition[1]
	second = vTargetPosition[2]
	drop(first, second)
end