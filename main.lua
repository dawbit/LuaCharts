require "turtle"

local open = io.open
 
local function read_file(path)
    local file = open(path, "rb") -- r read mode and b binary mode
    print(path)
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end
 
--local fileContent = read_file(os.getenv("HOMEDRIVE")+os.getenv("HOMEPATH")+"\\Lua\test.txt");
os.execute("mkdir " .. (os.getenv("HOMEDRIVE")..os.getenv("HOMEPATH").."\\Lua"))
--os.execute("mkdir " .. (os.getenv("HOMEDRIVE")..os.getenv("HOMEPATH").."/Lua"))
local fileContent = read_file(os.getenv("HOMEDRIVE")..os.getenv("HOMEPATH").."\\Lua\\test.txt");
 
--- Check if a directory exists in this path
function isdir(path)
   -- "/" works on both Unix and Windows
   return exists(path.."/")
end
 
--require "lfs"
--lfs.mkdir("C:\\test")
--print(os.getenv("HOME"))
--print(os.getenv("HOMEPATH"))
--(os.getenv("HOMEDRIVE"))
--print(os.getenv("DRIVE"))
--require 'paths'
--paths.mkdir('C:\test')
print (fileContent)
--print(type(fileContent)) --string


function explode(div,str) -- credit: http://richard.warburton.it
  if (div=='') then return false end
  local pos,arr = 0,{}
  -- for each divider found
  for st,sp in function() return string.find(str,div,pos,true) end do
    table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
    pos = sp + 1 -- Jump past current divider
  end
  table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
  return arr
end
 
 --print(explode(";", explode("\n", fileContent)[1])[1])
 
startPos = -165
local rainbow = {
  "#FF0000", "#FF8F00", "#F0F000", "#00FF00", "#00FFFF", "#0000FF", "#FF00FF",
}

local c = 1

function drawBar(height, width, tekst)
  pncl(rainbow[c])
  turn(270)
  move(height)
  turn(90)
  move(width)
  turn(90)
  move(height)
  turn(90)
  move(width)
  text(tekst, -90, 14, 10)
  jump(-50)
  turn(180)
  c = c + 1
end
jump(startPos)
drawBar(150, 10, "test1")
drawBar(30, 10, "test2")
drawBar(170, 10, "dłuższy test 3")
drawBar(120, 10, "test4")
drawBar(80, 10, "test5")
drawBar(69, 10, "test6")
drawBar(200, 10, "test7")


wait()
