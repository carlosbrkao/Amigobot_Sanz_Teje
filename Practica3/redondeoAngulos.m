%% REDONDEO DEL ANGULO 

function angulo = redondeoAngulos(rotacion)

angulos = [0,90,180,-90];
angulo = round((rotacion * 180)/pi);
for i = 1:4
    if(i == 3)
       if((abs(angulo) - angulos(i))<5 && (abs(angulo) - angulos(i)>-5))  
           angulo = angulos(i);
           i = 4; 
       end     
    else
       if((angulo - angulos(i))<5 && (angulo - angulos(i)>-5))  
           angulo = angulos(i);
           i = 4; 
       end
    end
end