clear all; clc; close all;

I1 = imread('Couple_Film_Scan.tif');
P = rgb2ycbcr(I1);
I = P(:,:,1);
W = 13;
K = 100;
g = (W-1)/2;I = double(I);
J = padarray(I,[g g],0,'both');
[h w] = size(J);C =[];

for i = 1:h-W
    for j = 1:w-W
        C = J(i:i+W-1,j:j+W-1);
        D = J(i+g,j+g);
        E = C(:)-D;
        [G1,H1] = sort(abs(E));
        L = C(H1);
        L = L(1:K);
        L = sum(L)/K;
        J(i+g,j+g) = L;
    end
end  
J = round(J);
J = J(g+1:h-g,g+1:w-g);
P(:,:,1) = J;
V = ycbcr2rgb(P);
subplot(1,2,1);
imshow(V);title('K nearest neighbor image');
subplot(1,2,2);
imshow(I1); title('Input image');
