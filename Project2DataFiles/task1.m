clear all
clc

% Load the stereo images
image1 = imread('im1corrected.jpg');
image2 = imread('im2corrected.jpg');

% Load the mocap data
load('mocapPoints3D.mat');

% Load camera parameters
load('Parameters_V1_1.mat');
%load('Parameters_V2_1.mat');

% Number of mocap points
num_points = size(pts3D, 2);

% Initialize arrays to store 2D points for all mocap points
camera1_2D = zeros(2, num_points);
camera2_2D = zeros(2, num_points);

% Create figure for image 1
figure;
imshow(image1);
title('Image 1 with Overlayed 2D Points');

Pmat_mat = [Parameters.Pmat; [0, 0, 0, 1]];
Kmat_mat = [Parameters.Kmat, [0,0,0]'];

% Project and overlay points on image 1
hold on;
for i = 1:num_points
    % Project the 3D point into 2D pixel coordinates for Camera 1
    point_3D = vertcat(pts3D(:, i), 1)
    point_2D_camera1 = Kmat_mat * (Pmat_mat* point_3D);
    point_2D_camera1(1) = point_2D_camera1(1)/point_2D_camera1(3);
    point_2D_camera1(2) = point_2D_camera1(2)/point_2D_camera1(3);
    camera1_2D(:, i) = point_2D_camera1(1:2);

    scatter(point_2D_camera1(1), point_2D_camera1(2), 'r', 'filled'); % Adjust marker size and color as needed
end


% Load camera parameters
load('Parameters_V2_1.mat');

% Create figure for image 1
figure;
imshow(image2);
title('Image 2 with Overlayed 2D Points');

Pmat_mat = [Parameters.Pmat; [0, 0, 0, 1]];
Kmat_mat = [Parameters.Kmat, [0,0,0]'];

% Project and overlay points on image 1
hold on;
for i = 1:num_points
    % Project the 3D point into 2D pixel coordinates for Camera 1
    point_3D = vertcat(pts3D(:, i), 1)
    point_2D_camera2 = Kmat_mat * (Pmat_mat* point_3D);
    point_2D_camera2(1) = point_2D_camera2(1)/point_2D_camera2(3);
    point_2D_camera2(2) = point_2D_camera2(2)/point_2D_camera2(3);
    camera2_2D(:, i) = point_2D_camera2(1:2);

    scatter(point_2D_camera2(1), point_2D_camera2(2), 'r', 'filled'); % Adjust marker size and color as needed
end


save('all_2D_points.mat', 'camera1_2D', 'camera2_2D');
