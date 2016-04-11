local gameEnv = torch.class('mbwrap.GameEnvironment')

function gameEnv:__init(g_opts)
    g_opts = {}
    g_opts.games_config_path = 'games/config/game_config.lua'

    -- Specify game environment
    g_opts.game = 'MovingGoals'

    g_init_vocab()
    g_init_game()

    self.g = new_game()

    -- local _opt = _opt or {}
    -- self.game_path = _opt.game_path or ''
    -- self.verbose = _opt.verbose or 0
    -- self._actrep = _opt.actrep or 1
    -- self._random_starts = _opt.random_starts or 1
    -- self._screen = alewrap.GameScreen(_opt.pool_frms, _opt.gpu)
    -- self:reset(_opt.env, _opt.env_params, _opt.gpu)
    return self
end

--DONE
function gameEnv:_updateState(frame, reward, terminal)
    self._state.observation = frame
    self._state.reward = reward
    self._state.terminal = terminal
    return self
end

--TODO
function gameEnv:getState()
    --returns screen, reward, terminal
    self._state.observation = self._state.observation or self.g.map:to_image():clone()
    self._state.observation:copy(self._screen:grab())
    return self._state.observation, self._state.reward, self._state.terminal
end

-- function gameEnv:reset(mazebase_options)
--     --initialize self.game, self._actions

-- end

-- function gameEnv:_resetState()
--     --
-- end

-- function gameEnv:_step(action)
--     --function plays 'action' in the game and returns game state
-- end

function gameEnv:_randomStep()
    --function plays one random action in the game and returns game state
    return self:_step(self._actions[torch.random(#self._actions)])
end

function gameEnv:step(action, training)
    -- training is boolean, returns self:getState()
    assert(action)
    self.g:act(action)
    self.g:update()
    frame = self.g.map:to_image()
    reward = self.g:get_reward()
    terminal = self.g:is_terminal()
    self:_updateState(frame, cumulated_reward, terminal)
    return self:getState()
end

function gameEnv:newGame()
    -- creates new game
    self.g = new_game()
    -- take one null action in the new game
    frame = self.g.map:to_image()
    reward = 0
    terminal = false
    return self:_updateState(frame, reward, terminal):getState()
end

function gameEnv:nextRandomGame(k)
    -- currently, this wrapper does not support random_starts
    print("mbwrapper does not support random_starts > 0")
    os.exit()
end

function gameEnv:nObsFeature()
    -- returns feature dimension
    frame_size = self.g.map:to_image():size()
    return frame_size[1]*frame_size[2]*frame_size[3]

end

function gameEnv:getActions()
    return self.g.agent.action_names
end

