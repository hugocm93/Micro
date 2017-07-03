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
    page = page .. html.booleanState("Esquerdo","esquerdo","UP","DOWN");
    page = page .. html.booleanState("Meio","meio","UP","DOWN");
    page = page .. html.booleanState("Direito","direito","UP","DOWN");
    page = page .. html.booleanState("Garra","garra","abrir","fechar");
    page = page .. html.select("Comando:", {"Movimento1"}, "opts");
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
             end,

direito = function(value)
    if(value == 0) then
        uart.write(0, ":p1;end")
    else 
        uart.write(0, ":p4;end")
    end
end,

meio = function(value)
    if(value == 0) then
        uart.write(0, ":p0;end")
    else 
        uart.write(0, ":p3;end")
    end
end,

esquerdo = function(value)
    if(value == 0) then
        uart.write(0, ":p2;end")
    else 
        uart.write(0, ":p5;end")
    end
end,

garra = function(value)
    if(value == 0) then
        uart.write(0, ":g0;end")
    else 
        uart.write(0, ":g1;end")
    end
end,

opts = function(value)
    if(value == 1) then
        uart.write(0, ":p5;:g1;:p2;:g0;:p5;:p4;:p1;:g1;:p4;:p3;:p0;:g0;:p3;:p5;:p2;:g1;:p5;:p3;end")
    end
end

}

return user;

