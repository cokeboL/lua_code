local RandomMgr = require("RandomMgr")

--[[
local rates = 
{
	total = 10000,
	r1 = 1000,
	r2 = 3000,
	r3 = 5000,
	r4 = 1000,
}
--]]

function clone(object)
    local lookup = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup[object] then
            return lookup[object]
        end
        local newObject = {}
        lookup[object] = newObject
        for key, value in pairs(object) do
            newObject[_copy(key)] = _copy(value)
        end
        return setmetatable(newObject, getmetatable(object))
    end
    return _copy(object)
end

local rates =
{
	--total = 10000,
	nothing = 1000,       -- 什么都没发生
	bath = 1500,          -- 泡温泉
	itemBox = 1500,        -- 发现宝箱
	robbed = 500,         -- 被抢劫
	showLove = 800,       -- 爱心施舍
	helpSprite = 800,     -- 帮助
	fight = 3900,         -- 战斗
}

local tab = {}
for i=1, 300 do
	local k = RandomMgr:getEvent("test", clone(rates), 100)
	tab[k] = tab[k] or 0
	tab[k] = tab[k] + 1
end
print("---------")

for k, v in pairs(tab) do
	print(k, v)
end
print("---------")

function test(n)
	print(os.time())
	for i=1, n do
		local xx = math.random(1, n)
	end
	print(os.time())
end
test(10000000)