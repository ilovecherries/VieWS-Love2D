local Listener = {}

-- a dictionary of windows assigned from id to be controlled over connections
local window_index = 0
local windows = {}
-- -- programs that are being controlled and are piped
-- local programs = {}
local connected = false
local tcp_thread = nil

local function new_window(o)
	-- NOOOOOOOOOOO GET IT OVER THE PIPE (channel) DUMMY!
	window_index = window_index + 1
   love.thread.getChannel('vipc'):push('W'..o)
	local window = nil
	while not window do
		window = love.thread.getChannel('vipc'):pop()
	end
   windows[window_index] = window
	return window_index
end

function Listener:load()
	tcp_thread = love.thread.newThread("views/tcp/connection.lua")
	tcp_thread:start()
end

function Listener:update(dt)
	local code = love.thread.getChannel('remote'):pop()
	if code then
		if string.starts(code, 'W') then
			-- unsafe lol
			local window_def = loadstring(string.strsub(code, 1))
			love.thread.getChannel('remote'):push('W'..new_window(window_def))
		end
		print(code)
		loadstring(code)()
	end
end

function Listener:draw(screen)
	local connection = love.thread.getChannel('connection'):pop()
	if connection then
		connected = true
	end
	love.graphics.setColor(0, 0, 0)
	if connected then
		love.graphics.print("Hello!!!!", 32, 32)
	end
	for i = 1, window_index do
		-- we'll draw them once we actually have a window that was returned
		print(windows[i])
	end
end

return Listener