timer = tmr.create()
f = function () print("Hello World!") end

timer:register(1000, tmr.ALARM_AUTO, f)
timer:start()
