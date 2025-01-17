%% Indicamos la gr�fica con los datos a los que les calcuraremos el ruido
openfig('sonar_1000_amigobot.fig','invisible'); 
Datos = get(gca,'Children');
Muestras = get(Datos,'YData');

%% CANTIDAD DE MUESTRAS
cantMuestras = length(Muestras);


max = 0;
media = 0;
MuestrasRuido = 0;
ruidos = zeros(1,cantMuestras);

%% Calculamos la diferencia de las medidas con la medida que deberia ser(2 m) 
a =1;
while(a<(cantMuestras+1))
    if((Muestras(a))<2)
        ruido = (Muestras(a)-2)*(-1);
        ruidos(a)=ruido;
    else
        ruidos(a)=Muestras(a)-2;
    end
    a = a+1;
end

%% Calculamos el ruido medio y maximo gracias al array de ruidos que hemos creado
a = 1;
while(a<(cantMuestras+1))
    if(ruidos(a)>0)
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


%% Caluclamos la varianza del ruido mediante el array que hemos creado
sumatorio = 0;
a=1;
varianza = 0;
while(a<(cantMuestras+1))
    if(ruidos(a)>0)
        sumatorio =((ruidos(a)- media)^2);
    end
    varianza = varianza + sumatorio;
    a = a + 1;   
end

varianza = varianza/(MuestrasRuido-1);
disp("La varianza del ruido es: " + varianza +"m2");

