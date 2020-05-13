function decision = monedaAlAire(opciones)

%% SELECCI�N DE CAMINO
libre = false;
control = true;
for i = 1:4
    if((opciones(2,i) == 1)&& (opciones(1,i) == 1))
        libre = true;
        control = false;
    end
end
% Buscando camino hacia casilla sin visitar
while libre
    decision = randi(4);
    if((opciones(2,decision) == 1) && (opciones(1,decision) == 1))
        libre = false;
    end
end
% Buscando camino
while control
    decision = randi(4);
    if(opciones(1,decision) == 1)
        control = false;
    end
end