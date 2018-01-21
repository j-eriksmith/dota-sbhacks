lina_tree_trap_lua = class({})

function drop(x, y, treetime)
  print(x)
  print(y)
	dist = 100
	for i=-1,1,2 do
		for j=-1,1,2 do
			CreateTempTree(Vector(x+i*dist, y+j*dist), treetime)
		end
		CreateTempTree(Vector(x+i*dist, y), treetime)
		CreateTempTree(Vector(x, y+i*dist), treetime)
	end
end

function lina_tree_trap_lua:OnSpellStart()
  local vector = self:GetCursorPosition()
  first, second = vector[1], vector[2]
  drop(first, second, self:GetDuration()) --One line Pattis
end