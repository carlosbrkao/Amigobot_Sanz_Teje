%% CONEXIÓN
% CONECTAMOS CON LA MV
    setenv('ROS_MASTER_URI','http://192.168.1.40:11311');
    setenv('ROS_IP','192.168.1.36');
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
    while (strcmp(laser_1.LatestMessage.Header.FrameId,'robot0_laser_1')~=1)
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
mapa = zeros(5,13); % 0 casilla no visitada / 1 si 
%% VARIABLES FIJAS
avance = 2; % Distancia que recorrera el robot en cada iteración
velocidad_angular = 0.3;
velocidad_lineal = 0.3;
%% BUCLE
while(1)
    % INFORMACIÓN ACTUAL
        pos = odom.LatestMessage.Pose.Pose.Position;
        rot = odom.LatestMessage.Pose.Pose.Orientation;
    % ANALISIS CASILLA
    
    % TOMA DE DECISIÓN DE RUTA A SEGUIR
    
    % MOVEMOS EL ROBOT
        % Giro para encauzar al robot a la ruta a seguir
            giro(velocidad_angular, angulo);
        % Cuando el robot esta orientado hacía el nuevo rumbo, avanzamos
            avanza(velocidad_lineal, avance); 
end