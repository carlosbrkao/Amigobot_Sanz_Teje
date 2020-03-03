function pared = laser_p2(angMin,angInc,cuarto,dist)

    cantRayos = 20; %Franja de rayos a medir
    tolerancia = 0.01; % Tolerancia en metros a la hora de medir
    posiblesErrores = 4; % Medidas erroneas permitidas
    distanciaMax = 2;%Distancia maxima a una pared en m
    
    
    datos = zeros(1,cantRayos);
    
    angulo = angMin + (angInc*((2*cuarto)-(cantRayos/2)));
    pos = (2*cuarto)-(cantRayos/2);
    a=1;
    while(a<(cantRayos+1))
        
            X = cos(angulo)*dist(pos);
            Y = sin(angulo)*dist(pos);
        if(X<distanciaMax) && (X>-distanciaMax) 
            if(Y<distanciaMax)&&(Y>-distanciaMax)
                datos(a)=X;
            end
        end
        angulo = angulo + angInc;
        a = a + 1 ;
        pos = pos +1 ;
    end
    


    contError = 0;
    inicial = datos(cantRayos/2);
    pared = true;
    
        a = 1 ;
    while(a<(cantRayos+1))
        if(datos(a)==0)
            contError = contError + 1;
        else
            if((datos(a)>(inicial + tolerancia)) || (datos(a)<(inicial  - tolerancia)))
                contError = contError + 1;
            end
        end
        a = a + 1;
    end
    
    if(contError > posiblesErrores)
        pared = false;
    end