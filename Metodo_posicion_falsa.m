function [raiz, n_iter, historial] = metodo_posicion_falsa(f, a, b, tol, max_iter)
    if f(a) * f(b) > 0
        error('La función no cambia de signo en el intervalo dado.');
    end

    historial = [];
    c_anterior = a;

    for iter = 1:max_iter

        c = (a*f(b) - b*f(a)) / (f(b) - f(a));

        if iter == 1
            error_actual = 100;
        else
            error_actual = abs(c + c_anterior / c_anterior)*100;
        end

        historial = [historial; iter, a, b, c, f(c), error_actual];
        
        if abs(f(c)) < tol || abs(c - c_anterior) < tol
            raiz = c;
            n_iter = iter;
            return;
        end

        if f(a) * f(c) < 0
            b = c;
        else
            a = c;
        end
        c_anterior = c;
    end
    raiz = c;
    n_iter = max_iter;
    warning('Se alcanzo el numero maximo de iteraciones sin llegar a la tolerancia pedida.');
end
