%% Adquisici�n y estudio de 1000 medidas tomadas por un sonar a 2m
%% Nos subscribimos al sonar elegido
s0=rossubscriber('/sonar_0');
%% Nos subscribimos a la odometria
odom = rossubscriber('/pose');
%% Comprobamos que recibimos informaci�n
pause(1);
while (strcmp(s0.LatestMessage.Header.FrameId,'/sonar_0')~=1)
s0.LatestMessage
end
while (strcmp(odom.LatestMessage.ChildFrameId,'base_link')~=1)
odom.LatestMessage
end
%% Introducimos la orientacion del sonar (rad)
orientacion_s = 1.5708;
%% Introducimos punto de emision del sonar respecto al centro del amigobot
 posicion_s = [0.076;
                0.1];
%% Datos para calcular posicion y rotacion
pos = odom.LatestMessage.Pose.Pose.Position;
rot = odom.LatestMessage.Pose.Pose.Orientation;
%% Calculo la rotaci�n
quaternion=[rot.W rot.X rot.Y rot.Z];
euler=quat2eul(quaternion,'ZYX');
rotacion=euler(1);
%% Datos para calcular la distancia min(en el eje de orientacion del sensor)
amplitud_vision = 0.261799; %rad
angulo_calc = amplitud_vision/2; %rad
dist = 0.0;
dist_min = 0.0;
supp = 0.0; %superficie de choque posible
%% Datos para gr�fica (puntos laterales y punta)
x_grafica = zeros(1000,3);
y_grafica = zeros(1000,3);
%% Recogemos datos de distancia
distancias_s = zeros(1000);
%% Recogemos las 1000 medidas
for i = 1:1000
    dist = s0.LatestMessage.Range_;
    distancias_s(i) = dist;
    dist_min = cos(angulo_calc)*dist; %distancia min
    supp = (sin(angulo_calc)*dist)*2; %sup de choque min
    %% Guardamos puntos para despu�s dibujar gr�fica
    coordenadasCompletas = posicionFinal(dist,pos,rotacion,orientacion_s,posicion_s,1);
    x_grafica(i,1) = coordenadasCompletas(1);
    y_grafica(i,1) = coordenadasCompletas(2);
    x_grafica(i,2) = coordenadasCompletas(3);
    y_grafica(i,2) = coordenadasCompletas(4);
    x_grafica(i,3) = coordenadasCompletas(5);
    y_grafica(i,3) = coordenadasCompletas(6);
end
%% Grafica con la informaci�n recogida y el resultado
figure
plot(x_grafica,y_grafica,'co','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Medidas Sonar');
%% Mostramos por pantalla las 1000 medidas
for i = 1:1000
    d = ['Medida: ',num2str(i),' : ',num2str(distancias_s(i)),' m '];
    disp(d);
end
d = ['Posicion: X:',num2str(pos.X),' Y: ',num2str(pos.Y),' Orientacion: ',num2str(rotacion)];
disp(d);
%% Media de las medidas tomadas, trabajamos con los puntos centrales/punta al ser el punto de choque del sonar
%% al estar paralelo a la pared
mediaX = 0.0;
mediaY = 0.0;
for i = 1:1000
    mediaX = mediaX + x_grafica(i,3);
    mediaY = mediaY + y_grafica(i,3);
end
dmedia = ['Media: X:',num2str(mediaX/1000),' Y:',num2str(mediaY/1000)];
disp(dmedia);
%% Media movil de las medidas tomadas, trabajamos con los puntos centrales/punta al ser el punto de choque del sonar
%% al estar paralelo a la pared
sum_ventana_movilX = 0.0;
sum_ventana_movilY = 0.0;
mediaMovX = zeros(1,1000/5);
mediaMovY = zeros(1,1000/5);
a=1;
b=1;
while(b<(1000/5)+1)
    c=0;
    sumaX = 0;
    sumaY = 0;
    while(c<5)
        sumaX = sumaX + x_grafica(a,3);
        sumaY = sumaY + y_grafica(a,3);
        c = c + 1;
        a = a + 1;
    end
    sumaX = sumaX/5;
    mediaMovX(b) = sumaX;
    sum_ventana_movilX = sum_ventana_movilX + sumaX;
    sumaY = sumaY/5;
    mediaMovY(b) = sumaY;
    sum_ventana_movilY = sum_ventana_movilY + sumaY;
    b = b + 1;
end
figure
plot(mediaMovX,'co','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Media Movil X');
figure
plot(mediaMovY,'co','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Media Movil Y');
m = ['Media movil: X:',num2str(sum_ventana_movilX/(1000/5)),' Y: ',num2str(sum_ventana_movilY/(1000/5))];
disp(m);