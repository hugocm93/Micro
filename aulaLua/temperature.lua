dataPin = 2

timer = tmr.create()
f = function () 
    status, temp, humi, temp_dec, humi_dec = dht.read(dataPin)
    print("Temp: " .. temp) 
    print("Humi: " .. humi) 
end

timer:register(1000, tmr.ALARM_AUTO, f)
timer:start()
