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
local fileContent = read_file(os.getenv("HOMEDRIVE")..os.getenv("HOMEPATH").."/Lua/test.txt");

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
