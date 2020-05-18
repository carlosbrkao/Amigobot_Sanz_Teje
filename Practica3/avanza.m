function avanza()

%% DECLARACIÓN DE SUBSCRIBERS
odom = rossubscriber('/robot0/odom'); % Subscripción a la odometría

%% DECLARACIÓN DE PUBLISHERS
pub = rospublisher('/robot0/cmd_vel', 'geometry_msgs/Twist'); %
msg_vel=rosmessage(pub); %% Creamos un mensaje del tipo declarado en "pub" (geometry_msgs/Twist)

%% Definimos la perodicidad del bucle (10 hz)
r = robotics.Rate(10);
waitfor(r);
pause(2);
%% Nos aseguramos recibir un mensaje relacionado con el robot
while (strcmp(odom.LatestMessage.ChildFrameId,'robot0')~=1)
     odom.LatestMessage
end




%% Calculo de destino
    pos=odom.LatestMessage.Pose.Pose.Position;
    ori=odom.LatestMessage.Pose.Pose.Orientation;
    yaw=quat2eul([ori.W ori.X ori.Y ori.Z]);
    yaw=yaw(1);



    % Obtenemos las coordenadas de la casilla actua
    casillaX = round(pos.X);
    casillaY = round(pos.Y);
     
    angulos = [0,90,180,-90];
    angulo = round((yaw * 180)/pi);
    for i = 1:4
        if(i == 3)
           if((abs(angulo) - angulos(i))<5 && (abs(angulo) - angulos(i)>-5))  
               angulo = angulos(i);
               i = 4; 
           end     
        else
           if((angulo - angulos(i))<5 && (angulo - angulos(i)>-5))  
               angulo = angulos(i);
               i = 4; 
           end
        end
    end
    
    controlAng = (angulo * pi)/180;
    if(angulo == 0)
        xDestino = casillaX + 2;
        yDestino = casillaY;
    elseif(angulo == 90)
        xDestino = casillaX;
        yDestino = casillaY+2;
    elseif(angulo == 180)
        xDestino = casillaX - 2;
        yDestino = casillaY;
    elseif(angulo == -90)
        xDestino = casillaX;
        yDestino = casillaY-2;
    end

%% Umbrales para condiciones de parada del robot
umbral_distancia = 0.01;
%umbral_angulo = 0.1;
%% Bucle de control infinito
while (1)

    %% Obtenemos la posición y orientación actuales
    pos=odom.LatestMessage.Pose.Pose.Position;
    ori=odom.LatestMessage.Pose.Pose.Orientation;
    yaw=quat2eul([ori.W ori.X ori.Y ori.Z]);
    yaw=yaw(1);

    %% Calculamos el error de distancia

    Edist = sqrt((pos.X-xDestino)^2+(pos.Y-yDestino)^2);
    
    
    %% Calculamos el error de orientación 
    

    
    Eori = atan2((yDestino-pos.Y),(xDestino-pos.X))-yaw;
        
    if(angulo == 180)
        Eori = 0;
        if((casillaX - pos.X) > 2)
            msg_vel.Linear.X = 0;
            msg_vel.Angular.Z = 0;
            send(pub,msg_vel);
            break;
        end
    end
    
   

    
    %% Calculamos las consignas de velocidades
    consigna_vel_linear = 0.5 * Edist;
    consigna_vel_ang = 0.3 * Eori;
    if(consigna_vel_linear>1)
        consigna_vel_linear = 1;
    end
    if(consigna_vel_ang >1)
        consigna_vel_ang=1;
    end
    
    

    
    
    %% Condición de parada
    if (Edist<umbral_distancia) %&& (abs(Eori)<umbral_angulo)
        %Una vez llegamos al punto, paramos el robot
        msg_vel.Linear.X= 0;
        msg_vel.Angular.Z= 0;
        send(pub,msg_vel);
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

while(1)

    ori=odom.LatestMessage.Pose.Pose.Orientation;
    yaw=quat2eul([ori.W ori.X ori.Y ori.Z]);
    yaw=yaw(1);
    
    
    error = controlAng - yaw;
    
    consigna_vel_ang = 0.5 * error;
     
    if (abs(error)<0.01)
        %Una vez llegamos al punto, paramos el robot
        msg_vel.Linear.X= 0;
        msg_vel.Angular.Z= 0;
        send(pub,msg_vel);
        break;
    end
    %% Aplicamos consignas de control
    msg_vel.Linear.X= 0;
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



