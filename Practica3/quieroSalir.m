%% FUNCI�N PARA ENCONTRAR RUTA DE SALIDA (RECURSIVA)

function rutaSalida = quieroSalir(mapa,filas,columnas,auxY,auxX,inicioY,inicioX,ruta,nulos,i,j)

rutas = zeros(4); % INDICE: CASIILLA SUP / CASILLA DCHA / CASILLA INF / CASILLA IZQ
% Comprobamos rutas
r1j = 0;
r1i = 0;
if ((mapa(auxY+1,auxX) == 2) && (auxY+2 < filas))
    for z = 1:j
        if ~((nulos(1,z) == auxY+2) && (nulos(2,z) == auxX))
            r1j = 1;
        end
    end
    for z = 1:i
        if ~((ruta(1,z) == auxY+2) && (ruta(2,z) == auxX))
            r1i = 1;
        end
    end
    if(r1j && r1i)
        rutas(1) = 1;
    end
end
r2j = 0;
r2i = 0;
if ((mapa(auxY,auxX+1) == 2) && (auxX+2 < columnas))
    for z = 1:j
        if ~((nulos(1,z) == auxY) && (nulos(2,z) == auxX+2))
            r2j = 1;
        end
    end
    for z = 1:i
        if ~((ruta(1,z) == auxY) && (ruta(2,z) == auxX+2))
            r2i = 1;
        end
    end
    if(r2j && r2i)
        rutas(2) = 1;
    end
end
r3j = 0;
r3i = 0;
if ((mapa(auxY-1,auxX) == 2) && (auxY-2 > 0))
    for z = 1:j
        if ~((nulos(1,z) == auxY-2) && (nulos(2,z) == auxX))
            r3j = 1;
        end
    end
    for z = 1:i
        if ~((ruta(1,z) == auxY-2) && (ruta(2,z) == auxX))
            r3i = 1;
        end
    end
    if(r3j && r3i)
        rutas(3) = 1;
    end
end
r4j = 0;
r4i = 0;
if ((mapa(auxY,auxX-1) == 2) && (auxX-2 > 0))
    for z = 1:j
        if ~((nulos(1,z) == auxY) && (nulos(2,z) == auxX-2))
            r4j = 1;
        end
    end
    for z = 1:i
        if ~((ruta(1,z) == auxY) && (ruta(2,z) == auxX-2))
            r4i = 1;
        end
    end
    if(r4j && r4i)
        rutas(4) = 1;
    end
end
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
%SALIDA--------------------------------------------------------------------
disp([num2str(auxY),':',num2str(auxX)]);
%--------------------------------------------------------------------------
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
% SALIDA-------------------------------------------------------------------
disp (['BUSCANDO... i:',num2str(i),' j:',num2str(j)]);
disp([num2str(auxY),':',num2str(auxX)]);
disp([num2str(rutas(1)),'-',num2str(rutas(2)),'-',num2str(rutas(3)),'-',num2str(rutas(4))]);

%--------------------------------------------------------------------------
% Comprobamos si hemos acabado ruta
%if((inicioY == auxY) && (inicioX == auxX))
if(i > 30) 
    rutaSalida = ruta;
% En caso contrario continuamos buscando
else
    rutaSalida = quieroSalir(mapa,filas,columnas,auxY,auxX,inicioY,inicioX,ruta,nulos,i,j);
end