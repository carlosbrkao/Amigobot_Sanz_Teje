function avanza(pub,odom,xDestino,yDestino)


%% DECLARACIÓN DE MENSAGE
msg_vel=rosmessage(pub); %% Creamos un mensaje del tipo declarado en "pub" (geometry_msgs/Twist)

%% Definimos la perodicidad del bucle (10 hz)
r = robotics.Rate(10);


   

%% Umbrales para condiciones de parada del robot
umbral_distancia = 0.05;
umbral_angulo = 0.01;
%% Bucles de control infinito

while (1)

    %% Obtenemos la posición y orientación actuales
    pos=odom.LatestMessage.Pose.Pose.Position;
    ori=odom.LatestMessage.Pose.Pose.Orientation;
    yaw=quat2eul([ori.W ori.X ori.Y ori.Z]);
    yaw=yaw(1);

    %% Calculamos el error de orientación
    
    Eori = atan2((yDestino-pos.Y),(xDestino-pos.X))-yaw;
    
    disp("ERROR ORIENTACION " + Eori);
    
    
    %%Correccion de giro ineficiente
    if(Eori < -4)
        Eori = Eori * -1;
        Eori = Eori - 3;
    elseif(Eori > 4)
        Eori = Eori * -1;
        Eori = Eori + 3;
    end
         
    %% Calculamos las consignas de velocidades
    consigna_vel_ang = 1 * Eori;
    
    if(consigna_vel_ang >1)
        consigna_vel_ang=1;
    end
          
    
    %% Condición de parada
    if (abs(Eori)<umbral_angulo)
        %Una vez llegamos al punto, paramos el robot
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



while (1)

    %% Obtenemos la posición y orientación actuales
    pos=odom.LatestMessage.Pose.Pose.Position;

    %% Calculamos el error de distancia

    Edist = sqrt((pos.X-xDestino)^2+(pos.Y-yDestino)^2);
    
    %% Calculamos las consignas de velocidades
    consigna_vel_linear = 4 * Edist;

    if(consigna_vel_linear>1)
        consigna_vel_linear = 1;
    end
    

    
    
    %% Condición de parada
    if (Edist<umbral_distancia)
        %Una vez llegamos al punto, paramos el robot
        msg_vel.Linear.X= 0;
        send(pub,msg_vel);
        break;
    end
    %% Aplicamos consignas de control
    msg_vel.Linear.X= consigna_vel_linear;
    msg_vel.Linear.Y=0;
    msg_vel.Linear.Z=0;
    msg_vel.Angular.X=0;
    msg_vel.Angular.Y=0;
    msg_vel.Angular.Z= 0;
    % Comando de velocidad
    send(pub,msg_vel);
    % Temporización del bucle según el parámetro establecido en r
    waitfor(r);
end




