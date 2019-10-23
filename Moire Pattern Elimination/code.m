clear all; clc, close all;
A = imread('Radiograph_1.jpg');
[m_a1,p_a1,ml_a1,h,w] = img_fr(A);
ml_a1 = fftshift(ml_a1);
imshow(ml_a1,[]);title('Log mag of image1')
 
B = imread('Radiograph_2.jpg');
[m_b1,p_b1,ml_b1,h1,w1] = img_fr(B);
ml_b1 = fftshift(ml_b1);
figure, imshow(ml_b1,[]);title('Log mag of image2')
 
%%Notch filter on image1
k = 15;
H1 = c_notch(258,239,k,h,w);
H2 = c_notch(82,267,k,h,w);
H3 = c_notch(218,245,k,h,w);
H4 = c_notch(122,261,k,h,w);
 
H = H1.*H2.*H3.*H4;
figure, imshow(H),title('Moire pattern due in 1st image');
 
 
G = H.*ml_a1;
H = fftshift(H);
G1 = H.*m_a1;
 
figure,imshow(G,[]),title('Suppressing Moire pattern');
 
L1 = G1.*exp(1i.*p_a1);
r_img = ifft2(L1);
figure, 
subplot(1,2,1)
imshow(r_img,[]),title('Reconstructed image');
subplot(1,2,2)
imshow(A),title('Original image');
 
%%Notch filter on image2
k = 10;
H5 = c_notch(451,210,k,h1,w1);
H6 = c_notch(443,276,k,h1,w1);
 
H_2 = H5.*H6;
figure, imshow(H_2),title('Moire pattern due in 1st image');
 
 
G = H_2.*ml_b1;
H_2 = fftshift(H_2);
G1 = H_2.*m_b1;
 
figure,imshow(G,[]),title('Suppressing Moire pattern');
 
L1 = G1.*exp(1i.*p_b1);
r_img = ifft2(L1);
figure, 
subplot(1,2,1)
imshow(r_img,[]),title('Reconstructed image');
subplot(1,2,2)
imshow(B),title('Original image');


%% customised functions

function [magnitude,phase,log_magnitude,h,w,A_F] = img_fr(A)
    A = double(A);
    [h,w] = size(A);
    A_F = fft2(A);
    magnitude = abs(A_F);
    phase = angle(A_F); 
    log_magnitude = log(1 + magnitude);
end

function H = c_notch(u,v,sig,h,w)
var = sig*sig
for i = 1:h
    for j = 1:w
        H(i,j) = 1- exp(-((i-u).^2 + (j-v).^2)./var);
    end
end
end
