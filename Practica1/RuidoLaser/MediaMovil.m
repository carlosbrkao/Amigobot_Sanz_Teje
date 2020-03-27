%% ABRIMOS LA GRAFICA CON LAS MEDIDAS Y GUARDAMOS LAS MISMAS EN UN ARRAY
openfig('ruidoLaserSimulacion.fig','invisible'); 
Datos = get(gca,'Children');
Muestras = get(Datos,'XData');

%% CANTIDAD DE MUESTRAS
cantMuestras = length(Muestras);

%% Creamos le array de la media movil
mediaMov = zeros(1,cantMuestras/5);

a=1;
b=1;
%% Rellenamos las medidas de la media movil
while(b<(cantMuestras/5)+1)
    c=0;
    suma = 0;
    while(c<5)
        suma = suma + Muestras(a);
        c = c + 1;
        a = a + 1;
    end
    suma = suma/5;
    mediaMov(b) = suma;
    b = b + 1;
end

%% Mostramos ambas figuras el grafico sin media movil y el grafico con media movil
figure
plot(0,mediaMov,'-o','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Medidas del sonar_0(Media_Movil)'); 

figure
plot(0,Muestras,'-o','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Medidas del sonar_0(Normal)'); 