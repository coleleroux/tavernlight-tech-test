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
  -- Generate random positions within the 300x300 pixel area of the JumpFrame
  -- This ensures the button moves within the bounds of its parent frame
  local randomX = math.random(0, jumpFrame:getWidth() - jumpButton:getWidth())
  local randomY = math.random(0, jumpFrame:getHeight() - jumpButton:getHeight())

  -- Move the jumpButton to the new position
  -- setMarginTop and setMarginLeft are used to adjust the button's position
  jumpButton:setMarginTop(randomY)
  jumpButton:setMarginLeft(randomX)

  -- Toggle the button text between "Google" and "Jump"
  -- This provides a visual feedback that the button was clicked
  if jumpButton:getText() == "Jump" then
    jumpButton:setText("Google")
  else
    jumpButton:setText("Jump")
  end
end