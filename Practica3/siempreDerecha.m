%% SiempreDerecha

function casilla = siempreDerecha(laser,angulo,odom,posiblesRutas,filas,columnas)

            pos=odom.LatestMessage.Pose.Pose.Position;
                
            cuarto = 100;
            format long 
            inc = laser.LatestMessage.AngleIncrement; %Incremento del angulo en cada rayo
            dist = laser.LatestMessage.Ranges;        %Array de distancias
            angulo_min = laser.LatestMessage.AngleMin;%Angulo minimo en rad

            p1 = laser_p1(angulo_min,inc,cuarto,dist); %izq
            p2 = laser_p2(angulo_min,inc,cuarto,dist); %centro
            p3 = laser_p3(angulo_min,inc,cuarto,dist); %dcha

            % DECODIFICADOR
            if(luzAlFinalDelTunel(posiblesRutas))
                if(angulo == 0)
                    if((round(pos.X) + 3) > columnas+1)
                        p2 = 1;
                    end
                    if((round(pos.Y) + 3) > filas+1)
                        p1 = 1;
                    end
                    if((round(pos.Y) - 3) < 0)
                        p3 = 1;
                    end
                elseif(angulo == 90)
                    if((round(pos.X) + 3) > columnas+1)
                        p3 = 1;
                    end
                    if((round(pos.Y) + 3) > filas+1)
                        p2 = 1;
                    end
                    if((round(pos.X) - 3)<0)
                        p1 = 1;
                    end
                elseif(angulo == 180)
                    if((round(pos.Y) + 3) > filas+1)
                        p3 = 1;
                    end
                    if((round(pos.X) - 3)<0)
                        p2 = 1;
                    end
                    if((round(pos.Y) - 3) < 0)
                        p1 = 1;
                    end
                elseif(angulo == -90)
                    if((round(pos.X) + 3) > columnas+1)
                        p1 = 1;
                    end
                    if((round(pos.X) - 3)<0)
                        p3 = 1;
                    end
                    if((round(pos.Y) - 3) < 0)
                        p2 = 1;
                    end
                end
            end
            if(~p1)&&(p2)&&(p3)
                giro = 90;%+90
            elseif(p1)&&(p2)&&(p3)
                giro = 180;%+180
            elseif(~p2)&&(p3)
                giro = 0;%+0
            elseif(~p3)
                 giro = -90;% -90
            end
            
    % Obtenemos las coordenadas de la casilla actua
    casillaX = round(pos.X);
    casillaY = round(pos.Y);
    
    angulo = angulo + giro;
    
    if(angulo>350) 
        angulo = 0;
    elseif(angulo>250) 
        angulo = -90; 
    elseif(angulo<-350)
        angulo = 0;
    elseif(angulo<-250)
        angulo = 90;
    elseif(angulo<-170)
        angulo = 180;
    end
    
    if(angulo == 0)
        xDestino = casillaX + 2;
        yDestino = casillaY;
    elseif(angulo == 90)
        xDestino = casillaX;
        yDestino = casillaY+2;
    elseif(angulo == 180)
        xDestino = casillaX - 2;
        yDestino = casillaY;
    elseif(angulo == -90)
        xDestino = casillaX;
        yDestino = casillaY-2;
    end
    
    casilla = zeros(0,2);
    casilla(1) = xDestino;
    casilla(2) = yDestino;
    
            
            
            
            
            