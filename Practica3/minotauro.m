%% CONEXIÓN
% CONECTAMOS CON LA MV
    setenv('ROS_MASTER_URI','http://192.168.1.37:11311');
    setenv('ROS_IP','192.168.1.40');
    rosinit() % Inicialización de ROS en la IP correspondiente

%% INICIALIZACIÓN DE SUSBSCRIBERS Y PUBLISHERS
% DECLARACIÓN DE SUBSCRIBERS
    odom = rossubscriber('/robot0/odom');       % Subscripción a la odometría
    laser = rossubscriber('/robot0/laser_1');   % Subscripción al láser
    s0=rossubscriber('/robot0/sonar_0');        % Subcsripción al sonar_0
    s1=rossubscriber('/robot0/sonar_1');        % Subcsripción al sonar_1
    s2=rossubscriber('/robot0/sonar_2');        % Subcsripción al sonar_2
    s3=rossubscriber('/robot0/sonar_3');        % Subcsripción al sonar_3
    s4=rossubscriber('/robot0/sonar_4');        % Subcsripción al sonar_4
    s5=rossubscriber('/robot0/sonar_5');        % Subcsripción al sonar_5
    s6=rossubscriber('/robot0/sonar_6');        % Subcsripción al sonar_6
    s7=rossubscriber('/robot0/sonar_7');        % Subcsripción al sonar_7
% DECLARACIÓN DE PUBLISHERS
    pub = rospublisher('/robot0/cmd_vel', 'geometry_msgs/Twist'); % Publisher para comunicar velocidad
    msg_vel = rosmessage(pub); % Creamos un mensaje del tipo declarado en "pub" (geometry_msgs/Twist)
% COMPROBACIÓN DE INICIALIZACIÓN COMPLETADA
    pause(2);
    % Comprobación odometría
    while (strcmp(odom.LatestMessage.ChildFrameId,'robot0')~=1)
        odom.LatestMessage
    end
    % Comprobación láser
    while (strcmp(laser.LatestMessage.Header.FrameId,'robot0_laser_1')~=1)
        laser.LatestMessage
    end
    % Comprobación sonares
    while (strcmp(s0.LatestMessage.Header.FrameId,'robot0_sonar_0')~=1)
        s0.LatestMessage
    end
    while (strcmp(s1.LatestMessage.Header.FrameId,'robot0_sonar_1')~=1)
        s1.LatestMessage
    end
    while (strcmp(s2.LatestMessage.Header.FrameId,'robot0_sonar_2')~=1)
        s2.LatestMessage
    end
    while (strcmp(s3.LatestMessage.Header.FrameId,'robot0_sonar_3')~=1)
        s3.LatestMessage
    end
    while (strcmp(s4.LatestMessage.Header.FrameId,'robot0_sonar_4')~=1)
        s4.LatestMessage
    end
    while (strcmp(s5.LatestMessage.Header.FrameId,'robot0_sonar_5')~=1)
        s5.LatestMessage
    end
    while (strcmp(s6.LatestMessage.Header.FrameId,'robot0_sonar_6')~=1)
        s6.LatestMessage
    end
    while (strcmp(s7.LatestMessage.Header.FrameId,'robot0_sonar_7')~=1)
        s7.LatestMessage
    end
%% VARIABLES
% Mapa del tesoro
filas = 6; % En metros
columnas = 14; % En metros
mapa = zeros(filas + 1, columnas + 1); % 0 = no visitada // 1 = visitada // 2 = libre // 3 = pared
% Inicializamos todas las paredes como huecos
for i = 1:2:columnas + 1
    for j = 1:filas + 1
        mapa(j,i) = 2;
    end
end
for i = 1:2:filas + 1 
    for j = 1:columnas + 1
        mapa(i,j) = 2;
    end
end
%% VARIABLES FIJAS
avance = 2; % Distancia que recorrera el robot en cada iteración    
velocidad_angular = 0.1;    % Velocidad angular fija (no cambiar)
velocidad_lineal = 0.5;     % Velocidad lineal fija (no cambiar)
% Orientación inicial
%% BUCLE
while(1)
    % INFORMACIÓN ACTUAL
        pos = odom.LatestMessage.Pose.Pose.Position;
        disp (['X: ',num2str(pos.X),' Y: ',num2str(pos.Y)]);
        rot = odom.LatestMessage.Pose.Pose.Orientation;
        % Calculo de ángulo
        quaternion=[rot.W rot.X rot.Y rot.Z];
        euler=quat2eul(quaternion,'ZYX');
        rotacion=euler(1);
    % ANALISIS CASILLA
        casilla = detectorCasilla();
        disp(num2str(casilla));
        mapa = actualizaMapa(mapa,casilla,pos,rotacion,filas,columnas);
        posiblesRutas = gps(mapa,pos,rotacion,filas,columnas);
    % TOMA DE DECISIÓN DE RUTA A SEGUIR
        %%ruta = monedaAlAire(posiblesRutas);
        %%Al goritmo derecha.
        
        
        
%         disp(num2str(ruta));
%         %% Calculo de la rotación antes de comprobar datos de sensores
%             disp(['ORIENTACIÓN: ',num2str((rotacion * 180)/pi)]);
%         switch ruta
%             case 1
%                 angulo = 0;
% %                 angulo = ((180*rotacion)/pi) + 0;
%             case 2
%                 angulo = -90;
% %                 angulo = ((180*rotacion)/pi) - 90;
%             case 3
%                 angulo = 180;
% %                 angulo = ((180*rotacion)/pi) + 180;
%             case 4
%                 angulo = 90;
% %                 angulo = ((180*rotacion)/pi) + 90;
%         end

   %---------------------------------------------------------------------------------
    
   %%Comprobar giro
%     format long 
%     inc = laser.LatestMessage.AngleIncrement; %Incremento del angulo en cada rayo
%     dist = laser.LatestMessage.Ranges;        %Array de distancias
%     angulo_min = laser.LatestMessage.AngleMin;%Angulo minimo en rad
% 
%     cuarto = 400/4;
%     %% DETECTOR DE PARED
%     p3 = laser_p3(angulo_min,inc,cuarto,dist);
%     p2 = laser_p2(angulo_min,inc,cuarto,dist);
%     p1 = laser_p1(angulo_min,inc,cuarto,dist);
%     p4 = laser_p4(angulo_min,inc,cuarto,dist);
%    if(~p3)
%        giro(velocidad_angular, -90);
%    else
%        if(p2)
%             if(p1)
%                 giro(velocidad_angular, 180);
%             else
%                 giro(velocidad_angular, 90);
%             end
%        
%        else
%            if(~p1)&&(~p2)&&(~p3)&&(~p4)
%                 disp("SALIDA");
%                 giro(velocidad_angular, 180);
%            end
%        end
%    end      
    
    cuarto = 100;
    format long 
    inc = laser.LatestMessage.AngleIncrement; %Incremento del angulo en cada rayo
    dist = laser.LatestMessage.Ranges;        %Array de distancias
    angulo_min = laser.LatestMessage.AngleMin;%Angulo minimo en rad

    p1 = laser_p1(angulo_min,inc,cuarto,dist);
    p2 = laser_p2(angulo_min,inc,cuarto,dist);
    p3 = laser_p3(angulo_min,inc,cuarto,dist); 
    
    disp(p1);
    disp(p2);
    disp(p3);
%% DECODIFICADOR
    if(pos.X>14)
        disp("SALIDA")
        giro(velocidad_angular, 180);
    elseif(~p1)&&(p2)&&(p3)
        giro(velocidad_angular, 90);
    elseif(p1)&&(p2)&&(p3)
        giro(velocidad_angular, 180);
    elseif(~p1)&&(p3) 
       
    elseif(~p3)
         giro(velocidad_angular, -90);
   
    end

        
   avanza(velocidad_lineal, avance);
    %--------------------------------------------------------------------------------

%     % MOVEMOS EL ROBOT
%         % Giro para encauzar al robot a la ruta a seguir
%             giro(velocidad_angular, angulo);
%         % Cuando el robot esta orientado hacía el nuevo rumbo, avanzamos
%             
end

%% DESCONECTAMOS
rosshutdown;