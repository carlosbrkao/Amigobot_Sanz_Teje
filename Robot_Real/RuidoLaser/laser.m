%%Radianes
cantidad = 1000;
datosX = zeros(1,1000);
datosY = zeros(1,1000);
%% DECLARACIÓN DE SUBSCRIBERS
laser_1=rossubscriber('/laser_1');  %% Suscriber al laser

%% MENSAJES DEL ROBOT PARA LASER
pause(1);
while (strcmp(laser_1.LatestMessage.Header.FrameId,'robot0_laser_1')~=1)
laser_1.LatestMessage
end

s0_Orientacion = laser_1.LatestMessage.AngleMin;

i=1;
r = robotics.Rate(10);
while(i<cantidad+1)
    dist = laser_1.LatestMessage.Ranges(1);
    X = cos(s0_Orientacion)*dist;
    Y = sin(s0_Orientacion)*dist;
    
    datosX(i)=X;
    datosY(i)=Y;
    i=i+1;
    
    waitfor(r);
end
figure
plot(datosX,datosY,'-o','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Medidas del laser(1000 medidad)');   
    
    
    
    
    
    
    
    
    
    
    
    