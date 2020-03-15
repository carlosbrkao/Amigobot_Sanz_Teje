
%% CALCULO RESOLUCION MINIMA LINEAL
disp("Resolucion minima(m) ");
res=99999999;
i = 1;
%Recorremos las variables globales que contienen los datos recogidos,
%restando las medidas dos a dos para quedarnos con la resolucion  minima
while(i<posicion)
    a = datosLin(i+1)-datosLin(i);
    if(a<res)
        res = a;
    end
    i=i+1;
end
disp(res + " m");

%% CALCULO RESOLUCION MINIMA ANGULAR
disp("Resolucion minima(rad) ");
res=99999999;
i = 1;
%Recorremos las variables globales que contienen los datos recogidos,
%restando las medidas dos a dos para quedarnos con la resolucion  minima
while(i<posicion)
    a = datosAn(i+1)-datosAn(i);
    
    if(a<0)
        a = a*-1;
    end
    if(a<res)
        res = a;
    end
    i=i+1;
end
disp(res + " rad");

%% LIMPIEZA DE VARIABLES GLOBALES
clearvars;
