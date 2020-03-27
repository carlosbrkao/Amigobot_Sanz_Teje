%% Datos iniciales
cantidad = 1000; %Cantidad de medidas a tomar
%Arrays para guardar los datos medidos y poder hacer la grafica
datosX = zeros(1,1000);
datosY = zeros(1,1000);

%% DECLARACIÓN DE SUBSCRIBERS
laser_1=rossubscriber('/scan');  %% Suscriber al laser

%% MENSAJES DEL ROBOT PARA LASER(Nos aseguramos de recibir el mensasje)
pause(1);
while (strcmp(laser_1.LatestMessage.Header.FrameId,'laser_frame')~=1)
laser_1.LatestMessage
end

%% ORIENTACION DEL LASER(En este caso tomamos el minimo angulo)
s0_Orientacion = laser_1.LatestMessage.AngleMin;

%% BUCLE PARA TOMAR LOS DATOS
i=1;
r = robotics.Rate(10); %Periodicidad del bucle
while(i<cantidad+1)
    dist = laser_1.LatestMessage.Ranges(1); % Tomamos la distancia medida
    
    % Caculamos las componbentes X e Y de la medida
    X = cos(s0_Orientacion)*dist;
    Y = sin(s0_Orientacion)*dist;
    %disp(i);
    
    %Guardamos las medidas
    datosX(i)=X;
    datosY(i)=Y;
    i=i+1;
    
    waitfor(r);
end
%Generamos el grafico correspondiente
figure
plot(datosX,datosY,'-o','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Medidas del laser(1000 medidad)');   
    
    
    
    
    
    
    
    
    
    
    
    