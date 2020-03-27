%% Función que nos permite conocer el número de paredes que rodean al robot, estando este en el interior de una 
%% casilla de 2m por 2m, devolviendo un código correspondiendo con la combinación de paredes en la casilla
function c_paredes = paredes_p1_6(puntosX,puntosY,distancias)
    %% Datos
    estadoPared = 0;
    paredess = 0;
    posibles_s = zeros(length(distancias));
    %% Bucle para estudiar puntos y quedarnos con los que nos interesan
    for i = 1:8
        %% Para considerar pared aludimos a que este a menos de 2m (error +-6cm)
        if(distancias(i) <= 2.02)
            %% Si cumple la condicion lo marcamos en un array que indica cuales sonares pueden haber detectado una pared
            posibles_s(i) = 1;
        end
    end
    %% Evaluamos casos
    %% Delante: Consideramos que hay pared si los puntos de los sonares más cercanos al eje X (sonar_2 y sonar_3)
    %%          sus coordenadas sobre este eje es igual o aproximado teniendo en cuenta un error de 
    %%          +- 6cm
    if(posibles_s(3) == 1 && posibles_s(4) == 1)
        puntoI3 = puntosX(3,2);
        puntoI4 = puntosX(4,1);
        %% En caso de que las coordenadas indiquen que es posible la existencia de pared, lo indicamos en la variable
        %% paredess añadiendo el código propuesto para la pared delantera (1000)
        if(((puntoI3 - 0.02) <= puntoI4) && ((puntoI3 + 0.02) >= puntoI4))
            paredess = paredess + 1000;
        end
    end
    %% Dcha: Consideramos que hay pared si el sonar asociado a este lado (sonar_5) cumple la condición de contacto a menos de 2m
    %%       En caso de que las coordenadas indiquen que es posible la existencia de pared, lo identificamos en la variable
    %%       paredess añadiendo el código propuesto para la pared inferior (100)
    if(posibles_s(6) == 1)
        paredess = paredess + 100;
    end
    %% Atrás: Consideramos que hay pared si los puntos de los sonares más cercanos al eje X (sonar_6 y sonar_7)
    %%        sus coordenadas sobre este eje de es igual o aproximado teniendo en cuenta un error de 
    %%        +- 6cm
    if(posibles_s(7) == 1 && posibles_s(8) == 1)
        puntoI7 = puntosX(7,2);
        puntoI8 = puntosX(8,1);
        %% En caso de que las coordenadas indiquen que es posible la existencia de pared, lo indicamos en la variable
        %% paredess añadiendo el código propuesto para la pared delantera (10)
        if(((puntoI7 - 0.06) <= puntoI8) && ((puntoI7 + 0.06) >= puntoI8))
            paredess = paredess + 10;
        end
    end
    %% Izq: Consideramos que hay pared si el sonar asociado a este lado (sonar_0) cumple la condición de contacto a menos de 2m
    %%       En caso de que las coordenadas indiquen que es posible la existencia de pared, lo identificamos en la variable
    %%       paredess añadiendo el código propuesto para la pared inferior (1)
    if(posibles_s(1) == 1)
        paredess = paredess + 1;
    end
    %% Codificacion del número de paredes en función del número de paredes reconocido
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
    %% Salida
    c_paredes = estadoPared;