if not g_opts then g_opts = {} end
g_opts.multigames = {}
-------------------
--some shared RangeOpts
--current min, current max, min max, max max, increment
local mapH = torch.Tensor{10,10,10,10,1}
local mapW = torch.Tensor{10,10,10,10,1}
local blockspct = torch.Tensor{0,.05,0,.2,.01}
local waterpct = torch.Tensor{0,.05,0,.2,.01}

-------------------
--some shared StaticOpts
local sso = {}
-------------- costs:
sso.costs = {}
sso.costs.goal = 0
sso.costs.empty = 0.1
sso.costs.block = 1000
sso.costs.water = 0.2
sso.costs.corner = 0
sso.costs.step = 0.1
sso.costs.pushableblock = 1000
---------------------
sso.crumb_action = 0
sso.push_action = 0
sso.flag_visited = 0
sso.enable_boundary = 0
sso.enable_corners = 0
sso.max_attributes = g_opts.max_attributes or 6

-------------------------------------------------------
-- MovingGoalss:
local MovingGoalsRangeOpts = {}
MovingGoalsRangeOpts.mapH = mapH:clone()
MovingGoalsRangeOpts.mapW = mapW:clone()
MovingGoalsRangeOpts.blockspct = blockspct:clone()
MovingGoalsRangeOpts.waterpct = waterpct:clone()

local MovingGoalsStaticOpts = {}
for i,j in pairs(sso) do MovingGoalsStaticOpts[i] = j end

MovingGoalsOpts ={}
MovingGoalsOpts.RangeOpts = MovingGoalsRangeOpts
MovingGoalsOpts.StaticOpts = MovingGoalsStaticOpts

g_opts.multigames.MovingGoals = MovingGoalsOpts


return g_opts
