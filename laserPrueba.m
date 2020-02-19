rayos = 400;
datosX = zeros(1,400);
datosY = zeros(1,400);
pos = 1;

%% DECLARACIÓN DE SUBSCRIBERS
laser_1=rossubscriber('/robot0/laser_1');  %%Subcribimos a la odometria

%% Nos aseguramos recibir un mensaje relacionado con el robot "robot0"
pause(1);
while (strcmp(laser_1.LatestMessage.Header.FrameId,'robot0_laser_1')~=1)
laser_1.LatestMessage
end

format long 
inc = laser_1.LatestMessage.AngleIncrement;
disp(inc);
    
    a=1;
    dist = laser_1.LatestMessage.Ranges;
    angulo = laser_1.LatestMessage.AngleMin;
    while(a<rayos+1)
        X = cos(angulo)*dist(a);
        Y = sin(angulo)*dist(a);
        datosX(a)=X;
        datosY(a)=Y;
        angulo = angulo + inc;
        disp(angulo);
        a = a+1;
    end
    disp(datosX);
    disp(datosY);

figure
plot(datosX,datosY,'co','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Medidas del laser_1');   