clear all;
close all;
clc;

[y1,Fs1] = audioread('audio1.wav');
[y2,Fs2] = audioread('audio2.wav');
[P,Q] = rat(Fs2/Fs1);
y_1 = resample(y1,P,Q);

amp =.1;
fc = 9;
   

y_new = zeros(303994,1);

for i= 1:220071
    y_new(i)=y_1(i)*cos(fc*i)*amp;
end

figure
plot(abs(fft(y_new)))


ly1 = length(y_new);
ly2= length(y2);

sum_signal = y_new+y2;

figure
plot(abs(fft(sum_signal)))

t = linspace(0, 1, size(sum_signal,1))/Fs2;


for i= 1:303994
    sum_signal(i)=sum_signal(i)*cos(fc*i);
end


figure
plot(abs(fft(sum_signal)))

fft_sum_signal = abs(fft(sum_signal));
for i= 1:303994
    if fft_sum_signal(i)>90
        sum_signal(i)=0;
    end
end

figure
plot(abs(fft(sum_signal)))

c = smooth(sum_signal);
sound(10*c,Fs2);



