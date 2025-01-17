%% DECLARAMOS EL PUBLISHER
pub = rospublisher('/robot0/cmd_vel', 'geometry_msgs/Twist');

%% GENERAMOS EL TIPO DE MENSAJE
msg = rosmessage(pub);

%% VELOCIDADES LINEALES
msg.Linear.X=0;
msg.Linear.Y=0;
msg.Linear.Z=0;

%% VELOCIDADES ANGULARES(ROTACION)
msg.Angular.X=0;
msg.Angular.Y=0;
msg.Angular.Z=0.9;

% DEFINIMOS PERIODICIDAD DEL BUCLE
r = robotics.Rate(10);


%% SENTENCIA DE CONTROL PARA PARAR EL ROBOT
% Cantidad de veces que se va a ejecutar el bucle
vueltas = 1;

%% BUCLE DE CONTROL
    reset(r);
while(1)
    
    send(pub,msg); %Enviamos el mensaje de movimiento
    ODOM; %LLAMAMOS AL SCRIPT DE ODOMETRIA 
    waitfor(r);
    
   
    if(vueltas>8)%Comprobamos la sentencia de control en caso de haber cumplido el numeor de ejecuciones paramos el robot
        msg.Linear.X=0;
        msg.Angular.Z=0;
        send(pub,msg);
        break;       
    end
    vueltas=vueltas + 1;
end

%% LLAMAMOS AL SCRIPT DE FINALIZACION
END_2_1;
