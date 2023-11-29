--[[ Pause State for Flappy Game ]]


PauseState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function PauseState:enter(params)
    self.score = params.score
    self.bird = params.bird
    self.pipePairs = params.pipePairs
    self.timer = params.timer
    sounds['music']:pause()
    sounds['pausing']:play()
end

function PauseState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('p') then
        sounds['music']:play()
        gStateMachine:change('play', {
            score = self.score,
            bird = self.bird,
            pipePairs = self.pipePairs,
            timer = self.timer
        })
    end
end

function PauseState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('You have paused the game!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score so far: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(hugeFont)
    love.graphics.printf('||', 0, 120, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press \'p\' to Continue Playing!', 0, 200, VIRTUAL_WIDTH, 'center')
end