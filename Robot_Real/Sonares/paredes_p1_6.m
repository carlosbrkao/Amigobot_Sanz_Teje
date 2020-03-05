function c_paredes = paredes_p1_6(puntosX,puntosY,distancias)
    %Datos
    estadoPared = 0;
    paredess = 0;
    posibles_s = zeros(length(distancias));
    %Bucle para estudiar puntos y quedarnos con los que nos interesan
    for i = 1:8
        disp(distancias(i));
        %Para considerar pared aludimos a que este a menos de 2m (error +-2cm)
        if(distancias(i) <= 2.02)
            %Si cumple la condicion recabamos la info de sus puntos
            posibles_s(i) = 1;
        end
        %Si no la cumple no nos importa su vida
    end
    %Evaluamos casos
    %Delante------------------------------------------------------------
%     if(posibles_s(2) == 1 && posibles_s(3) == 1 && posibles_s(4) == 1 && posibles_s(5) == 1)
%         puntoI2 = puntosX(2,1);
%         puntoI3 = puntosX(3,1);
%         puntoI4 = puntosX(4,2);
%         puntoI5 = puntosX(5,2);
%         disp puntosDelante;
%         s = ['p2: ',num2str(puntoI2),' p3: ',num2str(puntoI3),' p4: ',num2str(puntoI4),' p5: ',num2str(puntoI5)];
%         disp(s);
%         if((((puntoI2 - 0.02) <= puntoI5) && ((puntoI2 + 0.12) >= puntoI5)) && (((puntoI3 - 0.02) <= puntoI4) && ((puntoI3 + 0.12) >= puntoI4)))
%             paredess = paredess + 1000;
%         end
%     end
    if(posibles_s(3) == 1 && posibles_s(4) == 1)
        puntoI3 = puntosX(3,1);
        puntoI4 = puntosX(4,2);
        disp puntosDelante;
        s = ['p3: ',num2str(puntoI3),' p4: ',num2str(puntoI4)];
        disp(s);
        if(((puntoI3 - 0.02) <= puntoI4) && ((puntoI3 + 0.02) >= puntoI4))
            paredess = paredess + 1000;
        end
    end
    %Dcha---------------------------------------------------------
    if(posibles_s(6) == 1)
        paredess = paredess + 100;
    end
    %Atrás---------------------------------------------------------
    if(posibles_s(7) == 1 && posibles_s(8) == 1)
        puntoI7 = puntosX(7,1);
        puntoI8 = puntosX(8,2);
        disp puntosDetras;
        s = ['p7: ',num2str(puntoI7),' p8: ',num2str(puntoI8)];
        disp(s);
        if(((puntoI7 - 0.02) <= puntoI8) && ((puntoI7 + 0.02) >= puntoI8))
            paredess = paredess + 10;
        end
    end
    %Izq---------------------------------------------------------------
    if(posibles_s(1) == 1)
        paredess = paredess + 1;
    end
    %Codificacion del número de paredes
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
    c_paredes = estadoPared;