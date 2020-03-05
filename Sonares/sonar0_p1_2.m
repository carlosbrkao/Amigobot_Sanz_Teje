%%Adquisición y trata de datos de los sonares
%%Nos subscribimos a todos los sonares
s0=rossubscriber('/robot0/sonar_0');
%%Nos subscribimos a la odometria
odom = rossubscriber('/robot0/odom');
%%Comprobamos que recibimos información
pause(1);
while (strcmp(s0.LatestMessage.Header.FrameId,'robot0_sonar_0')~=1)
s0.LatestMessage
end
while (strcmp(odom.LatestMessage.ChildFrameId,'robot0')~=1)
odom.LatestMessage
end
%%Introducimos la orientacion del sonar (rad)
orientacion_s = 1.5708;
%%Introducimos punto de emision del sonar respecto al centro del amigobot
 posicion_s = [0.076;
                0.1];
%%Datos para calcular posicion y rotacion
pos = odom.LatestMessage.Pose.Pose.Position;
rot = odom.LatestMessage.Pose.Pose.Orientation;
%Calculo la rotación
quaternion=[rot.W rot.X rot.Y rot.Z];
euler=quat2eul(quaternion,'ZYX');
rotacion=euler(1);
%%Datos para calcular la distancia min(en el eje de orientacion del sensor)
amplitud_vision = 0.261799, %rad
angulo_calc = amplitud_vision/2; %rad
dist = 0.0;
dist_min = 0.0;
supp = 0.0; %superficie de choque posible
%%Datos para gráfica (puntos laterales y punta)
x_grafica = zeros(1000,3);
y_grafica = zeros(1000,3);
%Recogemos datos de dist
distancias_s = zeros(1000);
%%Reconocimiento táctico
for i = 1:1000
    disp(i);
    dist = s0.LatestMessage.Range_;
    distancias_s(i) = dist;
    dist_min = cos(angulo_calc)*dist; %distancia min
    supp = (sin(angulo_calc)*dist)*2; %sup de choque min
    %%Guardamos puntos para después dibujar gráfica
    coordenadasCompletas = posicionFinal(dist,pos,rotacion,orientacion_s,posicion_s,1);
    x_grafica(i,1) = coordenadasCompletas(1);
    y_grafica(i,1) = coordenadasCompletas(2);
    x_grafica(i,2) = coordenadasCompletas(3);
    y_grafica(i,2) = coordenadasCompletas(4);
    %PUNTA
    x_grafica(i,3) = coordenadasCompletas(5);
    y_grafica(i,3) = coordenadasCompletas(6);
end
%%Grafica
figure
plot(x_grafica,y_grafica,'co','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Medidas Sonar');
for i = 1:1000
    d = ['Medida: ',num2str(i),' : ',num2str(distancias_s(i)),' m '];
    disp(d);
end
d = ['Posicion: X:',num2str(pos.X),' Y: ',num2str(pos.Y),' Orientacion: ',num2str(rotacion)];
disp(d);
%Media movil
sum_ventana_movil = 0.0;
for i = 1:5
    sum_ventana_movil = sum_ventana_movil + distancias_s(994 + i);
end
media_ventana_movil = sum_ventana_movil / 5;
m = ['Posicion: X:',num2str(pos.X),' Y: ',num2str(pos.Y),' Orientacion: ',num2str(rotacion)];
disp(m);