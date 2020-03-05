%%Adquisición y trata de datos de los sonares
%%Nos subscribimos a todos los sonares
s0=rossubscriber('/sonar_0');
s1=rossubscriber('/sonar_1');
s2=rossubscriber('/sonar_2');
s3=rossubscriber('/sonar_3');
s4=rossubscriber('/sonar_4');
s5=rossubscriber('/sonar_5');
s6=rossubscriber('/sonar_6');
s7=rossubscriber('/sonar_7');
%%Nos subscribimos a la odometria
odom = rossubscriber('/pose');
%%Comprobamos que recibimos información
pause(1);
while (strcmp(s0.LatestMessage.Header.FrameId,'/sonar_0')~=1)
s0.LatestMessage
end
while (strcmp(s1.LatestMessage.Header.FrameId,'/sonar_1')~=1)
s1.LatestMessage
end
while (strcmp(s2.LatestMessage.Header.FrameId,'/sonar_2')~=1)
s2.LatestMessage
end
while (strcmp(s3.LatestMessage.Header.FrameId,'/sonar_3')~=1)
s3.LatestMessage
end
while (strcmp(s4.LatestMessage.Header.FrameId,'/sonar_4')~=1)
s4.LatestMessage
end
while (strcmp(s5.LatestMessage.Header.FrameId,'/sonar_5')~=1)
s5.LatestMessage
end
while (strcmp(s6.LatestMessage.Header.FrameId,'/sonar_6')~=1)
s6.LatestMessage
end
while (strcmp(s7.LatestMessage.Header.FrameId,'/sonar_7')~=1)
s7.LatestMessage
end
while (strcmp(odom.LatestMessage.ChildFrameId,'base_link')~=1)
odom.LatestMessage
end
%%Vector de subscribers
subscribers_s = [s0,s1,s2,s3,s4,s5,s6,s7];
%%Introducimos la orientacion de cada sonar (rad)
orientaciones_s = [1.5708,0.767945,0.20944,-0.20944,-0.767945,-1.5708,-2.51327,2.51327];
%%Introducimos punto de emision del sonar respecto al centro del amigobot
%posiciones_s =[0,cos(0.767495),cos(0.20944),cos(0.20944),cos(0.767495),0,-cos(pi-2.51327),-cos(pi-2.51327);
 %               0.15,sin(0.767495),sin(0.20944),-sin(0.20944),-sin(0.767495),-0.15,-sin(pi-2.51327),sin(pi-2.51327)];
 posiciones_s = [0.076,0.125,0.15,0.15,0.125,0.076,-0.14,-0.14;
                0.1,0.075,0.03,-0.03,-0.075,-0.1,-0.058,0.058];
%%Datos para calcular posicion y rotacion
pos = odom.LatestMessage.Pose.Pose.Position;
rot = odom.LatestMessage.Pose.Pose.Orientation;
%%Datos para calcular la distancia min(en el eje de orientacion del sensor)
amplitud_vision = 0.261799; %rad
angulo_calc = amplitud_vision/2; %rad
dist = 0.0;
dist_min = 0.0;
supp = 0.0; %superficie de choque posible
%%Datos para gráfica
%x_grafica = zeros(8,2);
%y_grafica = zeros(8,2);
%PUNTA
x_grafica = zeros(8,3);
y_grafica = zeros(8,3);
%%CALCULO DE LA ROTACION antes de comprobar datos de sensores
quaternion=[rot.W rot.X rot.Y rot.Z];
euler=quat2eul(quaternion,'ZYX');
rotacion=euler(1);
%Recogemos datos de dist
distancias_s = zeros(8);
%%Reconocimiento táctico
for i = 1:8
    dist = subscribers_s(i).LatestMessage.Range_;
    distancias_s(i) = dist;
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
    %disp(rotacion);
    %%Guardamos puntos para después dibujar gráfica
    coordenadasCompletas = posicionFinal(dist,pos,rotacion,orientaciones_s(i),posiciones_s,i);
    x_grafica(i,1) = coordenadasCompletas(1);
    y_grafica(i,1) = coordenadasCompletas(2);
    x_grafica(i,2) = coordenadasCompletas(3);
    y_grafica(i,2) = coordenadasCompletas(4);
    %PUNTA
    x_grafica(i,3) = coordenadasCompletas(5);
    y_grafica(i,3) = coordenadasCompletas(6);
end
%%Grafica
disp(pos.X);
disp(pos.Y);
figure
plot(x_grafica,y_grafica,'co','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Medidas Sonar');
%Estado pared
estadoParedes = paredes_p1_6(x_grafica,y_grafica,distancias_s);
disp ('ESTADO PARED:');
disp (estadoParedes);