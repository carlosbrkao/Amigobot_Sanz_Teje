
 %%Radianes
cantidad = 1000;
datosX = zeros(1,1000);
datosY = zeros(1,1000);
%% DECLARACIÓN DE SUBSCRIBERS
sonar_0=rossubscriber('/sonar_0');  %%Subcribimos a la odometria

%% Nos aseguramos recibir un mensaje relacionado con el robot "robot0"
pause(1);
while (strcmp(sonar_0.LatestMessage.Header.FrameId,'/sonar_0')~=1)
sonar_0.LatestMessage
end

s0_Orientacion = 1.5708;

i=1;
r = robotics.Rate(10);
while(i<cantidad+1)
    dist = sonar_0.LatestMessage.Range_;
    X = cos(s0_Orientacion)*dist;
    Y = sin(s0_Orientacion)*dist;
    
    datosX(i)=X;
    datosY(i)=Y;
    disp(i);
    i=i+1;
    
    waitfor(r);
end
i = 1;
figure
plot(datosX,datosY,'-o','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Medidas del sonar_0(1000 medidad)');   
    
    
    
    
    
    
    
    
    
    
    
    