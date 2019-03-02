-- Classic by rxi

local Object = {}
Object.__index = Object

function Object:new() end

function Object:extend()
	local class = {}
	
	for k, v in pairs(self) do
		if k:find("__") == 1 then
			class[k] = v
		end
	end
	
	class.__index = class
	class.super = self
	
	setmetatable(class, self)
	return class
end

function Object:implement(...)
	for _, class in pairs{...} do
		for k, v in pairs(class) do
			if self[k] == nil and type(v) == "function" then
				self[k] = v
			end
		end
	end
end

function Object:is(T)
	local mt = getmetatable(self)
	
	while mt do
		if mt == T then
			return true
		end
		mt = getmetatable(mt)
	end
	
	return false
end

function Object:__tostring()
	return "Object"
end

function Object:__call(...)
	local obj = setmetatable({}, self)
	obj:new(...)
	return obj
end

-- My dumb addition
function Object:merge(t)
	for k, v in pairs(t) do
		if t[k] ~= nil then
			self[k] = v
		end
	end
end

return Object
