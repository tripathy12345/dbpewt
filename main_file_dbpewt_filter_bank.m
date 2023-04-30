clc;
clear all;
close all;
load EEG_signal.mat; %%%signal file or time-series data
pp=max(abs(f));
f=f/pp;
f=f';
x1=f;
Fs=200;
N=length(f);
params.SamplingRate=Fs;
L=6; %%%decomposition level
frequency=(Fs./(2.^(L:-1:1))); %%%dyadic frequency grid
subresf=1;
boundaries=(frequency*(2*pi))/Fs; %%%%boundary evaluation from frequency
ff=fft(f);
% Build the corresponding filter bank
mfb=EWT_Meyer_FilterBank(boundaries,length(ff));

% We filter the signal to extract each subband
ewt=cell(length(mfb),1);
for k=1:length(mfb)
    mm=real(ifft(conj(mfb{k}).*ff));
    ewt{k}=mm;
    modes(k,:)=mm;  %%%%modes or sub-band signals 
end


div=1;
Show_EWT_Boundaries(abs(fft(f)),boundaries,div,params.SamplingRate);

figure
Bound=1;
xxx=(linspace(0,1,round(length(mfb{1,1}))))*Fs;
for i=1:size(mfb)
plot(xxx,mfb{i,1})
hold on
end
xlim([0 round(Fs/2)])
ylim([0 2])
title('DEWT filter bank')

figure
subplot(711)
plot(f);
subplot(712)
plot(ewt{1,1});
subplot(713)
plot(ewt{2,1});
subplot(714)
plot(ewt{3,1});
subplot(715)
plot(ewt{4,1});
subplot(716)
plot(ewt{5,1});
subplot(717)
plot(ewt{6,1});


