%% DECLARACIÓN DE SUBSCRIBERS
laser_1=rossubscriber('/scan');  %% Suscriber al laser

%% MENSAJES DEL ROBOT PARA LASER
pause(2);
while (strcmp(laser_1.LatestMessage.Header.FrameId,'laser_frame')~=1)
laser_1.LatestMessage
end

%% DATOS DE CONTROL
rayos = 360; % cantidad de rayos del laser


%% GENERACION DE DATOS Y ESTRUCTURAS NECESARIAS
datosX = zeros(1,rayos);
datosY = zeros(1,rayos);

format long 
inc = laser_1.LatestMessage.AngleIncrement; %Incremento del angulo en cada rayo
dist = laser_1.LatestMessage.Ranges;        %Array de distancias
angulo_min = laser_1.LatestMessage.AngleMin;%Angulo minimo en rad

cuarto = rayos/4;

%% DETECTORES DE PARED
p1 = laser_p1(angulo_min,inc,cuarto,dist);
p2 = laser_p2(angulo_min,inc,cuarto,dist);
p3 = laser_p3(angulo_min,inc,cuarto,dist);
p4 = laser_p4(angulo_min,inc,cuarto,dist);

%% TIPO DE CASILLA
disp("TIPO DE CASILLA = " + tipo_Casilla(p1,p2,p3,p4));