%% Función para calcular la posicion de los puntos en el plano que hemos considerado para cubrir el haz de ultrasonidos
%% tomar en cuenta 3 puntos considerando, el extremo izquierdo del haz, el extremo derecho y el punto central del haz
function posicionFinal = posicionFinal(dist,posicion,rotacion,orientacion_s,posiciones_s,i) 
    %% Variables
    amplitud_vision = 0.261799; %rad
    angulo_calc = amplitud_vision/2; %rad
    x1 = 0.0;
    y1 = 0.0;
    x2 = 0.0;
    y2 = 0.0;
    xp = 0.0;
    yp = 0.0;
    %% Calculo de la orientacion
    angulo_1 = rotacion + orientacion_s - angulo_calc; %Extremo izq
    angulo_2 = rotacion + orientacion_s + angulo_calc; %Extremo dch
    angulo_p = rotacion + orientacion_s; %Centro/punta
    %% Calculo de x1 e y1
    if(angulo_1 < 0)
        angulo_1 = angulo_1 + 2*pi;
    end
    if(angulo_1 <= pi/2)
        x1 = cos(angulo_1)*dist + posicion.X + posiciones_s(1,i);
        y1 = sin(angulo_1)*dist + posicion.Y + posiciones_s(2,i);
    end
    if(angulo_1 > pi/2 && angulo_1 <= pi)
        angulo_1 = pi - angulo_1;
        x1 = -cos(angulo_1)*dist + posicion.X + posiciones_s(1,i);
        y1 = sin(angulo_1)*dist + posicion.Y + posiciones_s(2,i);
    end
    if(angulo_1 > pi && angulo_1 <= (3*pi)/2)
        angulo_1 = angulo_1 - pi;
        x1 = -cos(angulo_1)*dist + posicion.X + posiciones_s(1,i);
        y1 = -sin(angulo_1)*dist + posicion.Y + posiciones_s(2,i);
    end
    if(angulo_1 > (3*pi)/2)
        angulo_1 = 2*pi - angulo_1;
        x1 = cos(angulo_1)*dist + posicion.X + posiciones_s(1,i);
        y1 = -sin(angulo_1)*dist + posicion.Y + posiciones_s(2,i);
    end
    %% Calculo de x2 e y2
    if(angulo_2 < 0)
        angulo_2 = angulo_2 + 2*pi;
    end
    if(angulo_2 <= pi/2)
        x2 = cos(angulo_2)*dist + posicion.X + posiciones_s(1,i);
        y2 = sin(angulo_2)*dist + posicion.Y + posiciones_s(2,i);
    end
    if(angulo_2 > pi/2 && angulo_2 <= pi)
        angulo_2 = pi - angulo_2;
        x2 = -cos(angulo_2)*dist + posicion.X + posiciones_s(1,i);
        y2 = sin(angulo_2)*dist + posicion.Y + posiciones_s(2,i);
    end
    if(angulo_2 > pi && angulo_2 <= (3*pi)/2)
        angulo_2 = angulo_2 - pi;
        x2 = -cos(angulo_2)*dist + posicion.X + posiciones_s(1,i);
        y2 = -sin(angulo_2)*dist + posicion.Y + posiciones_s(2,i);
    end
    if(angulo_2 > (3*pi)/2)
        angulo_2 = 2*pi - angulo_2;
        x2 = cos(angulo_2)*dist + posicion.X + posiciones_s(1,i);
        y2 = -sin(angulo_2)*dist + posicion.Y + posiciones_s(2,i);
    end
    %% Calculo de xp e yp
    if(angulo_p < 0)
        angulo_p = angulo_p + 2*pi;
    end
    if(angulo_p <= pi/2)
        xp = cos(angulo_p)*dist + posicion.X + posiciones_s(1,i);
        yp = sin(angulo_p)*dist + posicion.Y + posiciones_s(2,i);
    end
    if(angulo_p > pi/2 && angulo_p <= pi)
        angulo_p = pi - angulo_p;
        xp = -cos(angulo_p)*dist + posicion.X + posiciones_s(1,i);
        yp = sin(angulo_p)*dist + posicion.Y + posiciones_s(2,i);
    end
    if(angulo_p > pi && angulo_p <= (3*pi)/2)
        angulo_p = angulo_p - pi;
        xp = -cos(angulo_p)*dist + posicion.X + posiciones_s(1,i);
        yp = -sin(angulo_p)*dist + posicion.Y + posiciones_s(2,i);
    end
    if(angulo_p > (3*pi)/2)
        angulo_p = 2*pi - angulo_p;
        xp = cos(angulo_p)*dist + posicion.X + posiciones_s(1,i);
        yp = -sin(angulo_p)*dist + posicion.Y + posiciones_s(2,i);
    end
    %% Salida
    posicionFinal = [x1,y1,x2,y2,xp,yp];
    
    