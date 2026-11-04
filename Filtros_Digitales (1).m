clc;
clear;
close all;
rng(12);

%% 1. Generacion de la senal de prueba
Fs = 2000;                 % Frecuencia de muestreo (Hz)
T = 1/Fs;
t = 0:T:2-T;               % Duracion de 2 segundos

senal = sin(2*pi*50*t) + ...
        sin(2*pi*200*t) + ...
        sin(2*pi*500*t);

ruido = 0.5*randn(size(t)); % Ruido blanco gaussiano
senal_ruidosa = senal + ruido;

%% 2. Filtros IIR Butterworth de orden 4
[bLP,aLP] = butter(4,100/(Fs/2),'low');
[bHP,aHP] = butter(4,300/(Fs/2),'high');
[bBP,aBP] = butter(4,[100 300]/(Fs/2),'bandpass');

salida_bajos = filtfilt(bLP,aLP,senal_ruidosa);
salida_altos = filtfilt(bHP,aHP,senal_ruidosa);
salida_bandas = filtfilt(bBP,aBP,senal_ruidosa);

%% 3. Filtros FIR con ventana Hamming
ordenFIR = 80;             % 81 coeficientes
bFIR_bajos = fir1(ordenFIR,100/(Fs/2),'low',hamming(ordenFIR+1));
bFIR_altos = fir1(ordenFIR,300/(Fs/2),'high',hamming(ordenFIR+1));
bFIR_bandas = fir1(ordenFIR,[100 300]/(Fs/2),'bandpass', ...
                   hamming(ordenFIR+1));

salida_FIR_bajos = filtfilt(bFIR_bajos,1,senal_ruidosa);
salida_FIR_altos = filtfilt(bFIR_altos,1,senal_ruidosa);
salida_FIR_bandas = filtfilt(bFIR_bandas,1,senal_ruidosa);

%% 4. Senal de entrada
figure;
plot(t,senal_ruidosa);
title('Senal original con ruido');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

%% 5. Comparacion de salidas IIR
figure;
subplot(3,1,1);
plot(t,salida_bajos,'b');
title('IIR pasa bajos - 100 Hz');
xlabel('Tiempo (s)'); ylabel('Amplitud'); grid on; xlim([0 0.1]);

subplot(3,1,2);
plot(t,salida_altos,'r');
title('IIR pasa altos - 300 Hz');
xlabel('Tiempo (s)'); ylabel('Amplitud'); grid on; xlim([0 0.1]);

subplot(3,1,3);
plot(t,salida_bandas,'g');
title('IIR pasa bandas - 100 a 300 Hz');
xlabel('Tiempo (s)'); ylabel('Amplitud'); grid on; xlim([0 0.1]);
sgtitle('Comparacion de filtros IIR');

%% 6. Respuestas en frecuencia IIR
figure; freqz(bLP,aLP,1024,Fs); title('Respuesta en frecuencia IIR pasa bajos');
figure; freqz(bHP,aHP,1024,Fs); title('Respuesta en frecuencia IIR pasa altos');
figure; freqz(bBP,aBP,1024,Fs); title('Respuesta en frecuencia IIR pasa bandas');

%% 7. Comparacion de filtros FIR
figure;
subplot(3,1,1);
plot(t,salida_FIR_bajos);
title('FIR pasa bajos - 100 Hz');
xlabel('Tiempo (s)'); ylabel('Amplitud'); grid on; xlim([0 0.1]);

subplot(3,1,2);
plot(t,salida_FIR_altos);
title('FIR pasa altos - 300 Hz');
xlabel('Tiempo (s)'); ylabel('Amplitud'); grid on; xlim([0 0.1]);

subplot(3,1,3);
plot(t,salida_FIR_bandas);
title('FIR pasa bandas - 100 a 300 Hz');
xlabel('Tiempo (s)'); ylabel('Amplitud'); grid on; xlim([0 0.1]);
sgtitle('Comparacion de filtros FIR');

%% 8. Comparacion FIR e IIR
figure;
subplot(3,1,1);
plot(t,salida_bajos,'b'); hold on;
plot(t,salida_FIR_bajos,'r--');
title('Comparacion pasa bajos'); legend('IIR','FIR');
xlabel('Tiempo (s)'); ylabel('Amplitud'); grid on; xlim([0 0.1]);

subplot(3,1,2);
plot(t,salida_altos,'b'); hold on;
plot(t,salida_FIR_altos,'r--');
title('Comparacion pasa altos'); legend('IIR','FIR');
xlabel('Tiempo (s)'); ylabel('Amplitud'); grid on; xlim([0 0.1]);

subplot(3,1,3);
plot(t,salida_bandas,'b'); hold on;
plot(t,salida_FIR_bandas,'r--');
title('Comparacion pasa bandas'); legend('IIR','FIR');
xlabel('Tiempo (s)'); ylabel('Amplitud'); grid on; xlim([0 0.1]);
sgtitle('Comparacion de filtros FIR e IIR');

%% 9. Valores RMS
fprintf('\\nRESULTADOS RMS IIR\\n');
fprintf('Senal original: %.4f\\n',rms(senal_ruidosa));
fprintf('IIR pasa bajos: %.4f\\n',rms(salida_bajos));
fprintf('IIR pasa altos: %.4f\\n',rms(salida_altos));
fprintf('IIR pasa bandas: %.4f\\n',rms(salida_bandas));

fprintf('\\nRESULTADOS RMS FIR\\n');
fprintf('FIR pasa bajos: %.4f\\n',rms(salida_FIR_bajos));
fprintf('FIR pasa altos: %.4f\\n',rms(salida_FIR_altos));
fprintf('FIR pasa bandas: %.4f\\n',rms(salida_FIR_bandas));
