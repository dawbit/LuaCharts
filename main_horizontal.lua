require "turtle"
windowTitle = "generator wykresów 2000"
open(windowTitle)
startPos = -165
width = 10
local side = 110;
numberOfData = 0
windowWidth = 1300
windowHeight = 900
size(windowWidth,windowHeight)
zero(windowWidth/2, windowHeight/2)
updt(true)

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
--print (fileContent)
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
 

local rainbow = {
"#ff0099", "#ff0037","#ff0000","#ff4400","#ff7300","#ffaa00","#ffcc00","#fff200","#d0ff00","#91ff00","#48ff00",
"#00ff3c","#00ff95","#00ffcc","#00fffb","#00e1ff","#00aaff","#0084ff","#003cff","#5100ff","#8c00ff","#bf00ff","#e600ff","#ff00c8","#ff0077"
}

dataArray = {}

local k = 1
while (explode("\n", fileContent)[k] ~= "") do
  dataArray[k] = {}
  for j = 1, 2 do
    dataArray[k][j] = explode(";", explode("\n", fileContent)[k])[j]
  end
  k = k + 1
  numberOfData = numberOfData + 1
end

--print(dataArray[2][2])
max = tonumber(dataArray[1][2])
for i = 1, numberOfData do
  if max < math.abs(tonumber(dataArray[i][2])) then max = math.abs(tonumber(dataArray[i][2])) end
end


local c = 1
print(max)
 
function drawBar(height, width, tekst)
  local scaled = (height / max) * 100
    pncl(rainbow[c])
    turn(0)
    move(scaled)
    turn(90)
    move(width)
    text(height,  0, 15, -13)
    turn(90)
    move(scaled)
    turn(90)
    move(width)
    text(tekst, 0, -10, -20)
    jump(50)
    turn(90)
    c = c + 1
end
--jump(startPos)

for i = 1 , numberOfData do
  drawBar(dataArray[i][2], width, dataArray[i][1])
end

print(numberOfData)


pncl(colr(150,150,150))
--line(numberOfData*100, -side-120, numberOfData*100, side-50) 
--pncl(colr(0,0,0))
--line(-15, side, numberOfData*52, side) 
--text("Wartość", 0, -numberOfData*52, -side-30)
--zero(0,0)
line(0, -numberOfData*52, 0, 30) 
--text("i chuj", 0, 0, side + 10)



--jump(numberOfData*-54)
--move(numberOfData*54)
--jump(numberOfData*-54)
--turn(270)
--move(150)

--drawBar(150, 10, "test1")
--drawBar(30, 10, "test2")
--drawBar(170, 10, "dłuższy test 3")
--drawBar(120, 10, "test4")
--drawBar(80, 10, "test5")
--drawBar(69, 10, "test6")
--drawBar(200, 10, "test7")


sciezka = (os.getenv("HOMEDRIVE")..os.getenv("HOMEPATH").."\\Lua")
save(os.getenv("HOMEDRIVE")..os.getenv("HOMEPATH").."\\Lua\\wykres")
print("Plik został zapisany w lokalizacji:")
print(sciezka)
wait()

--local side = 225;
--local maxx, maxy = 10, 20
--pncl(colr(200,200,200))
--line(-side, 0, side, 0) text("x", 0, side-15, 2)
--line(0, -side, 0, side) text("y", 0, 5, -side+15)
--pncl(colr(128,160,255))

--function f(x) return math.sin(x)^-1 + 1*math.cos(x) end

--local xp = -maxx
--local yp = f(xp)
--posn(xp*side/maxx, yp*(-side/maxy))
--for x = -maxx, maxx, 0.05 do
  --local y = f(x)
  --move((x-xp)*side/maxx, (y-yp)*(-side/maxy))
  --xp, yp = x, y
--end
--wait()