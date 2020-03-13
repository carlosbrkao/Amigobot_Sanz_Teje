%%DECLARAMOS EL PUBLISHER
pub = rospublisher('/robot0/cmd_vel', 'geometry_msgs/Twist');

%%GENERAMOS EL TIPO DE MENSAJE
msg = rosmessage(pub);

%%VELOCIDADES LINEALES
msg.Linear.X=0;
msg.Linear.Y=0;
msg.Linear.Z=0;

%%VELOCIDADES ANGULARES(ROTACION)
msg.Angular.X=0;
msg.Angular.Y=0;
msg.Angular.Z=0.9;

%DEFINIMOS PERIODICIDAD DEL BUCLE
r = robotics.Rate(10);


%%SENTENCIA DE CONTROL PARA PARAR EL ROBOT
vueltas = 1;

%%BUCLE DE CONTROL
    reset(r);
while(1)
    %disp(r.TotalElapsedTime);
    send(pub,msg);
    ODOM; %%LLAMAMOS AL SCRIPT DE ODOMETRIA
    waitfor(r);
    
   
    if(vueltas>8)
        msg.Linear.X=0;
        msg.Angular.Z=0;
        send(pub,msg);
        break;       
    end
    vueltas=vueltas + 1;
end

%%LLAMAMOS AL SCRIPT END
END_2_1;
