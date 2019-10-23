clear all; clc; close all
R = 2;
M = round(-3*R)+1;
N = round(3*R)-1;
for i = 1:2*N+1
    for j = 1:2*N+1
        y1(i,j) = exp(-((M-1+i)^2+(M-1+j)^2)./(2.*(R^2)));
    end
end
y1 = y1/sum(sum(y1));
%surf(y1);
   
x = round(-3*R)+1:1:round(3*R)-1;
y = gaussmf(x,[R 0]);
y = y/sum(y);
two_D = y'*y;
 
img = imread('Rock_Climbing_Color.jpg');
%img = rgb2gray(img);
Y = imfilter(img,two_D);
Y = 255 - Y;
%Y(Y>=128) = 128;
figure,imshow(Y);
[h,w] = size(img);
Y = double(Y);
img = double(img);
al = 2.^(1-(Y./128));
G= 255.*(img./255).^al;
figure,
subplot(1,2,1)
imshow(uint8(G));title('Moroneys Method')
subplot(1,2,2)
imshow(uint8(img));title('Input image')
