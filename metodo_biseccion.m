function [raiz, n_iter, historial] = metodo_biseccion(f, a, b, tol, max_iter)
if f(a)*f(b) > 0
    error('f(a) y f(b) deben tener signos opuestos. No se garantiza una raiz en [a,b].');
end

historial = [];
c_anterior = a;

for iter = 1:max_iter
  
    c = (a + b) / 2;

    error_actual = abs(c - c_anterior);
    historial = [historial; iter, a, b, c, f(c), error_actual];
    
    if abs(f(c)) < tol || error_actual < tol
        raiz   = c;
        n_iter = iter;
        return;  
    end

    if f(a)*f(c) < 0
        b = c;
    else
        a = c;
    end

    c_anterior = c;
end

raiz   = c;
n_iter = max_iter;
warning('Se alcanzo el numero maximo de iteraciones sin llegar a la tolerancia pedida.');
end