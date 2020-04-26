function decision = monedaAlAire(opciones)

%% SELECCIÓN DE OPCIÓN AL AZAR
control = true;
while control
    decision = randi(4);
    if opciones(decision) == 1
        control = false;
    end
end