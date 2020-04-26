%% INICIALIZACI�N DE ROS (COMPLETAR ESPACIOS CON LAS DIRECCIONES IP)
setenv('ROS_MASTER_URI','http://192.168.1.40:11311');
setenv('ROS_IP','192.168.1.36');
rosinit() % Inicializaci�n de ROS en la IP correspondiente

%% DECLARACI�N DE VARIABLES NECESARIAS PARA EL CONTROL
MAX_TIME = 1000; % N�mero m�ximo de iteraciones
medidas = zeros(5,1000); 

%% DECLARACI�N DE SUBSCRIBERS
odom = rossubscriber('/robot0/odom'); % Subscripci�n a la odometr�a
sonar0 = rossubscriber('/robot0/sonar_0',rostype.sensor_msgs_Range); % Subscripci�n al sensor 0

%% DECLARACI�N DE PUBLISHERS
pub = rospublisher('/robot0/cmd_vel','geometry_msgs/Twist'); 
msg_vel = rosmessage(pub); % Creamos un mensaje del tipo declarado en "pub" (geometry_msgs/Twist)
msg_sonar0 = rosmessage(sonar0);

% DEFINIMOS LA PERIOCIDAD DEL BUCLE (10 Hz)
r = robotics.Rate(10);
waitfor(r);

%% NOS ASEGURAMOS DE RECIBIR UN MENSAJE RELACIONADO CON EL ROBOT
while(strcmp(odom.LatestMessage.ChildFrameId,'robot0') ~= 1)
    odom.LatestMessage;
end

%%INICIALIZAMOS VARIABLES PARA EL CONTROL
i = 0;
pos = odom.LatestMessage.Pose.Pose.Position;
dist = sonar0.LatestMessage.Range_;
lastpos = pos;
lastdist = dist;
lastdistav = 0;
distP = 2; % Distancia a mantener con la pared
%% BUCLE DE CONTROL
while (1)
    i = i + 1;
    
    % OBTENEMOS LA POSICI�N Y MEDIDAS DE SONAR
    pos = odom.LatestMessage.Pose.Pose.Position;
    msg_sonar0 = receive(sonar0);
    
    % CALCULAMOS LA DISTACIA AVANZADA Y MEDIMOS LA DISTANCIA A LA PARED
    distav = sqrt((pos.X - lastpos.X)^2+(pos.Y - lastpos.Y)^2);
    dist = sonar0.LatestMessage.Range_;
    
    if dist > 5
        dist = 5;
    end
    
    % CALCULAMOS EL ERROR DE DISTANCIA Y ORIENTACI�N
    if(distav == 0)
        Eori = 0;
    else
        Eori =  atan((dist-lastdist)/distav);
    end
    
    Edist = (dist + 0.105)*cos(Eori) - distP;
    if(maxEdist < Edist) 
        maxEdist = Edist;
    end
    if(maxEori < Eori)
        maxEori = Eori;
    end
    
    medidas(1,i) = dist;
    medidas(2,i) = lastdist; % Valor anterior de distancia
    medidas(3,i) = distav;
    medidas(4,i) = Eori;
    medidas(5,i) = Edist;
    
    % CALCULAMOS LAS CONSIGNAS DE VELOCIDADES
    consigna_vel_linear = 0.3;
    consigna_vel_ang = 0.3*Eori + 0.6*Edist;
    % CONDICI�N DE PARADA
    if(Edist < 0.01) && (Eori < 0.01)
        %break;
    end
    
    % APLICAMOS CONSIGNAS DE CONTROL
    msg_vel.Linear.X= consigna_vel_linear;
    msg_vel.Linear.Y=0;
    msg_vel.Linear.Z=0;
    msg_vel.Angular.X=0;
    msg_vel.Angular.Y=0;
    msg_vel.Angular.Z= consigna_vel_ang;
    % COMANDO DE VELOCIDAD
    send(pub,msg_vel);
    
    lastpos = pos;
    lastdist = dist;
    lastdistav = distav;
    
    % TEMPORIZACI�N DEL BUCLE SEG�N EL PAR�METRO ESTABLECIDO EN r
    waitfor(r);
    
    if i == MAX_TIME
        % Paramos robot
        msg_vel.Linear.X= 0;
        msg_vel.Linear.Y=0;
        msg_vel.Linear.Z=0;
        msg_vel.Angular.X=0;
        msg_vel.Angular.Y=0;
        msg_vel.Angular.Z= 0;
        % COMANDO DE VELOCIDAD
        send(pub,msg_vel);
        break;
    end
    save('medidas.mat','medidas');
end
%% DESCONEXI�N DE ROS
rosshutdown;