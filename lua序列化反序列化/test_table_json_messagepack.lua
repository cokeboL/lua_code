table.tostring = function(t)  
	local mark={}  
	local assign={}  
	local function ser_table(tbl,parent)  
	mark[tbl]=parent  
	local tmp={}  
	for k,v in pairs(tbl) do  
	local key= type(k)=="number" and "["..k.."]" or "[".. string.format("%q", k) .."]"  
	if type(v)=="table" then  
	local dotkey= parent.. key  
	if mark[v] then  
	table.insert(assign,dotkey.."='"..mark[v] .."'")  
	else  
	table.insert(tmp, key.."="..ser_table(v,dotkey))  
	end  
	elseif type(v) == "string" then  
	table.insert(tmp, key.."=".. string.format('%q', v))  
	elseif type(v) == "number" or type(v) == "boolean" then  
	table.insert(tmp, key.."=".. tostring(v))  
	end  
	end  
	return "{"..table.concat(tmp,",").."}"  
	end  
	return "do local ret="..ser_table(t,"ret")..table.concat(assign," ").." return ret end"  
end  

table.loadstring = function(strData)  
    local f = loadstring(strData)  
    if f then  
       return f()  
    end  
end

local loop = 1000000

local t1, t2, len_, st, sj, sp
t1 = os.time()
print("start: ", t1)
for i=1, loop do
	local a = {}
	a.n = 10
	a.b = 'b'
	a.c = {c='c'}
	local s = table.tostring(a)
	if i==1 then
		len_ = string.len(s)
		st = s
	end
	local t = table.loadstring(s)
end
t2 = os.time()
print("end  : ", t2)
print("use  : ", t2-t1)
print("st   :", len_, st)

local json = require("json")
t1 = os.time()
print("start: ", t1)
for i=1, loop do
	local a = {}
	a.n = 10
	a.b = 'b'
	a.c = {c='c'}
	local s = json.encode(a)
	if i==1 then
		len_ = string.len(s)
		sj = s
	end
	local t = json.decode(s)
end
t2 = os.time()
print("end  : ", t2)
print("use  : ", t2-t1)
print("sj   :", len_, sj)


local mp = require("MessagePack")
t1 = os.time()
print("start: ", t1)
for i=1, loop do
	local a = {}
	a.n = 10
	a.b = 'b'
	a.c = {c='c'}
	local s = mp.pack(a)
	if i==1 then
		len_ = string.len(s)
		sp = s
	end
	local t = mp.unpack(s)
end
t2 = os.time()
print("end  : ", t2)
print("use  : ", t2-t1)
print("sj   :", len_, sp)
local t = mp.unpack(sp)
print(t.c.c)

