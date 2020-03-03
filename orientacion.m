function rad = orientacion(odom)

rot = odom.LatestMessage.Pose.Pose.Orientation;

%%CALCULO DE LA ROTACION
quaternion=[rot.W rot.X rot.Y rot.Z];
euler=quat2eul(quaternion,'ZYX');
rad=euler(1);