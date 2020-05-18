function avanza(pub,odom,giro)


%% DECLARACI�N DE MENSAGE
msg_vel=rosmessage(pub); %% Creamos un mensaje del tipo declarado en "pub" (geometry_msgs/Twist)

%% Definimos la perodicidad del bucle (10 hz)
r = robotics.Rate(10);



%% Calculo de destino
    pos=odom.LatestMessage.Pose.Pose.Position;
    % Obtenemos las coordenadas de la casilla actua
    casillaX = round(pos.X);
    casillaY = round(pos.Y);
    
    ori=odom.LatestMessage.Pose.Pose.Orientation;
    yaw=quat2eul([ori.W ori.X ori.Y ori.Z]);
    yaw=yaw(1);
    
    angulos = [0,90,180,-90];
    angulo = round((yaw * 180)/pi);
    angulo = angulo + giro;
    
    if(angulo>350) 
        angulo = 0;
    elseif(angulo>250) 
        angulo = -90; 
    elseif(angulo<-350)
        angulo = 0;
    elseif(angulo<-250)
        angulo = 90;
    end
    
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
    
    disp("CASILLA X " + casillaX);
    disp("CASILLA Y " + casillaY);
    disp("DESTINO X " + xDestino);
    disp("DESTINO Y " + yDestino);

%% Umbrales para condiciones de parada del robot
umbral_distancia = 0.05;
umbral_angulo = 0.01;
%% Bucles de control infinito

while (1)

    %% Obtenemos la posici�n y orientaci�n actuales
    pos=odom.LatestMessage.Pose.Pose.Position;
    ori=odom.LatestMessage.Pose.Pose.Orientation;
    yaw=quat2eul([ori.W ori.X ori.Y ori.Z]);
    yaw=yaw(1);

    %% Calculamos el error de orientaci�n
    
    Eori = atan2((yDestino-pos.Y),(xDestino-pos.X))-yaw;
        
%     if(angulo == 180)
%         Eori = 0;
%         if((casillaX - pos.X) > 2)
%             msg_vel.Linear.X = 0;
%             msg_vel.Angular.Z = 0;
%             send(pub,msg_vel);
%             break;
%         end
%     end
    
    
    %% Calculamos las consignas de velocidades
    consigna_vel_ang = 0.6 * Eori;
    
    if(consigna_vel_ang >1)
        consigna_vel_ang=1;
    end
          
    
    %% Condici�n de parada
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
    % Temporizaci�n del bucle seg�n el par�metro establecido en r
    waitfor(r);
end



while (1)

    %% Obtenemos la posici�n y orientaci�n actuales
    pos=odom.LatestMessage.Pose.Pose.Position;

    %% Calculamos el error de distancia

    Edist = sqrt((pos.X-xDestino)^2+(pos.Y-yDestino)^2);
    
    %% Calculamos las consignas de velocidades
    consigna_vel_linear = 1 * Edist;

    if(consigna_vel_linear>1)
        consigna_vel_linear = 1;
    end
    

    
    
    %% Condici�n de parada
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
    % Temporizaci�n del bucle seg�n el par�metro establecido en r
    waitfor(r);
end

% while(1)
% 
%     ori=odom.LatestMessage.Pose.Pose.Orientation;
%     yaw=quat2eul([ori.W ori.X ori.Y ori.Z]);
%     yaw=yaw(1);
%     
%     
%     error = controlAng - yaw;
%     
%     consigna_vel_ang = 0.5 * error;
%      
%     if (abs(error)<0.01)
%         %Una vez llegamos al punto, paramos el robot
%         msg_vel.Linear.X= 0;
%         msg_vel.Angular.Z= 0;
%         send(pub,msg_vel);
%         break;
%     end
%     %% Aplicamos consignas de control
%     msg_vel.Linear.X= 0;
%     msg_vel.Linear.Y=0;
%     msg_vel.Linear.Z=0;
%     msg_vel.Angular.X=0;
%     msg_vel.Angular.Y=0;
%     msg_vel.Angular.Z= consigna_vel_ang;
%     % Comando de velocidad
%     send(pub,msg_vel);
%     % Temporizaci�n del bucle seg�n el par�metro establecido en r
%     waitfor(r);
%     
% end



