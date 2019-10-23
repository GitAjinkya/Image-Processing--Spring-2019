clear all clc
R = 1.8 
b = 2.5
img = imread('F:\wallpapers\boy.tif')
x = round(-3*R):1:round(3*R)
y = gaussmf(x,[R 0])
y = y/sum(y)
two_D = y'*y
[h,w]= size(two_D)
ap = zeros([h w])
ap((h+1)/2,(w+1)/2)= 1
two_D = ap - two_D
sharp = ap + b.*two_D
sharp1 = imfilter(img,sharp)
imshow(img)
figure,imshow(sharp1)
