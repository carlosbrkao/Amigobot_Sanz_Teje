%% FUNCIÓN QUE COMPRUEBA SI ESTAMOS EN LA CASILLA DE SALIDA

function salida = luzAlFinalDelTunel(opciones)

% INDICE: CAMINO NULO = 0 / CAMINO POSIBLE = 1 / POSIBLE SALIDA = 2

salida = false;
for i = 1:4
    if((opciones(2,i) == 2)&& (opciones(1,i) == 1))
        salida = true;
    end
end