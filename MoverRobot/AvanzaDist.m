function AvanzaDist(Vel,distancia)

    %% DECLARACIÓN DE SUBSCRIBERS
    odom=rossubscriber('/robot0/odom'); % Subscripción a la odometría
    %% DECLARACIÓN DE PUBLISHERS
    pub = rospublisher('/robot0/cmd_vel', 'geometry_msgs/Twist'); %
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
    while (strcmp(odom.LatestMessage.ChildFrameId,'robot0')~=1)
        odom.LatestMessage
    end

    %% POSICION INICIAL
    pos_inicial=odom.LatestMessage.Pose.Pose.Position;


    while (1)

        pos=odom.LatestMessage.Pose.Pose.Position;
        %DISTANCIA RECORRIDA
        dist=sqrt((pos_inicial.X-pos.X)^2+(pos_inicial.Y-pos.Y)^2);


        if (dist>distancia)
            msg.Linear.X=0;
            send(pub,msg);
            break;
        end
        send(pub,msg);
        waitfor(r);
    end
    
    d = ["Avance de ",num2str(distancia),"º a velocidad ",num2str(vel)];
    disp (d);