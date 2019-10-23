clear all; clc;
vid = VideoReader('Sky_noisy.avi');
numFrames = get(vid, 'NumberOfFrames'); 
 
frame = im2double(read(vid,1));
favg = frame;
for i = 2 : 30     
    frame = im2double(read(vid, i)); 
    favg = ((i-1)/i)*favg + (1/i)*frame;
end 
figure, imshow(favg)

%%%%
clear all; clc; close all;
vid = VideoReader('Sky_noisy.avi');
numFrames = get(vid, 'NumberOfFrames'); 
 
frame = im2double(read(vid,1));
favg = frame;
dxr = -1: 0.25 : 1;
dyr = -1: 0.25 : 1;
border = 5;
for i = 2 : 30    
    frame = im2double(read(vid, i));
    minSSE = inf;
    frame_t = rgb2gray(frame);
    y = rgb2gray(favg);
    for dx = dxr
        for dy = dyr
            x = imtranslate(frame_t, [dx dy]);
            frameSSE = sum(sum((x-y).^2));
            if frameSSE < minSSE
                minSSE = frameSSE;
                bestdx = dx;
                bestdy = dy;
            end
        end
    end
    frame1 = imtranslate(frame, [bestdx bestdy]);
    favg = ((i-1)/i)*favg + (1/i)*frame1;
    imshow(favg);
end 
imshow(favg)
