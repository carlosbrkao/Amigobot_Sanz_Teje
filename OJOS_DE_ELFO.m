%%Adquisición y trata de datos de los sonares
%%Nos subscribimos a todos los sonares
s0=rossubscriber('/robot0/sonar_0');
s1=rossubscriber('/robot0/sonar_1');
s2=rossubscriber('/robot0/sonar_2');
s3=rossubscriber('/robot0/sonar_3');
s4=rossubscriber('/robot0/sonar_4');
s5=rossubscriber('/robot0/sonar_5');
s6=rossubscriber('/robot0/sonar_6');
s7=rossubscriber('/robot0/sonar_7');
%%Nos subscribimos a la odometria
odom = rossubscriber('/robot0/odom');
%%Comprobamos que recibimos información
pause(1);
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
while (strcmp(odom.LatestMessage.ChildFrameId,'robot0')~=1)
odom.LatestMessage
end
%%Vector de subscribers
subscribers_s = [s0,s1,s2,s3,s4,s5,s6,s7];
%%Introducimos la orientacion de cada sonar (rad)
orientaciones_s = [1.5708,0.767945,0.20944,-0.20944,-0.767945,-1.5708,-2.51327,2.51327];
%%Datos para calcular posicion y rotacion
pos = odom.LatestMessage.Pose.Pose.Position;
rot = odom.LatestMessage.Pose.Pose.Orientation;
%%Datos para calcular la distancia min(en el eje de orientacion del sensor)
amplitud_vision = 0.261799, %rad
angulo_calc = amplitud_vision/2; %rad
dist = 0.0;
dist_min = 0.0;
error = 0.0;
supp = 0.0; %superficie de choque posible
%%Datos para gráfica
%puntos_grafica = zeros(8,4); %Matriz formato: sensor [x1][y1][x2][y2]
x_grafica = zeros(8,2);
y_grafica = zeros(8,2);
%%CALCULO DE LA ROTACION antes de comprobar datos de sensores
quaternion=[rot.W rot.X rot.Y rot.Z];
euler=quat2eul(quaternion,'ZYX');
rotacion=euler(1);
%%Reconocimiento táctico
for i = 1:8
    dist = subscribers_s(i).LatestMessage.Range_;
    dist_min = cos(angulo_calc)*dist; %distancia min
    supp = (sin(angulo_calc)*dist)*2; %sup de choque min
    %%Recogemos posición actual
    %Datos para calcular posicion y rotacion
    pos = odom.LatestMessage.Pose.Pose.Position;
    rot = odom.LatestMessage.Pose.Pose.Orientation;
    %Calculo la rotación
    quaternion=[rot.W rot.X rot.Y rot.Z];
    euler=quat2eul(quaternion,'ZYX');
    rotacion=euler(1);
    disp(rotacion);
    %%Guardamos puntos para después dibujar gráfica
    coordenadasCompletas = posicionReal(dist,pos,rotacion,orientaciones_s,i);
    %puntos_grafica(i,1) = coordenadasCompletas(1);
    x_grafica(i,1) = coordenadasCompletas(1);
    %puntos_grafica(i,2) = coordenadasCompletas(2);
    y_grafica(i,1) = coordenadasCompletas(2);
    %puntos_grafica(i,3) = coordenadasCompletas(3);
    x_grafica(i,2) = coordenadasCompletas(3);
    %puntos_grafica(i,4) = coordenadasCompletas(4);
    y_grafica(i,2) = coordenadasCompletas(4);
end
%%Grafica
%plot(puntos_grafica(1,1),puntos_grafica(1,2),'o',puntos_grafica(1,3),puntos_grafica(1,4),'o',puntos_grafica(2,1),puntos_grafica(2,2),'+',puntos_grafica(2,3),puntos_grafica(2,4),'+',puntos_grafica(3,1),puntos_grafica(3,2),'*',puntos_grafica(3,3),puntos_grafica(3,4),'*',puntos_grafica(4,1),puntos_grafica(4,2),'x',puntos_grafica(4,3),puntos_grafica(4,4),'x',puntos_grafica(5,1),puntos_grafica(5,2),'s',puntos_grafica(5,3),puntos_grafica(5,4),'s',puntos_grafica(6,1),puntos_grafica(6,2),'d',puntos_grafica(6,3),puntos_grafica(6,4),'d',puntos_grafica(7,1),puntos_grafica(7,2),'p',puntos_grafica(7,3),puntos_grafica(7,4),'p',puntos_grafica(8,1),puntos_grafica(8,2),'h',puntos_grafica(8,3),puntos_grafica(8,4),'h')
disp(pos.X);
disp(pos.Y);
figure
plot(x_grafica,y_grafica,'co','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Medidas Sonar');  