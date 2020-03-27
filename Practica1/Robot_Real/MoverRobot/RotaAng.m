%% Función para ordenar al robot que rote un ángulo facilitado por parámetros a una velocidad
%% también prefijada por parámetros
function RotaAng(vel,angulo)

%% DECLARACIÓN DE SUBSCRIBERS
odom=rossubscriber('/pose');  %%Subcribimos a la odometria

%% Nos aseguramos recibir un mensaje relacionado con el robot "robot0"
pause(1);
while (strcmp(odom.LatestMessage.ChildFrameId,'base_link')~=1)
odom.LatestMessage
end

%% DECLARAMOS EL PUBLISHER
pub = rospublisher('/cmd_vel', 'geometry_msgs/Twist');

%% GENERAMOS EL TIPO DE MENSAJE
msg = rosmessage(pub);

%% VELOCIDADES LINEALES
msg.Linear.X=0;
msg.Linear.Y=0;
msg.Linear.Z=0;

%% VELOCIDADES ANGULARES(ROTACION)
msg.Angular.X=0;
msg.Angular.Y=0;
msg.Angular.Z=vel;

%% ANGULO DESEADO
anguloRad = angulo*pi/180;

if(anguloRad<0)
    msg.Angular.Z = msg.Angular.Z *-1;
end


%% DEFINIMOS PERIODICIDAD DEL BUCLE
rate = 10;
r = robotics.Rate(rate);

tEnLlegar = anguloRad/msg.Angular.Z;
Vueltas = tEnLlegar/(1/rate);


i = 0;
while(i<Vueltas)
    
    send(pub,msg);
    waitfor(r);
    i=i+1;
end
    msg.Angular.Z = 0;
    send(pub,msg);


