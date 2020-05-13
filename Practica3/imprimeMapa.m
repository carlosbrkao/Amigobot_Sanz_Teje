function imprimeMapa(lista,filas,columnas)

for i = 1:filas+1
    concatenacion = "";
    for j = 1:columnas+1
        if(mod(i,2) == 1 && mod(j,2) == 1)
                concatenacion = strcat(concatenacion,'+     ');
        else
           switch lista(i,j)
               case 0
                    concatenacion = strcat(concatenacion,'?     ');
               case 1
                    concatenacion = strcat(concatenacion,'C     ');
               case 2
                    concatenacion = strcat(concatenacion,'V     ');
               case 3
                    concatenacion = strcat(concatenacion,'P     ');
            end
        end
    end
    disp (concatenacion);
end