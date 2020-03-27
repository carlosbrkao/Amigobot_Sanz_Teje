function muros = muros(puntosX,puntosY,distancias)
    %Datos
    paredes = [false,false,false,false] %Delante / Dcha / Atrás / Izq
    estadoPared = 0;
    paredess = 0;
    puntosXposibles = zeros(length(puntosX));
    puntosYposibles = zeros(length(puntosY));
    posibles_s = zeros(length(distancias));
    %Bucle para estudiar puntos y quedarnos con los que nos interesan
    for i = 1:8
        disp(distancias(i));
        %Para considerar pared aludimos a que este a menos de 2m (error +-2cm)
        if(distancias(i) <= 2.02)
            %Si cumple la condicion recabamos la info de sus puntos
            posibles_s(i) = 1;
            if(i~=1)
                auxj = (i-1)*3+1;
                for j = auxj:auxj+2
                    puntosXposibles(j) = puntosX(j);
                    puntosYposibles(j) = puntosY(j);
                end
            else
                for j = 1:3
                    puntosXposibles(j) = puntosX(j);
                    puntosYposibles(j) = puntosY(j);
                end
            end
        end
        %Si no la cumple no nos importa su vida
    end
    %Evaluamos casos
    %Delante
    if(posibles_s(2) == 0 || posibles_s(3) == 0 || posibles_s(4) == 0 || posibles_s(5) == 0)
        paredes(1) = false;
    else
        paredes(1) = true;
        paredess = paredess + 1000;
    end
    %Dcha
    if(posibles_s(6) == 0)
        paredes(2) = false;
    else
        paredes(2) = true;
        paredess = paredess + 100;
    end
    %Atrás
    if(posibles_s(7) == 0 || posibles_s(8) == 0)
        paredes(3) = false;
    else
        paredes(3) = true;
        paredess = paredess + 10;
    end
    %Izq
    if(posibles_s(1) == 0)
        paredes(4) = false;
    else
        paredes(4) = true;
        paredess = paredess + 1;
    end
    disp Array_booleanos;
    disp(paredes);
    if(paredess == 1000)
        estadoPared = 1; 
    end
    if(paredess == 100)
        estadoPared = 2; 
    end
    if(paredess == 10)
        estadoPared = 3; 
    end
    if(paredess == 1)
        estadoPared = 4; 
    end
    if(paredess == 1100)
        estadoPared = 5; 
    end
    if(paredess == 1010)
        estadoPared = 6;
    end
    if(paredess == 1001)
        estadoPared = 7;
    end
    if(paredess == 110) 
        estadoPared = 8;
    end
    if(paredess == 101)
        estadoPared = 9; 
    end
    if(paredess == 11)
        estadoPared = 10;
    end
    if(paredess == 1110)
        estadoPared = 11;
    end
    if(paredess == 111)
        estadoPared = 12; 
    end
    if(paredess == 1011)
        estadoPared = 13;
    end
    if(paredess == 1101)
        estadoPared = 14;
    end
    if(paredess == 1111) 
        estadoPared = 15;
    end
    %Salida
    muros = estadoPared;