% MATLAB script for Assessment Item-1
% Task-3
clear; close all; clc;

%read in the input image 
I = imread('Noisy.png');

%convert the image to greyscale
Igray = rgb2gray(I);

%store the dimensions of the input image
[x y] = size(Igray);

%set the size of the structuring element
kernel = 5;

%pad the matrix with 0's to accomodate the structuring element
padded = padarray(Igray,[2 2]);

%create a new matrix to display the output of average filtering
outputavg = uint8(zeros(x,y));


%the for loop iterates over every pixel with X and Y being used as end
%conditions
for h=1:x
    for j=1:y
        %sum is declared here so that it is reset to 0 after the kernel
        %loops end
        sum = 0;
        %these two for loops run the length and bredth of the kernel
        for k=1:kernel
            for l=1:kernel
                %we divide the value of current pixel at position in the
                %kernel by the kernel squared to avoid having to average
                %later
                sum = sum + (1/(kernel*kernel))*padded(k+(h-1),l+(j-1));    
            end
        end
         %the pixel value at current index is equal to the value of sum  
         outputavg(h,j) = sum;
         
    end
end

%create a uint8 matrix for the output of median filtering
outputmed = uint8(zeros(x,y));

%the for loop iterates over every pixel with X and Y being used as end
%conditions
for h=1:x
    for j=1:y
        %store is an array initialised here so after the kernel loop
        %finishes we remove any values from it
        store = [];
        %these two for loops run the length and bredth of the kernel
        for k=1:kernel
            for l=1:kernel
                % we take the current value of the image at both kernel
                % index and image position and push it to the end of store
                store(end+1) = padded(k+(h-1),l+(j-1));    
            end
        end
        %we take the median of the store array and store it at the current
        %pixel in the first two loops
         outputmed(h,j) = median(store);
    end
end

%we display each image side by side to illustrate the differences.
figure; imshow(outputavg); title("Averaging filtering:");
figure; imshow(outputmed); title("Median Filtering");
               
        