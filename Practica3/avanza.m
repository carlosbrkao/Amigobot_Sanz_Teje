function avanza(vel,dist)

%% DECLARACIÓN DE SUBSCRIBERS Y PUBLISHERS
% SUBSCRIBER
    odom=rossubscriber('/robot0/odom');  %%Subcribimos a la odometria
% PUBLISHER
    pub = rospublisher('/robot0/cmd_vel', 'geometry_msgs/Twist');
    msg = rosmessage(pub);
% COMPROBACIÓN
    pause(1);
    while (strcmp(odom.LatestMessage.ChildFrameId,'robot0')~=1)
        odom.LatestMessage
    end
%% VELOCIDADES LINEALES PARA EL AVANCE
    msg.Linear.X = vel;
    msg.Linear.Y = 0;
    msg.Linear.Z = 0;
%% DEFINIMOS PERIODICIDAD DEL BUCLE
    rate = 10;
    r = robotics.Rate(rate);
%% BUCLE MOVIMIENTO
    % Guardamos posición inicial
    pos_inicial=odom.LatestMessage.Pose.Pose.Position;
    while (1)

        pos=odom.LatestMessage.Pose.Pose.Position;
        % Distancia recorrida
        dist=sqrt((pos_inicial.X-pos.X)^2+(pos_inicial.Y-pos.Y)^2);

        %% En cuanto se supera la distancia a recorrer se para el robot
        if (dist>distancia)
            msg.Linear.X=0;
            send(pub,msg);
            break;
        end
        %% Mientras no se haya superado la distancia, el robot mantiene su velocidad
        send(pub,msg);
        waitfor(r);
    end
