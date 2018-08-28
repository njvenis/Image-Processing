% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

% Step-1: Load input image
I = imread('Zebra.jpg');
figure;
imshow(I);
title('Step-1: Load input image');

% Step-2: Conversion of input image to grey-scale image
Igray = rgb2gray(I);
figure;
imshow(Igray);
title('Step-2: Conversion of input image to greyscale');

% define size of the new image
% orignal image is of size 556x612, scaled image to be 1668x1836

x = 1668;
y = 1836;


%To get size values for the X and Y axis the following command is used.

[ix, iy] = size(Igray);

%The scaling factor then has to be calculated.

xscale = x/ix;
yscale = y/iy;

%% nearest neighbor interpolation 

%this nested loop runs for every pixel in the new,resampled image
%the loop runs 1 short x and y as further down the new calculated x and y
%values are increased by one.

%create output image

newinn = uint8(zeros(x,y));

for n=1:x
    for m=1:y
        
        
        %the new pixel value for the new resampled image is calculated as
        %follows
        
        %newx takes the current x position (index n) of the new image and
        %divides that by the scaling factor 
        %floor is then used to round down to the nearest integer (round
        %towards negative infinity)
        newx = floor(n/xscale);
        
        %newy takes the current y position (index m) of the new image and
        %divides that by the scaling factor 
        %floor is then used to round down to the nearest integer (round
        %towards negative infinity)
        newy = floor(m/yscale);
        
         if newx == 0
            newx = 1;
        end
        
        if newy == 0
            newy = 1;
        end
        %the new pixel value at current x,y coordinates (n,m indexes) is
        %equal to the inital pixel value at the calculated x and y
        %coordinates
        %these are also added by one as if the functions return 0 an error
        %will be thrown as image indexes start at 1,1.
        newinn(n,m) = Igray(newx,newy);
        
    end
end


%% bilinear interpolation

%create a new image and fill the image with 0's
newi = uint8(zeros(x,y));

%scale up the original image to the resampled image size.
%this gives data for the bilinear algorithm pixel values to work between
for n=1:ix
    for m=1:iy
        newi((n*xscale), (m*xscale)) = Igray(n,m);
    end
end

%this loop runs for the length of the resampled image, however increments
%based on existing data from the original image to provide y axis data to
%interpolate using later on.

for n = 0:yscale:y-yscale
    for m = 0:xscale:x-xscale
        
        %loop indexes start at 0 however images start at 1, these two
        %if statements prevent image matrix indexing errors.
        
        if n == 0
            n = 1;
        end
        
        if m == 0
            m = 1;
        end
        
        %point a is marker of a pixel from the original image
        pointa = newi(m,n);
        
        %point b is a marker of the next pixel value from the original
        %image
        pointb = newi(m,(n+xscale));
        
        for k=1:xscale-1
            
            %ab is the calculated value for the current pixel
            %to calculate this:
            
            %a = the value at the first original data value * 
            %(the relative distance to the second value / the scaling factor)
            
            %b = the value at the second original data point * (the
            %relative distance to the first value / the scaling factor)
           
            a = ((pointa)*((xscale-k)/xscale));
            b = ((pointb)*(k/xscale));
            ab = round(a+b);
            
            %the new value in the new image is = a+b, also rounded as
            %colours cannot be in decimal values
            newi(m,n+k) = ab;
        end
        
    end
end

%for the second set of loops y data is already in place however instead of
%incrementing for every value of original data this loops for every row to
%create a completed image

for n=0:y
    for m=0:xscale:x-xscale
%         
%         loop indexes start at 0 however images start at 1, these two
%         if statements prevent image matrix indexing errors.
        if n == 0
            n = 1;
        end
        
        if m == 0
            m = 1;
        end
%         
%         point a is a marker of the first original value
        pointa = newi(m,n);
%         
%         point b is a marker of the next original value along the x scale
        pointb = newi(m+xscale,n);
%         
%         this loop runs for each pixel value missing between the orignal
%         image pixel values on the x axis
        for i=1:xscale-1
%             
%             ab is the calculated value for the current pixel
%             to calculate this:
%             
%             a = the value at the first original data value * 
%             (the relative distance to the first value / the scaling factor)
%             
%             b = the value at the second original data point * (the
%             relative distance to the second value / the scaling factor)
%             
            a = ((pointa)*((xscale-k)/xscale));
            
            b = ((pointb)*(k/xscale));
            
            ab = round(a+b);
%             the new value in the new image is = a+b, also rounded as
%             colours cannot be in decimal values
            newi(m+i,n) = ab;
            
        end
        
         
     end
end
%create a subplot to show the new image after NN interpolation and bilinear
%interpolation
figure; imshow(newi); title("After Bilinear Interpolation");
figure;
subplot(1,2,1);imshow(newinn); title('After nearest neighbor interpolation');
subplot(1,2,2); imshow(newi); title("After Bilinear Interpolation");

