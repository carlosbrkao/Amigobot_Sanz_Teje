function pared = laser_p3(angMin,angInc,cuarto,dist)

    datosX = zeros(1,20);
    datosY = zeros(1,20);
    a=1;
    
    
    angulo = angMin + (cuarto-10)*angInc;
    pos = cuarto -10;
    while(a<21)
        
            X = cos(angulo)*dist(pos);
            Y = sin(angulo)*dist(pos);
        if(X<2) && (X>-2) 
            if(Y<2)&&(Y>-2)
                datosX(a)=X;
                datosY(a)=Y;
            end
        end
        angulo = angulo + angInc;
        a = a + 1 ;
        pos = pos + 1;
    end
    
    a = 1 ;
    

    contCeros = 0;
    Xinicial = datosX(10);
    Yinicial = datosY(10);
    Xmal = false;
    Ymal = false;
    while(a<21)
        if(datosX(a)==0)
            contCeros = contCeros + 1;
        end
        if(datosX(a)~=0)
            if((datosX(a)>(Xinicial +0.1))|| (datosX(a)<(Xinicial  -0.1)))
                Xmal = true;
                break;
            end
        end
        a = a + 1;
    end
    a = 1 ;
    while(a<21)
        if(datosY(a)==0)
            contCeros = contCeros + 1;
        end
        if(datosY(a)~=0)
            if((datosY(a)>(Yinicial +0.1))|| (datosY(a)<(Yinicial  -0.1)))
                Ymal = true;
                break;
            end
        end
        a = a + 1;
    end
    
    if(contCeros/2 > 2)
        pared = false;
    else
        if(Ymal && Xmal)
            pared = false;
        else
            pared = true;
        end
    end
    


