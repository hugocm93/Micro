local user = {}
user.ap={ssid="LCA-06",pwd="23456781",ip="192.168.3.1"}

local gbl={}

function user.setup()
    -- Coonfiguração UART/Serial
    --uart.setup(0, 57600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1);

end

function user.page(html)
    local page="";
    page = page .. html.time();
    page = page .. html.booleanState("UART","uartChange","PIC","USB");
    page = page .. html.inText("Comando:", "serialIn", 80)
    return page;
end

user.execCommand = {

-- Função chamada após cada comando select/options, sliders e setPin.
-- É executado antes de montar a página HTML
newRequest = function() 
             end,

serialIn = function(value)
            print("Value: " .. value);
            uart.write(0, value)
         end,

uartChange = function(value)
                -- Liga/Desliga a saída do print()
                if (value == 0) then printOn(); else printOff(); end
                -- Troca os pinos da UART USB <--> PinosAlternativos (D7,D8)
                uart.alt(value);
             end
}

return user;

