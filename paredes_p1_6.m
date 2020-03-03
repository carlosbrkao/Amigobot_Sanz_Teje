function c_paredes = c_paredes(puntosX,puntosY,distancias)
    %Datos
    paredes = 0 %Delante / Dcha / Atrás / Izq (1Activo /0No hay)
    c_paredes = 0;
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
    
    %Salida
    muros = estadoPared;