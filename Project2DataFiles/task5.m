clear all
clc

% Load your Fundamental Matrix (F) from the previous task
load('Fundamental_matrix.mat');

% Load the 2D pixel locations from Task 1
load('all_2D_points.mat'); % Assuming you have a file with the 39 2D pixel locations

% Initialize an array to store the distances
distances = zeros(39, 1);

for i = 1:39
    % Compute the 3D point projection in image 1 and image 2
    x1 = camera1_2D(1,i);
    y1 = camera1_2D(2,i);
    x2 = camera2_2D(1,i);
    y2 = camera2_2D(2,i);

    % Compute epipolar line in image 2 and calculate distance
    line2 = F * [x1; y1; 1];
    distance2 = (line2(1) * x2 + line2(2) * y2 + line2(3))^2 / (line2(1)^2 + line2(2)^2);

    % Compute epipolar line in image 1 and calculate distance
    line1 = F' * [x2; y2; 1];
    distance1 = (line1(1) * x1 + line1(2) * y1 + line1(3))^2 / (line1(1)^2 + line1(2)^2);

    % Calculate the mean of the distances for this point
    distances(i) = (distance1 + distance2) / 2;
end

% Calculate the mean of all the distances
mean_distance = mean(distances);

% Display the mean distance as a measure of accuracy
fprintf('Mean Symmetric Epipolar Distance: %f\n', mean_distance);
