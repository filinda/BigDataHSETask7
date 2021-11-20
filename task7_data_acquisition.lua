box.cfg{}

userlogs = box.schema.create_space(
  'userlogs',
  {
    format = {
      {name = "Day", type = 'number'},
      {name = "TickTime", type = 'number'},
      {name = "Speed", type = 'number'}
    }, if_not_exists = true
  }
)

userlogs:create_index('primary',{
  parts = {'Day','TickTime','Speed'}
})
userlogs:create_index('ticktime',{
  parts = {'TickTime'},
  unique=false,
  type='TREE'
})
userlogs:create_index('speed',{
  parts = {'Speed'},
  unique=false,
  type='TREE'
})

-- Load Tarantool mqtt
local mqtt = require('mqtt')
local json = require('json')

-- Create instance
connection = mqtt.new()

connection:login_set('Hans', 'Test')

-- Connect to the server
connection:connect({host='194.67.112.161', port=1883})

-- Set callback for recv new messages
connection:on_message(function (message_id, topic, payload, gos, retain)
  local newdata = json.decode(payload)
  userlogs:insert({newdata.Day, newdata.TickTime, newdata.Speed})
end)

-- Subscribe to a system topic
connection:subscribe('v14')