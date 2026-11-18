clear; clc; close all;
R = 100;
L = 1;
frec = 60;
w = 2 * pi * frec;
alpha = pi / 4;
phi = atan(w * L / R);

% Definir funcion del tiristor y su derivada
f  = @(beta) sin(beta - phi) - sin(alpha - phi) * exp(-(beta - alpha) * R / (w*L));
df = @(beta) cos(beta - phi) + sin(alpha - phi) * (R / (w*L)) * exp(-(beta - alpha) * R / (w*L));

a = alpha - 0.01;
b = pi;
tol = 1e-8;
max_iter = 100;
x0 = a;

% Aplicar los tres metodos
tic; [r1, it1] = metodo_biseccion(f, a, b, tol, max_iter);       t1 = toc;
tic; [r2, it2] = metodo_posicion_falsa(f, a, b, tol, max_iter);   t2 = toc;
tic; [r3, it3] = metodo_newton_raphson(f, df, x0, tol, max_iter); t3 = toc;

% ---- Columna de "error": que tan cerca de cero quedo f(raiz) ----
% Entre mas cerca de 0 este este valor, mas exacta es la raiz encontrada.
err1 = abs(f(r1));
err2 = abs(f(r2));
err3 = abs(f(r3));

% Mostrar tabla comparativa
metodos = {'Biseccion'; 'Posicion Falsa'; 'Newton-Raphson'};
raices  = [r1; r2; r3];
iters   = [it1; it2; it3];
errores = [err1; err2; err3];
tiempos = [t1; t2; t3];
disp(table(metodos, raices, iters, errores, tiempos, ...
    'VariableNames', {'Metodo', 'Raiz', 'Iteraciones', 'Error', 'Tiempo_s'}));

% Graficar f(beta) en [0, pi] señalando la raiz

beta_vals = linspace(0, pi, 500);
figure;
plot(beta_vals, f(beta_vals), 'b-', 'LineWidth', 1.5); hold on;
yline(0, 'k--');
plot(r1, f(r1), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
xlabel('\beta (rad)');
ylabel('f(\beta)');
title('f(\beta) en [0, \pi] y raiz encontrada');
legend('f(\beta)', 'f(\beta)=0', 'Raiz encontrada');
grid on;