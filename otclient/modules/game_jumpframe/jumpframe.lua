local jumpFrame = nil
local jumpButton = nil

function init()
  connect(g_game, { onGameStart = online,
                    onGameEnd   = offline })

  jumpFrame = g_ui.displayUI('jumpframe', modules.game_interface.getRightPanel())
  jumpFrame:hide()

  jumpButton = jumpFrame:getChildById('jumpClick')
  if jumpButton then
    jumpButton.onClick = function()
      moveJumpButton(jumpButton, jumpFrame)
    end
  end

  if g_game.isOnline() then
    online()
  end
end

function terminate()
  disconnect(g_game, { onGameStart = online,
                       onGameEnd   = offline })

  jumpFrame:destroy()
end

function online()
  jumpFrame:show()
end

function offline()
  jumpFrame:hide()
end

function moveJumpButton(jumpButton, jumpFrame)
  -- Get the center position of the jumpFrame
  local frameCenterX = jumpFrame:getX() + jumpFrame:getWidth() / 2
  local frameCenterY = jumpFrame:getY() + jumpFrame:getHeight() / 2

  -- Calculate the top-left corner of the 300x300 area centered around the frame's center
  local areaStartX = frameCenterX - 150
  local areaStartY = frameCenterY - 150

  -- Generate random positions within the 300x300 pixel area centered on the jumpFrame
  local randomX = math.random(areaStartX+30, areaStartX + 300 - jumpButton:getWidth())
  local randomY = math.random(areaStartY+30, areaStartY + 300 - jumpButton:getHeight())

  -- Create a point structure if required by the setPosition method
  local point = {x = randomX, y = randomY}

  -- Use setPosition with a point structure
  jumpButton:setPosition(point)
end