a = {}
function a:calcA()
	print('a calc: ' .. self.value)
end

b = {}
function b:calcB()
	print('b calc: ' .. self.value)
end

base = {}
base.__index = function(t, key)
	if a[key] then return a[key] end
	return b[key]
end

t = { value = 100 }
setmetatable(t, base)

t:calcA()
t:calcB()