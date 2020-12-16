%Eduardo de Almeida
%8066631
clc
clear all;

%Determinacao de parametros fisicos
hte=150; %altura da antena de transmissao da estao base em metros
hre=10; %altura da antena de recepcao da estacao movel em metros
sdA=3; %desvio padrao de ruido para a estacao A
sdB=5; %desvio padrao de ruido para a estacao A

%determinacao vetores de ruido
noiseA=sdA*randn(1,50);
noiseB=sdB*randn(1,50);
%disp de frequencias
disp('uplink freq=835 Mhz')
disp('downlink freq=880 Mhz')
disp('regiao urbana =900 Mhz')

%entrada
fc=input('Deseja incluir perda de trajetória para uplink, downlink ou a frequência de ambiente urbano?=')

%Laco iterativo implementado por meio do modelamento de Okumura-Hata
for d=1:50% Calculo de perda referente a estacao movel e estacao base:
    LA(d)=(69.55+26.6*log10(fc))-(13.82*log10(hte))-((1.11*log10(fc)-0.7)*(10)+(1.56*log10(fc)-0.8))+((44.9-6.55*log10(hte))*log10(d));%path loss calculation Between Mobile & Base station B
    LB(d)=(69.55+26.6*log10(fc))-(13.82*log10(hte))-((1.11*log10(fc)-0.7)*(10)+(1.56*log10(fc)-0.8))+((44.9-6.55*log10(hte))*log10(51-(d)));% path loss calculation for free space model
    LF(d)=32.4+20*log10(fc)+20*log10(d);
    % Potencia recebida em A sem ruido
    SrA(d)=60-LA(d);
    % Potencia recebida em A sem ruido
    SrB(d)=60-LB(d);
    % Potencia recebida em A com ruido Gaussiano sd=3
    PrA(d)=60-LA(d)+noiseA(d) ;
    % Potencia recebida em A com ruido Gaussiano sd=3
    PrB(d)=60-LB(d)+noiseB(d);
end

%plot das figuras
figure(1)
subplot(2,1,1);plot (PrA);
hold on
plot (PrB,'m');
 
%definicao dos eixos e subplots
axis([0 50 -90 -50]);
xlabel('distancia');
ylabel('forca do sinal')
grid
subplot(2,1,2);plot(SrA);
hold on
plot(SrB,'m');
axis([0 50 -90 -50]);
grid
figure(2)
plot(LA);
hold on
plot(LF);

%Registro de saida, explicitando as entradas escolhidas:
%uplink freq=835 Mhz
%downlink freq=880 Mhz
%em meio urbando =900 Mhz
%Você quer perda de trajetória para uplink, downlink ou frequência de ambiente urbano?=206.5
%fc =206.5000