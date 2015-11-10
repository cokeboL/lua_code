require'lfs'

local sep = "//"
function renamedir(path)
	local i = 1 -- 这里是upvalue,每个子目录都不一样的哦，都从1开始数
	for file in lfs.dir(path) do
		if file ~= "." and file ~= ".." then
			local f = path..sep..file
			print ("/t=> "..f.." <=")
			local attr = lfs.attributes (f)
			--assert (type(attr) == "table")
			if attr.mode == "directory" then
				renamedir(f)
			else
				if f:find('php') then
					cmd = [[ren "]]..f..[[" ]]..[["txt]]..i..[[.html"]]
					i = i + 1
					print (cmd)
					os.execute(cmd)
				end
			end
		end
	end
end

function printdir(path)
	local i = 1 -- 这里是upvalue,每个子目录都不一样的哦，都从1开始数
	for file in lfs.dir(path) do
		if file ~= "." and file ~= ".." then
			local f = path..sep..file
			local attr = lfs.attributes (f)
			--assert (type(attr) == "table")
			if attr.mode == "directory" then
				printdir(f)
			else
				print(f)
			end
		end
	end
end

printdir('.')