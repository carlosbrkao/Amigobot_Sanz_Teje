function PosicionActual()


%% DECLARACIÓN DE SUBSCRIBERS
odom=rossubscriber('/pose');  %%Subcribimos a la odometria

%% Nos aseguramos recibir un mensaje relacionado con el robot "robot0"
pause(1);
while (strcmp(odom.LatestMessage.ChildFrameId,'base_link')~=1)
odom.LatestMessage
end

pos = odom.LatestMessage.Pose.Pose.Position;
rot = odom.LatestMessage.Pose.Pose.Orientation;

%%CALCULO DE LA ROTACION
quaternion=[rot.W rot.X rot.Y rot.Z];
euler=quat2eul(quaternion,'ZYX');
rotacion=euler(1);

disp("POSICON DEL ROBOT:");
disp("   EJE X: "+pos.X);
disp("   EJE Y: "+pos.Y);
disp(" ");
disp("ORIENTACION DEL ROBOT:");
disp("   EJE Z: "+rotacion);
disp(" ");
