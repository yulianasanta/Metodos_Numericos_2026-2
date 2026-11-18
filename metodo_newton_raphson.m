function [raiz, n_iter, historial] = metodo_newton_raphson(f, df, x0, tol, max_iter)

    x = x0;

    historial = x;
    
    for n_iter = 1:max_iter

        x_next = x - f(x) / df(x);
        historial = [historial; x_next]; 

    if abs(x_next - x) < tol || abs(f(x)) < tol
        raiz = x_next;
        return;
    end

        x = x_next;
    end

    raiz = x;

end