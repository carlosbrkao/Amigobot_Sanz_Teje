rayos = 400;
datosX = zeros(1,400);
datosY = zeros(1,400);
pos = 1;
%% DECLARACIÓN DE SUBSCRIBERS
laser_1=rossubscriber('/robot0/laser_1');  %%Subcribimos a la odometria
odom=rossubscriber('/robot0/odom');  %%Subcribimos a la odometria


%% Nos aseguramos recibir un mensaje relacionado con el robot "robot0"
pause(1);
while (strcmp(laser_1.LatestMessage.Header.FrameId,'robot0_laser_1')~=1)
laser_1.LatestMessage
end
while (strcmp(odom.LatestMessage.ChildFrameId,'robot0')~=1)
odom.LatestMessage
end

format long 
inc = laser_1.LatestMessage.AngleIncrement;
    
    a=1;
    dist = laser_1.LatestMessage.Ranges;
    angulo_min = laser_1.LatestMessage.AngleMin;
    angulo = angulo_min;
    while(a<rayos)
        
            X = cos(angulo+orientacion(odom))*dist(a);
            Y = sin(angulo+orientacion(odom))*dist(a);
        if(X<2) && (X>-2) 
            if(Y<2)&&(Y>-2)
                datosX(a)=X;
                datosY(a)=Y;
            end
        end
        angulo = angulo + inc;
        a = a +1 ;
    end

figure
plot(datosX,datosY,'co','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Medidas del laser_1');   
cuarto = 400/4;
p1 = laser_p1(angulo_min,inc,cuarto,dist);
p2 = laser_p2(angulo_min,inc,cuarto,dist);
p3 = laser_p3(angulo_min,inc,cuarto,dist);
p4 = laser_p4(angulo_min,inc,cuarto,dist);
disp(p1);
disp(p2);
disp(p3);
disp(p4);
disp("TIPO DE CASILLA = " + tipo_Casilla(p1,p2,p3,p4));