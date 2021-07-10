clear
clc
[x,fs] = audioread('C:\Users\Admin\Desktop\triall.wav');
whos x;           
N = size(x,1); % Determine total number of samples in audio file
figure
subplot(2,1,1)
plot(1:N, x(:,1))
title('Left Channel') 
xlabel('N')
ylabel('Normalised Amplitude')
subplot(2,1,2)
plot(1:N, x(:,2))
title('Right Channel')
xlabel('N')
ylabel('Normalised Amplitude')
%Adding Noise in audio signal [group-09]
y=x;
y = y + randn(size(y));
figure
subplot(2,1,1)
plot(1:N, y(:,1))
title('Left Channel with Noise')  
xlabel('N')
ylabel('Normalised Amplitude')
subplot(2,1,2)
plot(1:N, y(:,2))
title('Right Channel with Noise')
xlabel('N')
ylabel('Normalised Amplitude')

df = fs/N;
w = (-(N/2):(N/2)-1)*df;
a1=fft(x(:,1),N)/N;
a2=fftshift(a1);
y1= fft(y(:,1),N)/N;
y2 = fftshift(y1);
figure
plot(w,abs(y2))
title('shifted FFT of Noise mixed signal')
xlabel('Frequency')
ylabel('Absolute value of Y2')
n = 7;
beginFreq = 50 / (fs/2);
endFreq =   150  / (fs/2);
[b,a] = butter(n, [beginFreq, endFreq], 'stop');
oout = filter(b,a,a2);  
fout = filter(b,a,y2);
figure
plot(b,a)
title('Filter response Coefficients')
xlabel('b')
ylabel('a')
figure
stem(w,abs(fout))
title('Noise filtered output')
xlabel('Frequency')
ylabel('Absolute value of filter output')
figure
stem(w,abs(oout))
title('output before adding Noise')
xlabel('Frequency')
ylabel('Absolute value of filter output')