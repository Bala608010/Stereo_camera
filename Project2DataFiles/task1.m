% Load the stereo images
image1 = imread('im1corrected.jpg');
image2 = imread('im2corrected.jpg');

% Load the mocap data
load('mocapPoints3D.mat');

% Load camera parameters
load('Parameters_V1_1.mat');
load('Parameters_V2_1.mat');

% Number of mocap points
num_points = size(pts3D, 2);

% Create figure for image 1
figure;
imshow(image1);
title('Image 1 with Overlayed 2D Points');

% Project and overlay points on image 1
hold on;
for i = 1:num_points
    % Project the 3D point into 2D pixel coordinates for Camera 1
    point_2D_camera1 = Parameters.Kmat * (Parameters.Rmat * pts3D(:, i) + Parameters.Pmat);
    scatter(point_2D_camera1(1), point_2D_camera1(2), 50, 'r', 'filled'); % Adjust marker size and color as needed
end

% Create figure for image 2
figure;
imshow(image2);
title('Image 2 with Overlayed 2D Points');

% Project and overlay points on image 2
hold on;
for i = 1:num_points
    % Project the 3D point into 2D pixel coordinates for Camera 2
    point_2D_camera2 = Parameters.Kmat * (Parameters.Rmat * pts3D(:, i) + Parameters.Pmat);
    scatter(point_2D_camera2(1), point_2D_camera2(2), 50, 'r', 'filled'); % Adjust marker size and color as needed
end
