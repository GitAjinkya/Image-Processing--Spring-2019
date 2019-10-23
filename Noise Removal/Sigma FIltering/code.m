clear all; close all; clc
I = imread('Face.tif');
P = rgb2ycbcr(I);
J = P(:,:,1);
W = 13;
d = 20
t = 2*d;
I = double(I);
g = (W-1)/2;
S = zeros(size(J));
J = padarray(J,[g g],0,'both');
J = double(J);
[h w] = size(J);
C =[];
for i = 1:h-W
    for j = 1:w-W
        C = J(i:i+W-1,j:j+W-1);
        D = J(i+g,j+g);
        E = C(:)-D;
        [G1,H1] = sort(abs(E));
        L = C(H1);
        K = G1(G1<=t);
        L = L(1:length(K));
        L = sum(L)/length(K);
        S(i,j) = L;
    end
end  
J = round(J);
J = J(g+1:h-g,g+1:w-g);
P(:,:,1) = S;
V = ycbcr2rgb(P);
subplot(1,2,1);
imshow(V);title('Sigma filtered image');
subplot(1,2,2);
imshow(uint8(I)); title('Input image');
