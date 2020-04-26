%% INICIALIZACIÓN DE ROS (COMPLETAR ESPACIOS CON LAS DIRECCIONES IP)
setenv('ROS_MASTER_URI','http://192.168.1.35:11311');
setenv('ROS_IP','192.168.1.43');
rosinit() % Inicialización de ROS en la IP correspondiente


%% DECLARACIÓN DE VARIABLES NECESARIAS PARA EL CONTROL
xDestino = 3;
yDestino = 10;

%% DECLARACIÓN DE SUBSCRIBERS
odom = rossubscriber('/robot0/odom'); % Subscripción a la odometría

%% DECLARACIÓN DE PUBLISHERS
pub = rospublisher('/robot0/cmd_vel', 'geometry_msgs/Twist'); %
msg_vel=rosmessage(pub); %% Creamos un mensaje del tipo declarado en "pub" (geometry_msgs/Twist)

%% Definimos la perodicidad del bucle (10 hz)
r = robotics.Rate(10);
waitfor(r);

%% Nos aseguramos recibir un mensaje relacionado con el robot
while (strcmp(odom.LatestMessage.ChildFrameId,'robot0')~=1)
 odom.LatestMessage
end

%% Umbrales para condiciones de parada del robot
umbral_distancia = 0.1;
umbral_angulo = 0.0001;

%% Bucle de control infinito
while (1)

    %% Obtenemos la posición y orientación actuales
    pos=odom.LatestMessage.Pose.Pose.Position;
    ori=odom.LatestMessage.Pose.Pose.Orientation;
    yaw=quat2eul([ori.W ori.X ori.Y ori.Z]);
    yaw=yaw(1);

    %% Calculamos el error de distancia

    Edist = sqrt((pos.X-xDestino)^2+(pos.Y-yDestino)^2);
    disp("EDIST");
    disp(Edist);

    %% Calculamos el error de orientación

    Eori = atan2((yDestino-pos.Y),(xDestino-pos.X))-yaw;
    disp("EORI");
    disp(Eori);

    %% Calculamos las consignas de velocidades
    consigna_vel_linear = 0.2 * Edist;
    consigna_vel_ang = 0.6 * Eori;
    %% Condición de parada
    if (Edist<umbral_distancia) && (abs(Eori)<umbral_angulo)
        %Una vez llegamos al punto, paramos el robot
        msg_vel.Linear.X= 0;
        msg_vel.Angular.Z= 0;
        send(pub,msg_vel);
        disp("FIN");
        break;
    end
    %% Aplicamos consignas de control
    msg_vel.Linear.X= consigna_vel_linear;
    msg_vel.Linear.Y=0;
    msg_vel.Linear.Z=0;
    msg_vel.Angular.X=0;
    msg_vel.Angular.Y=0;
    msg_vel.Angular.Z= consigna_vel_ang;
    % Comando de velocidad
    send(pub,msg_vel);
    % Temporización del bucle según el parámetro establecido en r
    waitfor(r);
end
%% DESCONEXIÓN DE ROS
rosshutdown;