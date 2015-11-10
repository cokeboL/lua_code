function combination(tab, selectN)
	local ret = {}

	if selectN == 1 then
		for i=1, #tab do
			table.insert(ret, {[1] = tab[i]})
		end
	else
		for i=1, #tab do
			local newTab = {}
			for j=i+1, #tab do
				table.insert(newTab, tab[j])
			end
			
			local subTab = combination(newTab, selectN-1)
			for _, v in pairs(subTab) do
				local newRet = {}
				table.insert(newRet, tab[i])
				for _, vv in pairs(v) do
					table.insert(newRet, vv)
				end
				table.insert(ret, newRet)
			end
		end
	end

	return ret
end

function arrange(tab, selectN)
	local ret = {}

	if selectN == 1 then
		for i=1, #tab do
			table.insert(ret, {[1] = tab[i]})
		end
	else
		for i=1, #tab do
			local newTab = {}
			for j=i+1, #tab do
				table.insert(newTab, tab[j])
			end
			
			local subTab = arrange(newTab, selectN-1)
			for _, v in pairs(subTab) do
				for k=1, #v+1 do
					local newRet = {}
					for _, vv in pairs(v) do
						table.insert(newRet, vv)
					end
					table.insert(newRet, k, tab[i])
					table.insert(ret, newRet)
				end
			end
		end
	end

	return ret
end

print("--------------------------------------")

local a = {1, 2, 3, 4, 5}

local t1 = combination(a, 2)

print("combination result:")
for i, v in ipairs(t1) do
	print("idx " .. i, v[1], v[2])
end

print("--------------------------------------")

local t2 = arrange(a, 2)
print("arrange result:")
for i, v in ipairs(t2) do
	print("idx " .. i, v[1], v[2])
end

print("--------------------------------------")
