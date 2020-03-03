%%MUESTRA RESOLUCION MINIMA
disp(datosLin);
disp("Resolucion minima(m) ");
res=99999999;
i = 1;
while(i<posicion)
    a = datosLin(i+1)-datosLin(i);
    if(a<res)
        res = a;
    end
    i=i+1;
end
disp(res + " m");
disp("Resolucion minima(rad) ");
res=99999999;
i = 1;
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

%%LIMPIEZA DE VARIABLES
clearvars;
