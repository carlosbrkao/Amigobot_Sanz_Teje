%% FUNCIÓN PARA ENCONTRAR RUTA DE SALIDA (RECURSIVA)

function rutaSalida = quieroSalir(mapa,filas,columnas,auxY,auxX,inicioY,inicioX,ruta,nulos,i,j)

rutas = zeros(4); % INDICE: CASIILLA SUP / CASILLA DCHA / CASILLA INF / CASILLA IZQ
% Comprobamos rutas
if ((mapa(auxY+1,auxX) == 2) && (auxY+2 < filas))
    for z = 1:j
        if ~((nulos(1,j) == auxY+2) && (nulos(2,j) == auxX))
            rutas(1) = 1;
        end
    end
end
if ((mapa(auxY,auxX+1) == 2) && (auxX+2 < columnas))
    for z = 1:j
        if ~((nulos(1,j) == auxY) && (nulos(2,j) == auxX+2))
            rutas(2) = 1;
        end
    end
end
if ((mapa(auxY-1,auxX) == 2) && (auxY-2 > 0))
    for z = 1:j
        if ~((nulos(1,j) == auxY-2) && (nulos(2,j) == auxX))
            rutas(3) = 1;
        end
    end
end
if ((mapa(auxY,auxX-1) == 2) && (auxX-2 > 0))
    for z = 1:j
        if ~((nulos(1,j) == auxY) && (nulos(2,j) == auxX-2))
            rutas(4) = 1;
        end
    end
end
% SALIDA-------------------------------------------------------------------
disp (['BUSCANDO... i:',num2str(i),' j:',num2str(j)]);
disp([num2str(rutas(1)),'-',num2str(rutas(2)),'-',num2str(rutas(3)),'-',num2str(rutas(4))]);
%--------------------------------------------------------------------------
% Elegimos ruta
decision = 0;
for z = 1:4
    if(rutas(z) == 1)
        control = true;
        while control
            decision = randi(4);
            if(rutas(decision) == 1)
                control = false;
            end
        end
        break;
    end
end
switch decision
    case 1
        auxY = auxY + 2;
        i = i + 1;
        ruta(1,i) = auxY;
        ruta(2,i) = auxX;
    case 2
        auxX = auxX + 2;
        i = i + 1;
        ruta(1,i) = auxY;
        ruta(2,i) = auxX;
    case 3
        auxY = auxY - 2;
        i = i + 1;
        ruta(1,i) = auxY;
        ruta(2,i) = auxX;
    case 4
        auxX = auxX - 2;
        i = i + 1;
        ruta(1,i) = auxY;
        ruta(2,i) = auxX;
    otherwise
        j = j + 1;
        nulos(1,j) = auxY;
        nulos(2,j) = auxX;
        i = i - 1;
        auxY = ruta(1,i);
        auxX = ruta(2,i);
end
% Comprobamos si hemos acabado ruta
if((inicioY == auxY) && (inicioX == auxX))
    rutaSalida = ruta;
% En caso contrario continuamos buscando
else
    rutaSalida = quieroSalir(mapa,filas,columnas,auxY,auxX,inicioY,inicioX,ruta,nulos,i,j);
end