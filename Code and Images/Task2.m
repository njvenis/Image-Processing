% MATLAB script for Assessment Item-1
% Task-2
clear; close all; clc;

I = imread('SC.png');

%create a subplot to display both the original image and a histogram
%presenting the data values.
figure;
subplot(1,2,1); imagesc(I); title("Original Image:");
subplot(1,2,2); imhist(I); title("Image Histogram:");
colormap gray;

%create a new double matrix to store the input image
u =  255*im2double(I);

%store the size of this matrix for use in for loops
[ux uy] = size(u);

%create a new image matrix to store the output image
output = zeros(ux,uy);

%set the cut off values for the ranges untouched by the algorith thereby
%keeping integrity
a = 80;
b = 100;
% the pixel value to set any values between the above values
c = 220;
%the number of greys in a greyscale image
greys = 255;

%the two for loops run for the size of the image and iterate over every
%pixel
for n = 1:ux
    for m = 1:uy
        %this conditional if statement checks if the current pixel value is
        %between constant a and b.
        if ((u(n,m)>= a) && (u(n,m) <= b))
            %pixel value is set to 220
            output(n,m) = c;
        %this else block determines what to do if the values arent in
        %the range of a and b
        else
            %retain pixel value
            output(n,m) = u(n,m);
        end
    end
end

%the output matrix is then divided by the amount of greys to get a uint 2d
%matrix
outimg = im2uint8(output/greys);

%the output is then displayed in a subplot with a histogram to highlight
%changing of pixel values.
figure;
subplot(1,2,1); imagesc(outimg); title("Highlighted Image:");
subplot(1,2,2); imhist(outimg); title("Image Histogram:");
colormap gray;











