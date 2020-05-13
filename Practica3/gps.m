function rutas = gps(mapa,pos,rotacion,filas,columnas)

%% A PARTIR DEL TIPO DE CASILLAS INTERPRETAMOS LOS CAMINOS POSIBLES
%   [RECTO / DERECHA / ATRAS / IZQUIERDA]
rutas = zeros(2,4);
% Obtenemos las coordenadas de la casilla actual
casillaX = round(pos.X) + 1;
casillaY = round(pos.Y) + 1;
% Conversi�n de radianes a grados
angulos = [0,90,180,-90];
angulo = round((rotacion * 180)/pi);
for i = 1:4
    if(i == 3)
       if((abs(angulo) - angulos(i))<5 && (abs(angulo) - angulos(i)>-5))  
           angulo = angulos(i);
           i = 4; 
       end     
    else
       if((angulo - angulos(i))<5 && (angulo - angulos(i)>-5))  
           angulo = angulos(i);
           i = 4; 
       end
    end
end
disp(['ANGULO: ',num2str(angulo)]);
% Estudio del mapa
if(angulo == 0)
    % Recto libre
    if(mapa(casillaY,casillaX+1)== 2) 
        rutas(1,1) = 1;%Recto
    end
    if(casillaX < columnas)
        if(mapa(casillaY,casillaX+2)== 0) 
            rutas(2,1) = 1;%Recto
        end
    end
    % Izquierda libre
    if(mapa(casillaY+1,casillaX)== 2) 
        rutas(1,4) = 1;%Izq
    end
    if(casillaY < filas)
        if(mapa(casillaY+2,casillaX)== 0) 
            rutas(2,4) = 1;%Izq
        end
    end
    % Atras libre
    if(mapa(casillaY,casillaX-1)== 2) 
        rutas(1,3) = 1;%Atras
    end
    if(casillaX > 2)
        if(mapa(casillaY,casillaX-2)== 0) 
            rutas(2,3) = 1;%Atras
        end
    end
    % Derecha libre
    if(mapa(casillaY-1,casillaX)== 2) 
        rutas(1,2) = 1;%Dcha
    end
    if(casillaY > 2)
        if(mapa(casillaY-2,casillaX)== 0) 
            rutas(2,2) = 1;%Dcha
        end
    end
end
if(angulo == 90)
    % Derecha libre
    if(mapa(casillaY,casillaX+1)== 2) 
        rutas(1,2) = 1;%Dcha
    end
    if(casillaX < columnas)
        if(mapa(casillaY,casillaX+2)== 0) 
            rutas(2,2) = 1;%Dcha
        end
    end
    % Recto libre
    if(mapa(casillaY+1,casillaX)== 2) 
        rutas(1,1) = 1;%Recto
    end
    if(casillaY < filas)
        if(mapa(casillaY+2,casillaX)== 0) 
            rutas(2,1) = 1;%Recto
        end
    end
    % Izquierda libre
    if(mapa(casillaY,casillaX-1)== 2)
        rutas(1,4) = 1;%Izq
    end
    if(casillaX > 2)
        if(mapa(casillaY,casillaX-2)== 0)
            rutas(2,4) = 1;%Izq
        end
    end
    % Atras libre
    if(mapa(casillaY-1,casillaX)== 2) 
        rutas(1,3) = 1;%Atras
    end
    if(casillaY > 2)
        if(mapa(casillaY-2,casillaX)== 0) 
            rutas(2,3) = 1;%Atras
        end
    end
end
if(angulo == 180)
    % Atras libre
    if(mapa(casillaY,casillaX+1)== 2) 
        rutas(1,3) = 1;%Atras
    end
    if(casillaX < columnas)
        if(mapa(casillaY,casillaX+2)== 0) 
            rutas(2,3) = 1;%Atras
        end
    end
    % Derecha libre
    if(mapa(casillaY+1,casillaX)== 2) 
        rutas(1,2) = 1;%Dcha
    end
    if(casillaY < filas)
        if(mapa(casillaY+2,casillaX)== 0) 
            rutas(2,2) = 1;%Dcha
        end
    end
    % Recto libre
    if(mapa(casillaY,casillaX-1)== 2) 
        rutas(1,1) = 1;%Recto
    end
    if(casillaX > 2)
        if(mapa(casillaY,casillaX-2)== 0) 
            rutas(2,1) = 1;%Recto
        end
    end
    % Izquierda libre
    if(mapa(casillaY-1,casillaX)== 2) 
        rutas(1,4) = 1;%Izq
    end
    if(casillaY > 2)
        if(mapa(casillaY-2,casillaX)== 0) 
            rutas(2,4) = 1;%Izq
        end
    end
end
if(angulo == -90)
    % Izquierda libre
    if(mapa(casillaY,casillaX+1)== 2)
        rutas(1,4) = 1;%Izq
    end
    if(casillaX < columnas)
        if(mapa(casillaY,casillaX+2)== 0)
            rutas(2,4) = 1;%Izq
        end
    end
    % Atr�s libre
    if(mapa(casillaY+1,casillaX)== 2)
        rutas(1,3) = 1;%Atras
    end
    if(casillaY < filas)
        if(mapa(casillaY+2,casillaX)== 0)
            rutas(2,3) = 1;%Atras
        end
    end
    % Derecha libre
    if(mapa(casillaY,casillaX-1)== 2) 
        rutas(1,2) = 1;%Dcha
    end
    if(casillaX > 2)
        if(mapa(casillaY,casillaX-2)== 0) 
            rutas(2,2) = 1;%Dcha
        end
    end
    % Recto libre
    if(mapa(casillaY-1,casillaX)== 2) 
        rutas(1,1) = 1;%Recto
    end
    if(casillaY > 2)
        if(mapa(casillaY-2,casillaX)== 0) 
            rutas(2,1) = 1;%Recto
        end
    end
end
disp('---------RUTAS--------');
disp([num2str(rutas(1,1)),'-',num2str(rutas(1,2)),'-',num2str(rutas(1,3)),'-',num2str(rutas(1,4))]);
disp([num2str(rutas(2,1)),'-',num2str(rutas(2,2)),'-',num2str(rutas(2,3)),'-',num2str(rutas(2,4))]);
disp('----------------------');