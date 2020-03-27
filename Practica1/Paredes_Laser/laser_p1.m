%% Funci�n para considerar a partir de los datos obtenidos por los rayos, si hay pared en el lado 
%% izquierdo del robot.
function pared = laser_p1(angMin,angInc,cuarto,dist)
    %% Variables
    cantRayos = 20; %Franja de rayos a medir
    tolerancia = 0.01; % Tolerancia en metros a la hora de medir
    posiblesErrores = 4; % Medidas erroneas permitidas
    distanciaMax = 2;%Distancia maxima a una pared en m
   
    datos = zeros(1,cantRayos); %Conjunto de datos a recojer
    
    angulo = angMin + (angInc*((3*cuarto)-(cantRayos/2))); %�ngulo de orientaci�n del rayo
    pos = (3*cuarto)-(cantRayos/2);
    a=1;
    %% Recogemos los datos cercanos al eje y por el lado izquierdo del robot
    while(a<(cantRayos+1))
        
            X = cos(angulo)*dist(pos);
            Y = sin(angulo)*dist(pos);
        if(X<distanciaMax) && (X>-distanciaMax) 
            if(Y<distanciaMax)&&(Y>-distanciaMax)
                datos(a)=Y;
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
    %% Comprobamos la validez de los datos recogidos
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
    %% En caso de que haya un error superior al propuesto, no se considera la existencia de pared
    if(contError > posiblesErrores)
        pared = false;
    end
    


