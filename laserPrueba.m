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
    
    a=1;
    dist = laser_1.LatestMessage.Ranges;
    angulo = laser_1.LatestMessage.AngleMin;
    while(a<rayos)
        
            X = cos(angulo)*dist(a);
            Y = sin(angulo)*dist(a);
        if(X<2) && (X>-2) 
            if(Y<2)&&(Y>-2)
                datosX(a)=X;
                datosY(a)=Y;
            end
        end
        angulo = angulo + 4*inc;
        a = a+4;
    end

figure
plot(datosX,datosY,'co','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Medidas del laser_1');   