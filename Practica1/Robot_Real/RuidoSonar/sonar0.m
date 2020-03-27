%% Datos iniciales
cantidad = 1000; %Cantidad de medidas a tomar
%Arrays para guardar los datos medidos y poder hacer la grafica
datosX = zeros(1,1000);
datosY = zeros(1,1000);
%% DECLARACI�N DE SUBSCRIBERS
sonar_0=rossubscriber('/sonar_0');  %%Subcribimos a la odometria

%% Nos aseguramos recibir un mensaje relacionado con el robot "robot0"
pause(1);
while (strcmp(sonar_0.LatestMessage.Header.FrameId,'/sonar_0')~=1)
sonar_0.LatestMessage
end

%% ORIENTACION DEL SONAR
s0_Orientacion = 1.5708;

%% BUCLE PARA TOMAR LOS DATOS
i=1;
r = robotics.Rate(10);%Periodicidad del bucle
while(i<cantidad+1)
    dist = sonar_0.LatestMessage.Range_;% Tomamos la distancia medida
    
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
title('Medidas del sonar_0(1000 medidad)');   
    
    
    
    
    
    
    
    
    
    
    
    