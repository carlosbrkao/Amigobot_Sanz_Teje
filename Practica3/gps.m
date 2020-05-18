function rutas = gps(mapa,pos,filas,columnas,angulo)

%% A PARTIR DEL TIPO DE CASILLAS INTERPRETAMOS LOS CAMINOS POSIBLES
%   [RECTO / DERECHA / ATRAS / IZQUIERDA]
rutas = zeros(2,4);
% Obtenemos las coordenadas de la casilla actual
casillaX = round(pos.X) + 1;
casillaY = round(pos.Y) + 1;
% Estudio del mapa
if(angulo == 0)%-----------------------------------------------------------
    % Recto libre
    if(mapa(casillaY,casillaX+1)== 2) 
        rutas(1,1) = 1;%Recto
    end
    if(casillaX < columnas)
        if(mapa(casillaY,casillaX+2)== 0) 
            rutas(2,1) = 1;%Recto
        end
    else
        rutas(2,1) = 2;
    end
    % Izquierda libre
    if(mapa(casillaY+1,casillaX)== 2) 
        rutas(1,4) = 1;%Izq
    end
    if(casillaY < filas)
        if(mapa(casillaY+2,casillaX)== 0) 
            rutas(2,4) = 1;%Izq
        end
    else
        rutas(2,4) = 2;
    end
    % Atras libre
    if(mapa(casillaY,casillaX-1)== 2) 
        rutas(1,3) = 1;%Atras
    end
    if(casillaX > 2)
        if(mapa(casillaY,casillaX-2)== 0) 
            rutas(2,3) = 1;%Atras
        end
    else
        rutas(2,3) = 2;
    end
    % Derecha libre
    if(mapa(casillaY-1,casillaX)== 2) 
        rutas(1,2) = 1;%Dcha
    end
    if(casillaY > 2)
        if(mapa(casillaY-2,casillaX)== 0) 
            rutas(2,2) = 1;%Dcha
        end
    else
        rutas(2,2) = 2;
    end
end
if(angulo == 90)%---------------------------------------------------------
    % Derecha libre
    if(mapa(casillaY,casillaX+1)== 2) 
        rutas(1,2) = 1;%Dcha
    end
    if(casillaX < columnas)
        if(mapa(casillaY,casillaX+2)== 0) 
            rutas(2,2) = 1;%Dcha
        end
    else
        rutas(2,2) = 2;
    end
    % Recto libre
    if(mapa(casillaY+1,casillaX)== 2) 
        rutas(1,1) = 1;%Recto
    end
    if(casillaY < filas)
        if(mapa(casillaY+2,casillaX)== 0) 
            rutas(2,1) = 1;%Recto
        end
    else
        rutas(2,1) = 2;
    end
    % Izquierda libre
    if(mapa(casillaY,casillaX-1)== 2)
        rutas(1,4) = 1;%Izq
    end
    if(casillaX > 2)
        if(mapa(casillaY,casillaX-2)== 0)
            rutas(2,4) = 1;%Izq
        end
    else
        rutas(2,4) = 2;
    end
    % Atras libre
    if(mapa(casillaY-1,casillaX)== 2) 
        rutas(1,3) = 1;%Atras
    end
    if(casillaY > 2)
        if(mapa(casillaY-2,casillaX)== 0) 
            rutas(2,3) = 1;%Atras
        end
    else
        rutas(2,3) = 2;
    end
end
if(angulo == 180)%---------------------------------------------------------
    % Atras libre
    if(mapa(casillaY,casillaX+1)== 2) 
        rutas(1,3) = 1;%Atras
    end
    if(casillaX < columnas)
        if(mapa(casillaY,casillaX+2)== 0) 
            rutas(2,3) = 1;%Atras
        end
    else
        rutas(2,3) = 2;
    end
    % Derecha libre
    if(mapa(casillaY+1,casillaX)== 2) 
        rutas(1,2) = 1;%Dcha
    end
    if(casillaY < filas)
        if(mapa(casillaY+2,casillaX)== 0) 
            rutas(2,2) = 1;%Dcha
        end
    else
        rutas(2,2) = 2;
    end
    % Recto libre
    if(mapa(casillaY,casillaX-1)== 2) 
        rutas(1,1) = 1;%Recto
    end
    if(casillaX > 2)
        if(mapa(casillaY,casillaX-2)== 0) 
            rutas(2,1) = 1;%Recto
        end
    else
        rutas(2,1) = 2;
    end
    % Izquierda libre
    if(mapa(casillaY-1,casillaX)== 2) 
        rutas(1,4) = 1;%Izq
    end
    if(casillaY > 2)
        if(mapa(casillaY-2,casillaX)== 0) 
            rutas(2,4) = 1;%Izq
        end
    else
        rutas(2,4) = 2;
    end
end
if(angulo == -90)%---------------------------------------------------------
    % Izquierda libre
    if(mapa(casillaY,casillaX+1)== 2)
        rutas(1,4) = 1;%Izq
    end
    if(casillaX < columnas)
        if(mapa(casillaY,casillaX+2)== 0)
            rutas(2,4) = 1;%Izq
        end
    else
        rutas(2,4) = 2;
    end
    % Atrás libre
    if(mapa(casillaY+1,casillaX)== 2)
        rutas(1,3) = 1;%Atras
    end
    if(casillaY < filas)
        if(mapa(casillaY+2,casillaX)== 0)
            rutas(2,3) = 1;%Atras
        end
    else
        rutas(2,3) = 2;
    end
    % Derecha libre
    if(mapa(casillaY,casillaX-1)== 2) 
        rutas(1,2) = 1;%Dcha
    end
    if(casillaX > 2)
        if(mapa(casillaY,casillaX-2)== 0) 
            rutas(2,2) = 1;%Dcha
        end
    else
        rutas(2,2) = 2;
    end
    % Recto libre
    if(mapa(casillaY-1,casillaX)== 2) 
        rutas(1,1) = 1;%Recto
    end
    if(casillaY > 2)
        if(mapa(casillaY-2,casillaX)== 0) 
            rutas(2,1) = 1;%Recto
        end
    else
        rutas(2,1) = 2;
    end
end
disp('---------RUTAS--------');
disp([num2str(rutas(1,1)),'-',num2str(rutas(1,2)),'-',num2str(rutas(1,3)),'-',num2str(rutas(1,4))]);
disp([num2str(rutas(2,1)),'-',num2str(rutas(2,2)),'-',num2str(rutas(2,3)),'-',num2str(rutas(2,4))]);
disp('----------------------');