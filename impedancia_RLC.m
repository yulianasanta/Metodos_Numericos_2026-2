function [Z_mag, fase, tabla] = impedancia_RLC(R, L, C, f_fund, n_arm)

% 1) Calcular Z y fase para cada armonico k = 1, 2, ..., n_arm
armonico   = (1:n_arm)';          % numero de cada armonico: 1,2,3,...
frecuencia = armonico * f_fund;   % la frecuencia real de cada armonico

Z_mag = zeros(n_arm,1);
fase  = zeros(n_arm,1);

for k = 1:n_arm
    f_k = frecuencia(k);                       % frecuencia de este armonico
    XL  = 2*pi*f_k*L;                           % reactancia inductiva
    XC  = 1/(2*pi*f_k*C);                        % reactancia capacitiva

    Z_mag(k) = sqrt(R^2 + (XL - XC)^2);          % magnitud de la impedancia
    fase(k)  = atan2(XL - XC, R) * (180/pi);     % desfase, convertido a grados
end

% ---- 2) Armar la tabla resumen ----
tabla = table(armonico, frecuencia, Z_mag, fase, 'VariableNames', {'Armonico', 'Frecuencia_Hz', 'Z_ohm', 'Fase_grados'});

disp(tabla);

% ---- 3) Graficas de magnitud y fase vs numero de armonico ----
figure;

subplot(2,1,1);
stem(armonico, Z_mag, 'filled');
xlabel('Numero de armonico');
ylabel('|Z| (\Omega)');
title('Magnitud de la impedancia por armonico');
grid on;

subplot(2,1,2);
stem(armonico, fase, 'filled');
xlabel('Numero de armonico');
ylabel('Fase (grados)');
title('Desfase por armonico');
grid on;

% 4) Forma de onda de voltaje con contenido armonico
t = linspace(0, 3/f_fund, 2000);   % suficiente tiempo para ver 3 periodos
v = zeros(size(t));
for k = 1:n_arm
    f_k = frecuencia(k);
    v = v + sin(2*pi*f_k*t + deg2rad(fase(k)));
end

figure;
plot(t, v, 'b-', 'LineWidth', 1.2);
xlabel('Tiempo (s)');
ylabel('Voltaje (u.a.)');
title('Forma de onda de voltaje con contenido armonico');
grid on;
end