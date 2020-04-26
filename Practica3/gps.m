function rutas = gps(casillas)

%% A PARTIR DEL TIPO DE CASILLAS INTERPRETAMOS LOS CAMINOS POSIBLES
%   [RECTO / DERECHA / ATRAS / IZQUIERDA]
switch casillas
    case 0
        rutas = [1,1,1,1];
    case 1
        rutas = [0,1,1,1];
    case 2
        rutas = [1,0,1,1];
    case 3
        rutas = [1,1,0,1];
    case 4
        rutas = [1,1,1,0];
    case 5
        rutas = [0,0,1,1];
    case 6
        rutas = [0,1,0,1];
    case 7 
        rutas = [0,1,1,0];
    case 8
        rutas = [1,0,0,1];
    case 9 
        rutas = [1,0,1,0];
    case 10
        rutas = [1,1,0,0];
    case 11
        rutas = [0,0,0,1];
    case 12
        rutas = [1,0,0,0];
    case 13
        rutas = [0,1,0,0];
    case 14
        rutas = [0,0,1,0];
    otherwise
        rutas = [0,0,0,0];
end
    