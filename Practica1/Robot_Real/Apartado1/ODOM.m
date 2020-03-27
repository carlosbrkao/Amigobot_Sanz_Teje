%% DECLARACIÓN DE SUBSCRIBERS
odom=rossubscriber('/pose');  %%Subcribimos a la odometria

%% Nos aseguramos recibir un mensaje relacionado con el robot "robot0"
pause(1);
while (strcmp(odom.LatestMessage.ChildFrameId,'base_link')~=1)
odom.LatestMessage
end

%% GUARDAMOS LOS DATOS DE POSICIION Y ROTACION
pos = odom.LatestMessage.Pose.Pose.Position;
rot = odom.LatestMessage.Pose.Pose.Orientation;

%% CALCULO DE LA ROTACION(Resultado en radianes)
quaternion=[rot.W rot.X rot.Y rot.Z];
euler=quat2eul(quaternion,'ZYX');
rotacion=euler(1);

%% Guardamos los resultados recogidos en las variables globales
posicion = posicion +1;
datosLin(posicion)= pos.X;
datosAn(posicion)= rotacion;

%% ESTA SECCION DE CODIGO COMENTADA ES UTIL PARA MOSTRAR LOS DATOS RECOGIDOS POR PANTALLA
% disp("POSICON DEL ROBOT:");
% disp("   EJE X: "+pos.X);
% disp("   EJE Y: "+pos.Y);
% disp(" ");
% disp("ORIENTACION DEL ROBOT:");
% disp("   EJE Z: "+rotacion);
% disp(" ");
% disp(" ");
