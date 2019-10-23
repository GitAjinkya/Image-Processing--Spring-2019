clear all; clc; close all
A = imread('F:\wallpapers\boy.tif');
A = imresize(A,0.5);
[h,w] = size(A);
 
% Cubic Filters
a1 = -0.75; a2 = -1; a3 = -.25; a4 = -0.5;
N = 4;
i = 1;
for x = -2:1/N:2;
    x = abs(x);
    if (0 <= x) & (x <= 1)
        y1(i) = (a1+2).*(x.^3) - (a1+3).*(x.^2) + 1;
        y2(i) = (a2+2).*(x.^3) - (a2+3).*(x.^2) + 1;
        y3(i) = (a3+2).*(x.^3) - (a3+3).*(x.^2) + 1;
        y4(i) = (a4+2).*(x.^3) - (a4+3).*(x.^2) + 1;
    elseif (1<x) & (x<=2)
        y1(i) = a1.*(x.^3) - 5.*a1.*x.^2 + 8.*a1.*x - 4.*a1;
        y2(i) = a2.*(x.^3) - 5.*a2.*x.^2 + 8.*a2.*x - 4.*a2;
        y3(i) = a3.*(x.^3) - 5.*a3.*x.^2 + 8.*a3.*x - 4.*a3;
        y4(i) = a4.*(x.^3) - 5.*a4.*x.^2 + 8.*a4.*x - 4.*a4;
    else
        y1(i) = 0;
        y2(i) = 0;
        y3(i) = 0;
        y4(i) = 0;
    end
    i = i+1;
end
 
y1 = y1'*y1;
y2 = y2'*y2;
y3 = y3'*y3;
y4 = y4'*y4;
N = 4;
C = ones(N*h,N*w);
y = 1;
 
for i = 1:h
    z = 1;
    for j = 1:w
        C(y,z) = A(i,j);
        z = (N*j)+1;
    end
    y = (N*i)+1;
end 
C = uint8(C);
imshow(C);
Y1 = imfilter(C,y1);
Y1 = uint8(Y1);
figure, imshow((uint8(Y1)));
Y2 = imfilter(C,y2);
figure, imshow(uint8(Y2));
Y3 = imfilter(C,y3);
figure, imshow(uint8(Y3));
Y4 = imfilter(C,y4);
figure, imshow(uint8(Y4));
