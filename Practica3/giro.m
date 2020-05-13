function giro(vel,angulo)

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
%% CALCULO DEL ANGULO DEL GIRO DESEADO
    anguloRad = angulo*pi/180;
%% VELOCIDADES ANGULARES PARA EL GIRO
    msg.Angular.X = 0;
    msg.Angular.Y = 0;
    if(anguloRad < 0)
        msg.Angular.Z = vel * -1;
    else 
        msg.Angular.Z = vel;
    end
%% DEFINIMOS PERIODICIDAD DEL BUCLE
    rate = 10;
    r = robotics.Rate(rate);
%% ESTIMACIÓN DEL TIEMPO DEL GIRO PARA CONTROL DEL GIRO
    tEnLlegar = anguloRad/msg.Angular.Z;
    Vueltas = tEnLlegar/(1/rate);
    % Mantenemos la velocidad angular durante el tiempo de giro
        i = 0;
        while(i<Vueltas)
            send(pub,msg);
            waitfor(r);
            i=i+1;
        end
    % Cuando el giro ha sido llevado acabo se le ordena detener la acción
    % de girar
    msg.Angular.Z = 0;
    send(pub,msg);
    %---------------------------------------------------------------------------COMPROBACIÓN
