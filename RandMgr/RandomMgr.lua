local RandomMgr = {}

RandomMgr.statistical = {}

-- 随机修正参数，当某个key出现次数乘以这个系数不超过它所占的总概率就仍可触发
local randFixCoefficient = 0.95

function RandomMgr:random(v1, v2)
	local mathRandom = math.random

	self.times = self.times or 0
	
	local seed = 1008611
	math.randomseed(seed)
	for i=1, self.times do
		mathRandom(v1, v2)
	end
	self.times = self.times + 1

	return mathRandom(v1, v2)
end

--[[
name: 随机管理器的名字
rate：一组概率配置，应必须包括各个不同key对应的概率值
	  total为总概率值（即各概率之和），可选
	  example:
		AdventureEvents.eventRate =
		{
			total = 10000,        -- 可选
			nothing = 1000,       -- 什么都没发生
			bath = 1500,          -- 泡温泉
			itemBox = 1500,       -- 发现宝箱
			robbed = 500,         -- 被抢劫
			showLove = 800,       -- 爱心施舍
			helpSprite = 800,     -- 帮助
			fight = 3900,         -- 战斗
		}
period：计算概率用的一轮周期，如果传入为空，则按已经发生的次数为总数
]] 
function RandomMgr:getEvent(name, rate, period)
	self.statistical[name] = self.statistical[name] or {times = 0}
	local savedRates = self.statistical[name]
	
	if not rate.total then
		rate.total = 0
		for k, v in pairs(rate) do
			if k ~= 'total' then
				rate.total = rate.total + v
			end
		end
	end

	local function getEventX(rateTab)
		

		local ranRate = self:random(1, rateTab.total)
		local sum = 0
		for k, v in pairs(rateTab) do
			if k ~= 'total' then
				sum = sum + v
				if sum >= ranRate then
					savedRates[k] = savedRates[k] or 0
					savedRates[k] = savedRates[k] + 1
					savedRates.times = savedRates.times + 1
					print(k)
					return k
				end
			end
		end
	end

	if savedRates.times == 0 then
		return getEventX(rate)
	else
		local krate
		local randRate = {total = 0}
		for k, v in pairs(rate) do
			if k ~= 'total' then
				krate = savedRates[k] or 0
				if (randFixCoefficient * krate / (period or (savedRates.times+1))) < (v / rate.total) then
					randRate[k] = v
					randRate.total = randRate.total + v
				end
			end
		end

		local keyCnt = 0
		for k, v in pairs(randRate) do
			if k ~= 'total' then
				keyCnt = keyCnt + 1
			end
		end

		if keyCnt == 0 then
			return getEventX(rate)
		else
			return getEventX(randRate)
		end
	end
end

return RandomMgr
