function love.conf(t)
	local w, h = 512*2, 342*2
	local scale = 1
	
	t.window.width = w * scale
	t.window.height = h * scale
	
	t.window.resizable = true
	t.window.vsync = 1
end
