openfig('1000_laser_real','invisible'); 
Datos = get(gca,'Children');
Muestras = get(Datos,'XData');

cantMuestras = length(Muestras);


max = 0;
media = 0;
MuestrasRuido = 0;
ruidos = zeros(1,cantMuestras);

a =1;
while(a<(cantMuestras+1))
    if((Muestras(a))>-2)
        ruido = (Muestras(a)+2);
        ruidos(a)=ruido;
    else
        ruidos(a)=(Muestras(a)+2)*(-1);
    end
    disp(ruidos(a));
    a = a+1;
end

a = 1;
while(a<(cantMuestras+1))
    if(ruidos(a)>0 && ruidos(a)<1)
        if(ruidos(a)>max)
            max = ruidos(a);
        end
        media = media + ruidos(a);
        MuestrasRuido = MuestrasRuido + 1;
    end
    a = a + 1;   
end
media = media/MuestrasRuido;

disp("El valor maximo del ruido es: " + max + "m");
disp("El valor medio del ruido es: " + media + "m");


sumatorio = 0;
a=1;
varianza = 0;
while(a<(cantMuestras+1))
    if(ruidos(a)>0 && ruidos(a)<1)
        sumatorio =((ruidos(a)- media)^2);
    end
    varianza = varianza + sumatorio;
    a = a + 1;   
end

varianza = varianza/(MuestrasRuido-1);
disp("La varianza del ruido es: " + varianza +"m2");

