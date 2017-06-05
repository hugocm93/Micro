local user = {}
user.ap={ssid="LCA-06",pwd="23456781",ip="192.168.3.1"}

local gbl= {ledPin = 3, timer = tmr.create()}

function user.setup()
    gpio.mode(gbl.ledPin, gpio.OUTPUT)
    gpio.write(gbl.ledPin, gpio.LOW);

    f = function () 
            if(gpio.read(3) == 1) then
                gpio.write(3, gpio.LOW) 
            elseif(gpio.read(3) == 0) then
                gpio.write(3, gpio.HIGH) 
            end
         end

    gbl.timer:register(1000, tmr.ALARM_AUTO, f)

    gbl.timer:start()

    -- Coonfiguração UART/Serial
    --uart.setup(0, 57600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1);

end

function user.page(html)
    local page="";
    page = page .. html.time();
    page = page .. html.booleanState("UART","uartChange","PIC","USB");
    page = page .. html.pin_wr("Led 1",gbl.ledPin, "ON", "OFF");
    page = page .. html.select("Acoes",{"Ação 1", "Ação 2", "Ação 3", "Ação 4"},"action");
    return page;
end

user.execCommand = {

-- Função chamada após cada comando select/options, sliders e setPin.
-- É executado antes de montar a página HTML
newRequest = function() end,

-- Função chamada para todos setPins
setPin = function(pin,value)
            print("setPin_"..pin .." = " .. value);
            gpio.write(pin,value);
         end,

-- Funções chamadas para cada controle configurado. Definir para cada "id" de controle
uartChange = function(value)
                -- Liga/Desliga a saída do print()
                if (value == 0) then printOn(); else printOff(); end
                -- Troca os pinos da UART USB <--> PinosAlternativos (D7,D8)
                uart.alt(value);
             end,

action = function(value)
            print("Action:", value);
            uart.write(0,"Teste Uart:",string.format("%d",value));

            if(value == 1) then
                gpio.write(3, gpio.LOW) 
                gbl.timer:stop()
            elseif(value == 2) then
                gbl.timer:start()
            end
         end,
}

return user;

