%% DECLARACIÓN DE SUBSCRIBERS
odom=rossubscriber('/robot0/odom');  %%Subcribimos a la odometria

%% Nos aseguramos recibir un mensaje relacionado con el robot "robot0"
pause(1);
while (strcmp(odom.LatestMessage.ChildFrameId,'robot0')~=1)
odom.LatestMessage
end

pos = odom.LatestMessage.Pose.Pose.Position;
rot = odom.LatestMessage.Pose.Pose.Orientation;

disp("POSICON DEL ROBOT:");
disp("   EJE X: "+pos.X);
disp("   EJE Y: "+pos.Y);
disp(" ");
disp("ORIENTACION DEL ROBOT:");
disp("   EJE Z: "+rot.Z);
disp(" ");
disp(" ");
