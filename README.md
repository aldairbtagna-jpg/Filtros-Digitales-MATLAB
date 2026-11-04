# Implementación y evaluación de filtros digitales en MATLAB

**Estudiante:** Jerónimo Bautista Torres  
**Materia:** Señales y Sistemas  
**Profesor:** Ing. Luis Osvaldo Moreno Gaytán

## Descripción
Este proyecto genera una señal compuesta por tres componentes sinusoidales (50 Hz, 200 Hz y 500 Hz), agrega ruido blanco y aplica filtros digitales pasa bajos, pasa altos y pasa bandas. Se comparan filtros IIR Butterworth y FIR diseñados con ventana Hamming.

## Parámetros
- Frecuencia de muestreo: 2000 Hz
- Duración: 2 segundos
- Componentes: 50 Hz, 200 Hz y 500 Hz
- Ruido: blanco gaussiano, amplitud 0.5
- Filtros IIR: Butterworth de orden 4
- Filtros FIR: orden 80 (81 coeficientes), ventana Hamming
- Pasa bajos: 100 Hz
- Pasa altos: 300 Hz
- Pasa bandas: 100 a 300 Hz

## Requisitos
MATLAB y Signal Processing Toolbox. El programa utiliza `butter`, `fir1`, `hamming`, `filtfilt`, `freqz` y `rms`.

## Cómo ejecutar
1. Descarga `Filtros_Digitales.m`.
2. Abre MATLAB.
3. Abre el archivo y presiona **Run**.
4. Revisa las figuras y los resultados RMS en Command Window.

## Resultados RMS obtenidos en la ejecución documentada

| Filtro | IIR RMS | FIR RMS |
|---|---:|---:|
| Pasa bajos | 0.7216 | 0.7280 |
| Pasa altos | 0.8083 | 0.8131 |
| Pasa bandas | 0.7276 | 0.7252 |

Los valores pueden variar si se modifica la señal, el ruido, la semilla aleatoria o los parámetros de diseño.

## Interpretación esperada
- El pasa bajos conserva principalmente la componente de 50 Hz.
- El pasa altos conserva principalmente la componente de 500 Hz.
- El pasa bandas de 100 a 300 Hz conserva principalmente la componente de 200 Hz.

## Autor
Jerónimo Bautista Torres
