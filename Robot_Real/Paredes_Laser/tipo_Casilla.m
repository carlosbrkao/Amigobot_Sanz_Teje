%% Función que valora el resultado de la combinación de paredes detectadas y devuelve el código
%% asignado al número de paredes del entorno de la casilla
function tipo = tipo_Casilla(p1,p2,P3,P4)

    if(~p1)&&(~p2)&&(~P3)&&(~P4) 
        tipo = 0;
    elseif(~p1)&&(p2)&&(~P3)&&(~P4) 
        tipo = 1;
    elseif(~p1)&&(~p2)&&(P3)&&(~P4) 
        tipo = 2;
    elseif(~p1)&&(~p2)&&(~P3)&&(P4) 
        tipo = 3;
    elseif(p1)&&(~p2)&&(~P3)&&(~P4) 
        tipo = 4;
    elseif(~p1)&&(p2)&&(P3)&&(~P4) 
        tipo = 5;
    elseif(~p1)&&(p2)&&(~P3)&&(P4) 
        tipo = 6;
    elseif(p1)&&(p2)&&(~P3)&&(~P4) 
        tipo = 7;
    elseif(~p1)&&(~p2)&&(P3)&&(P4) 
        tipo = 8;
    elseif(p1)&&(~p2)&&(P3)&&(~P4) 
        tipo = 9;
    elseif(p1)&&(~p2)&&(~P3)&&(P4) 
        tipo = 10;
    elseif(~p1)&&(p2)&&(P3)&&(P4) 
        tipo = 11;
    elseif(p1)&&(~p2)&&(P3)&&(P4) 
        tipo = 12;
    elseif(p1)&&(p2)&&(~P3)&&(P4) 
        tipo = 13;
    elseif(p1)&&(p2)&&(P3)&&(~P4) 
        tipo = 14;
    elseif(p1)&&(p2)&&(P3)&&(P4) 
        tipo = 15;
    end