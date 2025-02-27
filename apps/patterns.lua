local Patterns = {}

function Patterns.setup(s)
	s = s or {}
	local secret = {
		cells = s.cells or Vec2(8, 8),
		cellSize = s.cellSize or Vec2(8, 8),
	}
	secret.total = secret.cells * secret.cellSize + 1
	
	view:addWindow(Controls.Window {
		title = "Desktop Patterns",
		
		size = Vec2(secret.total.x + 82, math.max(65, secret.total.y) + 40),
		
		setup = function(wSelf)
			local currentPattern = view.desktop.patternData
			local appliedPatternData = {}
			for i = 1, (secret.cells.x * secret.cells.y) do
				appliedPatternData[i] = currentPattern[i] or #VieWS.PALETTE
			end
			local appliedPatternFlipH = currentPattern.flipH or false
			local appliedPatternFlipV = currentPattern.flipV or false
			
			local selectedColor = 1
			local palettePicker = Controls.Picker {
				position = Vec2(8, 8),
				
				width = secret.total.x,
				height = 16,
				
				elements = {
					{ value = 1 },
					{ value = 2 },
					{ value = 3 },
					{ value = 4 },
				},
				
				foolishOnChange = function(v) selectedColor = v end,
			}
			wSelf:addControl(palettePicker)
			
			local patternPixelGrid = Controls.PixelGrid {
				position = Vec2(8, 32),
				size = secret.total,
				
				cells = secret.cells,
				cellSize = secret.cellSize,
				
				cellData = appliedPatternData,
				
				foolishGetData = function() return selectedColor end,
			}
			wSelf:addControl(patternPixelGrid)
			
			local flipHCheckBox = Controls.CheckBox {
				position = Vec2(secret.total.x + 16, 8),
				size = Vec2(58, 16),
				
				text = "Flip H.",
				
				value = appliedPatternFlipH,
			}
			wSelf:addControl(flipHCheckBox)
			
			local flipVCheckBox = Controls.CheckBox {
				position = Vec2(secret.total.x + 16, 32),
				size = Vec2(58, 16),
				
				text = "Flip V.",
				
				value = appliedPatternFlipV,
			}
			wSelf:addControl(flipVCheckBox)
			
			local clearButton = Controls.Button {
				position = Vec2(secret.total.x + 16, 56),
				size = Vec2(29, 16),
				text = "Fill",
			}
			clearButton.mouseDown = function(m)
				for i = 1, #patternPixelGrid.cellData do
					patternPixelGrid.cellData[i] = selectedColor
				end
				patternPixelGrid.redraw = true
			end
			wSelf:addControl(clearButton)
			
			local resetButton = Controls.Button {
				position = Vec2(secret.total.x + 45, 56),
				size = Vec2(29, 16),
				text = "Orig",
			}
			resetButton.mouseClick = function(m)
				for i = 1, #patternPixelGrid.cellData do
					patternPixelGrid.cellData[i] = appliedPatternData[i]
				end
				patternPixelGrid.redraw = true
				
				flipHCheckBox:set(appliedPatternFlipH)
				flipVCheckBox:set(appliedPatternFlipV)
			end
			wSelf:addControl(resetButton)
			
			local applyButton = Controls.Button {
				position = Vec2(secret.total.x + 16, 81),
				size = Vec2(58, 16),
				text = "Apply",
			}
			applyButton.mouseClick = function(cSelf, m)
				for i = 1, #patternPixelGrid.cellData do
					appliedPatternData[i] = patternPixelGrid.cellData[i]
				end
				
				appliedPatternData.width  = secret.cells.x
				appliedPatternData.height = secret.cells.y
				
				appliedPatternData.flipH = flipHCheckBox.value
				appliedPatternData.flipV = flipVCheckBox.value
				
				view.desktop:setPattern(appliedPatternData)
				-- view:modal("Pattern applied to desktop!", nil, nil, wSelf)
			end
			wSelf:addControl(applyButton)
		end,
	})
end
	
return Patterns
