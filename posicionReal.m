function posicionReal = posicionReal(dist,posicion,rotacion,orientacion_s,i)
    %%Variables
    amplitud_vision = 0.261799; %rad
    angulo_calc = amplitud_vision/2; %rad
    x1 = 0.0;
    y1 = 0.0;
    x2 = 0.0;
    y2 = 0.0;
    %%Calculo de la orientacion
    angulo_1 = rotacion + orientacion_s(i) - angulo_calc;
    angulo_2 = rotacion + orientacion_s(i) + angulo_calc;
    d1 = ['I:',num2str(i),' angulo_1_inf: ',num2str(angulo_1),' angulo_2_sup: ',num2str(angulo_2)];
    disp(d1);
    %%Calculo de x1/y1
    if(angulo_1 < 0)
        angulo_1 = angulo_1 + 2*pi;
    end
    if(angulo_1 <= pi/2)
        x1 = cos(angulo_1)*dist + posicion.X;
        y1 = sin(angulo_1)*dist + posicion.Y;
    end
    if(angulo_1 > pi/2 && angulo_1 <= pi)
        angulo_1 = pi - angulo_1;
        x1 = -cos(angulo_1)*dist + posicion.X;
        y1 = sin(angulo_1)*dist + posicion.Y;
    end
    if(angulo_1 > pi && angulo_1 <= (3*pi)/2)
        angulo_1 = angulo_1 - pi;
        x1 = -cos(angulo_1)*dist + posicion.X;
        y1 = -sin(angulo_1)*dist + posicion.Y;
    end
    if(angulo_1 > (3*pi)/2)
        angulo_1 = 2*pi - angulo_1;
        x1 = cos(angulo_1)*dist + posicion.X;
        y1 = -sin(angulo_1)*dist + posicion.Y;
    end
    d2 = ['Angulo_1: ',num2str(angulo_1),' X1: ',num2str(x1),' y1: ',num2str(y1)];
    disp(d2);
    %%Calculo de x2/y2
    if(angulo_2 < 0)
        angulo_2 = angulo_2 + 2*pi;
    end
    if(angulo_2 <= pi/2)
        x2 = cos(angulo_2)*dist + posicion.X;
        y2 = sin(angulo_2)*dist + posicion.Y;
    end
    if(angulo_2 > pi/2 && angulo_2 <= pi)
        angulo_2 = pi - angulo_2;
        x2 = -cos(angulo_2)*dist + posicion.X;
        y2 = sin(angulo_2)*dist + posicion.Y;
    end
    if(angulo_2 > pi && angulo_2 <= (3*pi)/2)
        angulo_2 = angulo_2 - pi;
        x2 = -cos(angulo_2)*dist + posicion.X;
        y2 = -sin(angulo_2)*dist + posicion.Y;
    end
    if(angulo_2 > (3*pi)/2)
        angulo_2 = 2*pi - angulo_2;
        x2 = cos(angulo_2)*dist + posicion.X;
        y2 = -sin(angulo_2)*dist + posicion.Y;
    end
    d2 = ['Angulo_2: ',num2str(angulo_2),' X2: ',num2str(x2),' y2: ',num2str(y2)];
    disp(d2);
    %figure
    %pX = [x1,x2];
    %pY = [y1,y2];
    %plot(pX,pY,'co','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
    %t = strcat('Medidas sonar',int2str(i));
    %title(t);  
    posicionReal = [x1,y1,x2,y2];
    
    