print("owo")

local socket = require("socket")
local tcp = socket.bind("10.0.0.155", 1324)

local client = tcp:accept()
print("owo?")

love.thread.getChannel('connection'):push(true)
print("aaaaaaa")

local buffer = ""

local responses = {}

while true do
   -- it seeks for a newline it seems?
   local line, err = client:receive()
   if err then
      client:close()
      break
   end
   -----
   love.thread.getChannel('remote'):push(line)
   local resp = love.thread.getChannel('remote'):pop()
end