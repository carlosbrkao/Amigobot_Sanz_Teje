function decision = monedaAlAire(opciones)

%% SELECCI�N DE OPCI�N AL AZAR
control = true;
while control
    decision = randi(4);
    if opciones(decision) == 1
        control = false;
    end
end