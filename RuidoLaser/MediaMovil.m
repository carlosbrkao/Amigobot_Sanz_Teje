openfig('1000_laser_real.fig','invisible'); 
Datos = get(gca,'Children');
Muestras = get(Datos,'XData');
cantMuestras = length(Muestras);


mediaMov = zeros(1,cantMuestras/5);

a=1;
b=1;
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

figure
plot(0,mediaMov,'-o','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Medidas del sonar_0(Media_Movil)'); 

figure
plot(0,Muestras,'-o','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Medidas del sonar_0(Normal)'); 