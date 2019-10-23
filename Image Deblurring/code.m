clear all; clc; close all
% estimating noise variance
I = imread('Signs_degraded.jpg');
I = double(I);
J = I(80:100,20:500);
%imshow(uint8(J));
c = var(J(:));
K = I(390:400,20:500);
d = var(K(:));
 
% Filter domain of given signal
[m_I,p_I,ml_I] = img_fr(I);
ml_I = fftshift(ml_I);
imshow(ml_I,[]);
 
% Estimating motion blur
G = zeros(size(I)+1);
[h w] = size(G);
g = fspecial('motion',35,90);
[h1 w1] = size(g);
G((h/2)-(h1/2):(h/2)+(h1/2)-1,(w/2)-(w1/2):(w/2)+(w1/2)-1) = g;
[m_h,p_h,ml_h] = img_fr(G);
ml_h = fftshift(ml_h);
figure,imshow(ml_h,[]);
 
R = ml_h(1:600,1:600) + ml_I;
imshow(R,[]);
 
% edge taper
k = fspecial('gaussian',40,60);
I = edgetaper(I,k);
 
es_nsr = 12/var(I(:));
Z = deconvwnr(I,g,es_nsr);
figure,imshow(Z,[]);

%% customised function

function [magnitude,phase,log_magnitude,h,w,A_F] = img_fr(A)
    A = double(A);
    [h,w] = size(A);
    A_F = fft2(A);
    magnitude = abs(A_F);
    phase = angle(A_F); 
    log_magnitude = log(1 + magnitude);
end
