ledPin = 1
gpio.mode(ledPin, gpio.OUTPUT)

while true do
    gpio.write(ledPin, gpio.LOW)
    tmr.delay(1000*1000)
    gpio.write(ledPin, gpio.HIGH)
    tmr.delay(1000*1000)
end
