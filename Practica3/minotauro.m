%% CONEXION
% CONECTAMOS CON LA MV
    setenv('ROS_MASTER_URI','http://192.168.1.40:11311');
    setenv('ROS_IP','192.168.1.37');
    rosinit() % Inicializaciï¿½n de ROS en la IP correspondiente

%% INICIALIZACION DE SUSBSCRIBERS Y PUBLISHERS
% DECLARACION DE SUBSCRIBERS
    odom = rossubscriber('/robot0/odom');       % Subscripcio½n a la odometrï¿½a
    laser = rossubscriber('/robot0/laser_1');   % Subscripcion al lï¿½ser
    s0=rossubscriber('/robot0/sonar_0');        % Subcsripcion al sonar_0
    s1=rossubscriber('/robot0/sonar_1');        % Subcsripcion al sonar_1
    s2=rossubscriber('/robot0/sonar_2');        % Subcsripcion al sonar_2
    s3=rossubscriber('/robot0/sonar_3');        % Subcsripcion al sonar_3
    s4=rossubscriber('/robot0/sonar_4');        % Subcsripcion al sonar_4
    s5=rossubscriber('/robot0/sonar_5');        % Subcsripcion al sonar_5
    s6=rossubscriber('/robot0/sonar_6');        % Subcsripcion al sonar_6
    s7=rossubscriber('/robot0/sonar_7');        % Subcsripcion al sonar_7
% DECLARACION DE PUBLISHERS
    pub = rospublisher('/robot0/cmd_vel', 'geometry_msgs/Twist'); % Publisher para comunicar velocidad
    msg_vel = rosmessage(pub); % Creamos un mensaje del tipo declarado en "pub" (geometry_msgs/Twist)
% COMPROBACION DE INICIALIZACIï¿½N COMPLETADA
    pause(2);
    % Comprobacion odometria
    while (strcmp(odom.LatestMessage.ChildFrameId,'robot0')~=1)
        odom.LatestMessage
    end
    % Comprobacion laser
    while (strcmp(laser.LatestMessage.Header.FrameId,'robot0_laser_1')~=1)
        laser.LatestMessage
    end
    % Comprobacion sonares
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
% Mapa
filas = 6; % En metros
columnas = 14; % En metros
mapa = zeros(filas + 1, columnas + 1); % INDICE:  NO VISITADA = 0 / VISITADA = 1 / LIBRE(NO PARED) = 2 / PARED = 3
mapeado = false; % Indica si el mapa ha sido muestreado
% Inicializamos todas las paredes como huecos(libres)
for i = 1:2:columnas + 1
    for j = 1:filas + 1
        mapa(j,i) = 2;
    end
end
for i = 1:2:filas + 1 
    for j = 1:columnas + 1
        mapa(i,j) = 2;
    end
end
% Indica si estamos mapeando o hemos acabado
control = true;
%% BUCLE
while(control)
    % INFORMACION ACTUAL
        pos = odom.LatestMessage.Pose.Pose.Position;
        rot = odom.LatestMessage.Pose.Pose.Orientation;
        % Calculo de angulo
        quaternion=[rot.W rot.X rot.Y rot.Z];
        euler=quat2eul(quaternion,'ZYX');
        rotacion=euler(1);
        angulo = redondeoAngulos(rotacion);
    % ANALISIS CASILLA
        casilla = detectorCasilla(laser);
        % Concociendo la ubicación y el tipo de casilla registramos lo
        % muestreado en el mapa
        mapa = actualizaMapa(mapa,casilla,pos,filas,columnas,angulo);
        % Comprobación de si se ha mapeado el mapa
        mapeado = horaDeSalir(mapa,filas,columnas);
        if(mapeado)
            disp('EL MAPA HA SIDO MAPEADO POR COMPLETO');
            disp(['CASILLA SALIDA: ',num2str(salidaY),':',num2str(salidaX)]); 
        end
        % Estudio del entorno de la casilla 
        posiblesRutas = gps(mapa,pos,filas,columnas,angulo);
        % En caso de ser la casilla de salida la registramos
        if(luzAlFinalDelTunel(posiblesRutas))
            salidaX = round(pos.X) + 1;
            salidaY = round(pos.Y) + 1;
        end
    % MOVIMIENTO
        % Salida del laberinto 
        if(mapeado)
            control = false;
            % Busca ruta de salida
            rutaSalida = quieroSalir(mapa,filas,columnas,salidaY,salidaX,round(pos.Y)+1,round(pos.X)+1,[salidaY;salidaX],[salidaY;salidaX],1,1);
            tamanno = size(rutaSalida);
            % Sigue la ruta hacía la casilla donde esta la salida
            for i = tamanno(2)-1:-1:1
                avanza(pub,odom,rutaSalida(2,i)-1,rutaSalida(1,i)-1);
            end
            % Sale del laberinto desde la casilla de la salida
                % Información actual
                pos = odom.LatestMessage.Pose.Pose.Position;
                rot = odom.LatestMessage.Pose.Pose.Orientation;
                % Obtención de la orientación
                quaternion=[rot.W rot.X rot.Y rot.Z];
                euler=quat2eul(quaternion,'ZYX');
                rotacion=euler(1);
                angulo = redondeoAngulos(rotacion);
                % Estudio de la casilla
                posiblesRutas = gps(mapa,pos,filas,columnas,angulo);
                f = round(pos.Y);
                c = round(pos.X);
                % Buscamos la salida y avanzamos por ella
                for i = 1:4
                    if(posiblesRutas(1,i) == 1) && (posiblesRutas(2,i) == 2)
                        switch (i)
                            case 1
                                avanza(pub,odom,c,f+1);
                            case 2
                                avanza(pub,odom,c+1,f);
                            case 3
                                avanza(pub,odom,c,f-1);
                            otherwise
                                avanza(pub,odom,c-1,f);
                        end
                    end
                end
        % Desplazamiento a derecha mapeando el mapa
        else
            destino = siempreDerecha(laser,angulo,odom,posiblesRutas,filas,columnas);
            avanza(pub,odom,destino(1),destino(2));
        end            
end
%% DESCONECTAMOS
rosshutdown;