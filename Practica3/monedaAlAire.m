%% FUNCIÓN PARA SELECCIONAR LA RUTA A PODER SEGUIR

function decision = monedaAlAire(opciones)

% INDICE: CAMINO NULO = 0 / CAMINO POSIBLE = 1 / POSIBLE SALIDA = 2
         
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