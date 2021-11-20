box.cfg{}

local count = box.space.userlogs:count()

local medianSpeed = box.space.userlogs.index.speed:select({},{offset=math.floor(count/2), limit=1})[1].Speed

print('medianSpeed= ', medianSpeed)

local minTick = box.space.userlogs.index.ticktime:min().TickTime
local maxTick = box.space.userlogs.index.ticktime:max().TickTime

print('minTick= ', minTick)
print('maxTick= ', maxTick)