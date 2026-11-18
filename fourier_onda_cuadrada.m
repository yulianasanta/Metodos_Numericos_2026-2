function y = fourier_onda_cuadrada(t, n_terminos, amplitud)

    omega = 1;  

    % 1) Calcular la salida principal "y" pedida por la funcion
    y = zeros(size(t));
    for n = 1:2:n_terminos
        y = y + sin(n*omega*t)/n;
    end
    y = (4*amplitud/pi) * y;

    % 2) Comparacion visual con 3, 7 y 15 terminos
    terminos_comparar = [3, 7, 15];
    ideal = amplitud * sign(sin(omega*t));

    figure;
    for i = 1:length(terminos_comparar)
        N = terminos_comparar(i);

        y_aprox = zeros(size(t));
        for n = 1:2:N
            y_aprox = y_aprox + sin(n*omega*t)/n;
        end
        y_aprox = (4*amplitud/pi) * y_aprox;

        % Error RMS: que tan lejos esta, en promedio, la aproximacion
        % de la onda cuadrada ideal.
        error_rms = sqrt(mean((y_aprox - ideal).^2));

        subplot(3,1,i);
        plot(t, ideal, 'r--', 'LineWidth', 1); hold on;
        plot(t, y_aprox, 'b-', 'LineWidth', 1.5); hold off;
        title(sprintf('N = %d terminos | Error RMS = %.4f', N, error_rms));
        xlabel('t (s)');
        ylabel('Amplitud');
        legend('Onda cuadrada ideal', 'Aproximacion de Fourier', 'Location', 'best');
        grid on;
    end
end