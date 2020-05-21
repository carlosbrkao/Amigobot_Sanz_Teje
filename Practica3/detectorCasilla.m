%% FUNCI�N PARA LA DETECCI�N DEL TIPO DE CASILLA EN LA QUE NOS ENCONTRAMOS
function casilla = detectorCasilla(laser)

% DATOS DE CONTROL
    rayos = 400; % cantidad de rayos del laser
% GENERACION DE DATOS Y ESTRUCTURAS NECESARIAS
    format long 
    inc = laser.LatestMessage.AngleIncrement; %Incremento del angulo en cada rayo
    dist = laser.LatestMessage.Ranges;        %Array de distancias
    angulo_min = laser.LatestMessage.AngleMin;%Angulo minimo en rad

    cuarto = rayos/4;
% DETECTORES DE PARED
    p1 = laser_p1(angulo_min,inc,cuarto,dist);
    p2 = laser_p2(angulo_min,inc,cuarto,dist);
    p3 = laser_p3(angulo_min,inc,cuarto,dist);
    p4 = laser_p4(angulo_min,inc,cuarto,dist);    
% DECODIFICADOR
    if(~p1)&&(~p2)&&(~p3)&&(~p4) 
        casilla = 0;
    elseif(~p1)&&(p2)&&(~p3)&&(~p4) 
        casilla = 1;
    elseif(~p1)&&(~p2)&&(p3)&&(~p4) 
        casilla = 2;
    elseif(~p1)&&(~p2)&&(~p3)&&(p4) 
        casilla = 3;
    elseif(p1)&&(~p2)&&(~p3)&&(~p4) 
        casilla = 4;
    elseif(~p1)&&(p2)&&(p3)&&(~p4) 
        casilla = 5;
    elseif(~p1)&&(p2)&&(~p3)&&(p4) 
        casilla = 6;
    elseif(p1)&&(p2)&&(~p3)&&(~p4) 
        casilla = 7;
    elseif(~p1)&&(~p2)&&(p3)&&(p4) 
        casilla = 8;
    elseif(p1)&&(~p2)&&(p3)&&(~p4) 
        casilla = 9;
    elseif(p1)&&(~p2)&&(~p3)&&(p4) 
        casilla = 10;
    elseif(~p1)&&(p2)&&(p3)&&(p4) 
        casilla = 11;
    elseif(p1)&&(~p2)&&(p3)&&(p4) 
        casilla = 12;
    elseif(p1)&&(p2)&&(~p3)&&(p4) 
        casilla = 13;
    elseif(p1)&&(p2)&&(p3)&&(~p4) 
        casilla = 14;
    elseif(p1)&&(p2)&&(p3)&&(p4) 
        casilla = 15;
    end