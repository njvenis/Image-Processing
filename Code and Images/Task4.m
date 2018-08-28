% MATLAB script for Assessment Item-1
% Task-4
clear; close all; clc;

I = imread('Starfish.jpg');
bw = rgb2gray(I);

%% remove salt and pepper noise
bw = medfilt2(bw);

% figure;
% subplot(1,2,1); imshow(bw); title("Using median filtering");
% subplot(1,2,2); imshow(bw2); title("Using gaussian filtering");

%% threshold the image
bw = imbinarize(bw,0.9);

%% dilate then erode
bw = imclose(bw,strel("square",3));

%% find edges and then fill in those shapes to make regions
bw = edge(bw,"canny");
bw = imfill(bw,'holes');

%% find every region and the area and perimeter of each

p = regionprops(bw,"Area","Perimeter");

%% store boundaries of each object that doesnt have a hole in it

[b l] = bwboundaries(bw,"noholes");

%% set the threshold of how round a star can be

thresholdupper = 0.0020;
thresholdlower = 0.0014;

%% create output image
[x y] = size(bw);
output = uint8(zeros(x,y));
output = imbinarize(output);

%% loop through the array of Areas and Perimeters

for i=1:length(b)
    
    %get perimeter and area of object
    perimeter  = p(i).Area;
    area = p(i).Perimeter;
    
    %metric to compute roundness
    metric = 4*pi*area/perimeter^2;     
    
    %if the the object meets the roundness threshold and area limit add to
    %output image
    
    if ((metric <= thresholdupper && metric >= thresholdlower)&& area > 220)
        temp = (l==i);
        output = output + temp;
    end
  
end
%display output image in a subplot with original
figure;
subplot(1,2,1); imshow(I); title("Original image:");
subplot(1,2,2); imshow(output); title("Output binary image of found starfish:");





