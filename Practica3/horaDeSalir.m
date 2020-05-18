%% FUNCIÓN PARA COMPROBAR EN QUE MOMENTO PODEMOS SALIR DEL MAPA TRAS EL MAPEAMIENTO COMPLETO

function salir = horaDeSalir(mapa,filas,columnas)

% INDICE: 0 = no visitada // 1 = visitada // 2 = libre // 3 = pared
salir = true;
for i = 2:2:columnas + 1
    for j = 2:2:filas + 1
        if(mapa(j,i) == 1)
            salir = true;
        else
            salir = false;
            break;
        end
    end
    if(~salir)
        break;
    end
end