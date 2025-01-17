%% Funci�n para ordenar al robot que se desplace una distancia facilitada por par�metros a una velocidad
% tambi�n prefijada por par�metros
function AvanzaDist(Vel,distancia)

    %% DECLARACI�N DE SUBSCRIBERS
    odom=rossubscriber('/pose'); % Subscripci�n a la odometr�a
    %% DECLARACI�N DE PUBLISHERS
    pub = rospublisher('/cmd_vel', 'geometry_msgs/Twist'); %
    %% MENSAJE 
    msg=rosmessage(pub);
    %% DATOS DEL MENSAJE
    %Vel Lineal
    msg.Linear.X=Vel;
    msg.Linear.Y=0;
    msg.Linear.Z=0;
    % Velocidades angulares
    msg.Angular.X=0;
    msg.Angular.Y=0;
    msg.Angular.Z=0;

    %% Periodicidad del bucle 
    r = robotics.Rate(10);

    pause(1);
    while (strcmp(odom.LatestMessage.ChildFrameId,'base_link')~=1)
        odom.LatestMessage
    end

    %% POSICION INICIAL
    pos_inicial=odom.LatestMessage.Pose.Pose.Position;


    while (1)

        pos=odom.LatestMessage.Pose.Pose.Position;
        %% DISTANCIA RECORRIDA
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