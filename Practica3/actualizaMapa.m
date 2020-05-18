%% MÉTODO PARA LA ACTUALIZACIÓN DEL MAPA
function mapa = actualizaMapa(mapa,casilla,pos,filas,columnas,angulo)

% Obtenemos las coordenadas de la casilla actual
casillaX = round(pos.X) + 1;
casillaY = round(pos.Y) + 1;
% Marcamos como mapeada la casilla
mapa(casillaY,casillaX) = 1;
% Actualización de paredes
aux_paredes = [2,2,2,2]; % pared frente robot / pared dcha robot / pared atrás robot / pared izq robot
    % Frente robot
    if (casilla ==  1 || casilla == 5 || casilla == 6 || casilla == 7 || casilla == 11 || casilla == 13 || casilla == 14)
        aux_paredes(1) = 3;
    end
    % Derecha robot
    if (casilla == 2 || casilla == 5 || casilla == 8 || casilla == 9 || casilla == 11 || casilla == 12 || casilla == 14)
        aux_paredes(2) = 3;
    end
    % Atrás robot
    if (casilla == 3 || casilla == 6 || casilla == 8 || casilla == 10 || casilla == 11 || casilla == 12 || casilla == 13)
        aux_paredes(3) = 3;
    end
    % Izquierda robot
    if (casilla == 4 || casilla == 7 || casilla == 9 || casilla == 10 || casilla == 12 || casilla == 13 || casilla == 14)
        aux_paredes(4) = 3;
    end
if(angulo == 0)
    % Casilla arriba
    mapa(casillaY,casillaX+1) = aux_paredes(1);
    % Casilla derecha
    mapa(casillaY+1,casillaX) = aux_paredes(4);
    % Casilla abajo
    mapa(casillaY,casillaX-1) = aux_paredes(3);
    % Casilla izquierda
    mapa(casillaY-1,casillaX) = aux_paredes(2);
end
if(angulo == 90)
    % Casilla arriba
    mapa(casillaY,casillaX+1) = aux_paredes(2);
    % Casilla derecha
    mapa(casillaY+1,casillaX) = aux_paredes(1);
    % Casilla abajo
    mapa(casillaY,casillaX-1) = aux_paredes(4);
    % Casilla izquierda
    mapa(casillaY-1,casillaX) = aux_paredes(3);
end
if(angulo == 180)
    % Casilla arriba
    mapa(casillaY,casillaX+1) = aux_paredes(3);
    % Casilla derecha
    mapa(casillaY+1,casillaX) = aux_paredes(2);
    % Casilla abajo
    mapa(casillaY,casillaX-1) = aux_paredes(1);
    % Casilla izquierda
    mapa(casillaY-1,casillaX) = aux_paredes(4);
end
if(angulo == -90)
    % Casilla arriba
    mapa(casillaY,casillaX+1) = aux_paredes(4);
    % Casilla derecha
    mapa(casillaY+1,casillaX) = aux_paredes(3);
    % Casilla abajo
    mapa(casillaY,casillaX-1) = aux_paredes(2);
    % Casilla izquierda
    mapa(casillaY-1,casillaX) = aux_paredes(1);
end
% PRUEBAS---------------------------------------------------------------------
%     imprimeMapa(mapa,filas,columnas);
%     disp('-------------------------');
%-----------------------------------------------------------------------------
% Representación del mapa
    % Conversor
    lista = zeros(filas+1,columnas+1);
    conversorFilas = zeros(filas+1);
    j = 1;
    for i = filas+1:-1:1
        conversorFilas(j) = i;
        j = j + 1;
    end
    for i = 1:columnas+1
        for j = 1:filas+1
            lista(conversorFilas(j),i) = mapa(j,i);
        end
    end
    % Pantalla
    imprimeMapa(lista,filas,columnas);