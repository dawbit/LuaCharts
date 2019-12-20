require "turtle"
package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
require("wx")

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@OKIENKOWATOR@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
frame = nil

-- Create a function to encapulate the code, not necessary, but it makes it
--  easier to debug in some cases.
function main()

    -- create the wxFrame window
    frame = wx.wxFrame( wx.NULL,            -- no parent for toplevel windows
                        wx.wxID_ANY,          -- don't need a wxWindow ID
                        "Chart Generator", -- caption on the frame
                        wx.wxDefaultPosition, -- let system place the frame
                        wx.wxSize(450, 450),  -- set the size of the frame
                        wx.wxDEFAULT_FRAME_STYLE ) -- use default frame styles

    -- create a single child window, wxWidgets will set the size to fill frame
    panel = wx.wxPanel(frame, wx.wxID_ANY)

    -- connect the paint event handler function with the paint event
    --panel:Connect(wx.wxEVT_PAINT, OnPaint)
    ID_FILEPICKERCTRL = 1014
    ID_BUTTON = 1015
    ID_BITMAPCOMBOBOX = 1016
    ID_DIRPICKERCTRL = 1017
    ID_TEXTCONTROL = 1018
    
--wybor pliku do załadowania
filePath = wx.wxFilePickerCtrl(panel, ID_FILEPICKERCTRL, wx.wxGetCwd(), wx.wxFileSelectorPromptStr, wx.wxFileSelectorDefaultWildcardStr,
                                         wx.wxDefaultPosition, wx.wxDefaultSize,
                                         wx.wxFLP_USE_TEXTCTRL)


--wybor typu wykresu, zrobic ify, ktore beda wywolywac odpowiednia funkcje z opdowiednym typem wykresu;
chartTypeSelection = wx.wxBitmapComboBox(panel, ID_BITMAPCOMBOBOX, "wxBitmapComboBox",
                                         wx.wxPoint(5,25), wx.wxDefaultSize,
                                         {"Wykres liniowy", "Wykres wertykalny", "Wykres horyzontalny"},
                                         wx.wxTE_PROCESS_ENTER) 
--wybor folderu gdzie ma byc zapisany screen wykresu
 imageDir = wx.wxDirPickerCtrl(panel, ID_DIRPICKERCTRL, wx.wxGetCwd(), "Sciezka obrazka",
                                         wx.wxPoint(5,50), wx.wxDefaultSize,
                                         wx.wxDIRP_USE_TEXTCTRL)
--Nazwa obrazka do zapisu
imagename = wx.wxTextCtrl(panel, ID_TEXTCONTROL, "NazwaObrazka",
                          wx.wxPoint(5,75), wx.wxDefaultSize)
                        
--Przycisk "ok" wywołujący wykres
buttontest = wx.wxButton(panel, ID_BUTTON, "OK",
                        wx.wxPoint(5,100), wx.wxDefaultSize)
                      

--Opcjonalnie zrobić 2 pola tekstowe do wyboru rozmiaru okna z wykresem

print("aaa")
print(filePath.path);
    -- create a simple file menu
    local fileMenu = wx.wxMenu()
    fileMenu:Append(wx.wxID_EXIT, "E&xit", "Quit the program")

    -- create a simple help menu
    local helpMenu = wx.wxMenu()
    helpMenu:Append(wx.wxID_ABOUT, "&About", "About the wxLua Minimal Application")

    -- create a menu bar and append the file and help menus
    local menuBar = wx.wxMenuBar()
    menuBar:Append(fileMenu, "&File")
    menuBar:Append(helpMenu, "&Help")

    -- attach the menu bar into the frame
    frame:SetMenuBar(menuBar)

    -- create a simple status bar
    frame:CreateStatusBar(1)
    frame:SetStatusText("Welcome to wxLua.")

    -- connect the selection event of the exit menu item to an
    -- event handler that closes the window
    frame:Connect(wx.wxID_EXIT, wx.wxEVT_COMMAND_MENU_SELECTED,
                  function (event) frame:Close(true) end )

    -- connect the selection event of the about menu item
    frame:Connect(wx.wxID_ABOUT, wx.wxEVT_COMMAND_MENU_SELECTED,
        function (event)
            wx.wxMessageBox('To generuje wykresy',
                            "O generowarce",
                            wx.wxOK + wx.wxICON_INFORMATION,
                            frame)
        end )

    frame:Connect(ID_BUTTON, wx.wxEVT_COMMAND_BUTTON_CLICKED,
        function (event)
            frame:Close(true)
            print("Przycisk naciśnion")
        end )
    -- show the frame window
    frame:Show(true)
    
    frame:Connect(ID_DIRPICKERCTRL, wx.wxEVT_COMMAND_DIRPICKER_CHANGED,
        function (event)
            print("Sciezka obrazka")
            sciezka = event:GetPath()
            print(sciezka)
        end )
      
frame:Connect(ID_TEXTCONTROL, wx.wxEVT_COMMAND_TEXT_UPDATED,
        function (event)
            print("OBRAZ")
            tekstNazwaObrazka = event:GetString()
            print(tekstNazwaObrazka)
        end )
      
frame:Connect(ID_FILEPICKERCTRL, wx.wxEVT_COMMAND_FILEPICKER_CHANGED,
        function (event)
            print("Sciezka pliku")
            sciezkaPliku = event:GetPath()
            print(sciezkaPliku)
        end )
    -- show the frame window
    frame:Show(true)
    
frame:Connect(ID_BITMAPCOMBOBOX, wx.wxEVT_COMMAND_COMBOBOX_SELECTED,
        function (event)
            print("TypWykresu")
            typWykresuTekst = event:GetString()
            print(typWykresuTekst)
        end )
    -- show the frame window
    frame:Show(true)
end

main()

-- Call wx.wxGetApp():MainLoop() last to start the wxWidgets event loop,
-- otherwise the wxLua program will exit immediately.
-- Does nothing if running from wxLua, wxLuaFreeze, or wxLuaEdit since the
-- MainLoop is already running or will be started by the C++ program.
wx.wxGetApp():MainLoop()


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@WYKRESOWATOR@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

windowTitle = "generator wykresów 2000"
open(windowTitle)
startPos = -165
width = 10
local side = 110;
numberOfData = 0
windowWidth = 1300
windowHeight = 900
size(windowWidth,windowHeight)
zero(60, windowHeight/2)
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
--os.execute("mkdir " .. (os.getenv("HOMEDRIVE")..os.getenv("HOMEPATH").."\\Lua"))
--os.execute("mkdir " .. (os.getenv("HOMEDRIVE")..os.getenv("HOMEPATH").."/Lua"))
local fileContent = read_file(sciezkaPliku); --Tutaj dać zmienną przechowującą ścieżkę wczytaną z okienka
 
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
    turn(270)
    move(scaled)
    turn(90)
    move(width)
    text(height,  90, -13, -10)
    turn(90)
    move(scaled)
    turn(90)
    move(width)
    text(tekst, -45, 13, side)
    jump(-50)
    turn(180)
    c = c + 1
end
--jump(startPos)


function drawBarHorizontal(height, width, tekst)
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

function drawBarLine(height, width, tekst)
  local scaled = (height / max) * 100
    pncl(rainbow[c])
    turn(270)
    move(scaled)
    turn(90)
    move(width)
    --text(height,  90, -13, -10)
    turn(90)
    move(scaled)
    turn(90)
    move(width)
    --text(tekst, -45, 13, side)
    jump(-50)
    turn(180)
    c = c + 1
end

function standard()
  for i = 1 , numberOfData do
    drawBar(dataArray[i][2], width, dataArray[i][1])
  end 
  
  print(numberOfData)
  pncl(colr(150,150,150))
  line(-15, 0, numberOfData*52, 0) 
  pncl(colr(0,0,0))
  line(-15, -side, -15, side) 
  text("Wartość", 0, -numberOfData*52, -side-30)
  line(-15, side, numberOfData*52, side) 
  text("Zmienna", 0, 0, side + 10)
  zapiszObrazek()
end

function horizontal()
  for i = 1 , numberOfData do
    drawBarHorizontal(dataArray[i][2], width, dataArray[i][1])
  end
  pncl(colr(150,150,150))
  line(0, -numberOfData*52, 0, 30) 
  
  zapiszObrazek()
end

function linearChart()
  for i = 1 , numberOfData do
  --drawBar(dataArray[i][2], width, dataArray[i][1])
  pncl(rainbow[i+8])
  line(30*i, tonumber(dataArray[i+1][2]), 30*i-30, tonumber(dataArray[i][2])) 
  end
  print(numberOfData)


  pncl(colr(150,150,150))
  line(-15, 0, numberOfData*52, 0) 
  pncl(colr(0,0,0))
  line(-15, -side, -15, side) 
  text("Wartość", 0, -numberOfData*52, -side-30)
  line(-15, side, numberOfData*52, side) 
  text("Zmienna", 0, 0, side + 10)
  zapiszObrazek()
end

  function zapiszObrazek()
    sciezka = sciezka .. '\\' .. tekstNazwaObrazka
    save(sciezka)
    print("Plik został zapisany w lokalizacji:")
    print(sciezka)
    wait()  
  end

--Wywoływanie odpowiednich typów wykresów
if (typWykresuTekst == "Wykres wertykalny") then standard()
  elseif (typWykresuTekst == "Wykres horyzontalny") then horizontal()
  elseif (typWykresuTekst == "Wykres liniowy") then linearChart()
  else print("Brak implementacji")
end
--end

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