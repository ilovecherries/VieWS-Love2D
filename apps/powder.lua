local Powder = {}

function Powder.setup()
	view:addWindow(Controls.Window {
		title = "Powder Game",
		size = Vec2(400, 456),
		setup = function(wSelf)
			local nameLabel = Controls.Label {
				position = Vec2(4, 24),
				size = Vec2(wSelf.size.x - 8, 8),
				text = "Powder Game",
			}
			wSelf:addControl(nameLabel)

			local closeButton = Controls.Button {
				position = Vec2(66, 44),
				size = Vec2(58, 16),
				text = "Close",
			}
			closeButton.mouseClick = function(cSelf, m)
				wSelf:close()
			end
			wSelf:addControl(closeButton)
		end,
	})
end

return Powder