%% CONEXI�N
% CONECTAMOS CON LA MV
    setenv('ROS_MASTER_URI','http://192.168.1.40:11311');
    setenv('ROS_IP','192.168.1.36');
    rosinit() % Inicializaci�n de ROS en la IP correspondiente

%% INICIALIZACI�N DE SUSBSCRIBERS Y PUBLISHERS
% DECLARACI�N DE SUBSCRIBERS
    odom = rossubscriber('/robot0/odom');       % Subscripci�n a la odometr�a
    laser = rossubscriber('/robot0/laser_1');   % Subscripci�n al l�ser
    s0=rossubscriber('/robot0/sonar_0');        % Subcsripci�n al sonar_0
    s1=rossubscriber('/robot0/sonar_1');        % Subcsripci�n al sonar_1
    s2=rossubscriber('/robot0/sonar_2');        % Subcsripci�n al sonar_2
    s3=rossubscriber('/robot0/sonar_3');        % Subcsripci�n al sonar_3
    s4=rossubscriber('/robot0/sonar_4');        % Subcsripci�n al sonar_4
    s5=rossubscriber('/robot0/sonar_5');        % Subcsripci�n al sonar_5
    s6=rossubscriber('/robot0/sonar_6');        % Subcsripci�n al sonar_6
    s7=rossubscriber('/robot0/sonar_7');        % Subcsripci�n al sonar_7
% DECLARACI�N DE PUBLISHERS
    pub = rospublisher('/robot0/cmd_vel', 'geometry_msgs/Twist'); % Publisher para comunicar velocidad
    msg_vel = rosmessage(pub); % Creamos un mensaje del tipo declarado en "pub" (geometry_msgs/Twist)
% COMPROBACI�N DE INICIALIZACI�N COMPLETADA
    pause(2);
    % Comprobaci�n odometr�a
    while (strcmp(odom.LatestMessage.ChildFrameId,'robot0')~=1)
        odom.LatestMessage
    end
    % Comprobaci�n l�ser
    while (strcmp(laser_1.LatestMessage.Header.FrameId,'robot0_laser_1')~=1)
        laser.LatestMessage
    end
    % Comprobaci�n sonares
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
mapa = zeros(5,13); % 0 casilla no visitada / 1 si 
%% VARIABLES FIJAS
avance = 2; % Distancia que recorrera el robot en cada iteraci�n
velocidad_angular = 0.3;
velocidad_lineal = 0.3;
%% BUCLE
while(1)
    % INFORMACI�N ACTUAL
        pos = odom.LatestMessage.Pose.Pose.Position;
        rot = odom.LatestMessage.Pose.Pose.Orientation;
    % ANALISIS CASILLA
    
    % TOMA DE DECISI�N DE RUTA A SEGUIR
    
    % MOVEMOS EL ROBOT
        % Giro para encauzar al robot a la ruta a seguir
            giro(velocidad_angular, angulo);
        % Cuando el robot esta orientado hac�a el nuevo rumbo, avanzamos
            avanza(velocidad_lineal, avance); 
end