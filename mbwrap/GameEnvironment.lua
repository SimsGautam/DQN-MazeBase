local gameEnv = torch.class('mbwrap.GameEnvironment')

function gameEnv:__init(_opt)
    local _opt = _opt or {}
    self.game_path = _opt.game_path or ''
    self.verbose = _opt.verbose or 0
    self._actrep = _opt.actrep or 1
    self._random_starts = _opt.random_starts or 1
    self._screen = mbwrap.MazeMap(_opt.mazebase)
    self:reset(_opt.mazebase)
    return self
end

function gameEnv:_updateState(frame, reward, terminal, lives)
    self._state.reward = reward
    self._state.terminal = terminal
    self._state.prev_lives = self._state.lives or lives
    self._state.lives = lives
    return self
end

function gameEnv:getState()
    --
end

function gameEnv:reset(mazebase_options)
    --initialize self.game, self._actions
    local env
    local params = _params
    if self.game then
        env = self.game.name
    end
    env = _env or env
    
    self.game = mbwrap.MovingGoals(mazebase_options)
    if self.verbose > 0 then
        print('\nPlaying:', self.game.name)
    end
    self:_resetState()
    self:_updateState(self:_step(0))
    self:getState()
    return self
end

function gameEnv:_resetState()
    --
end

function gameEnv:_step(action)
    --function plays 'action' in the game and returns game state

end

function gameEnv:_randomStep()
    --function plays one random action in the game and returns game state
    return self:_step(self._actions[torch.random(#self._actions)])
end

function gameEnv:step(action, training)
    -- training is boolean, returns self:getState()
end

function gameEnv:newGame()
    --
end

function gameEnv:nextRandomGame(k)
    --
end

function gameEnv:nObsFeature()
    -- returns feature dimension
end

function gameEnv:getActions()
    return self.game:actions()
end

