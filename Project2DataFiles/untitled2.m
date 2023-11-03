% Load the stereo images
image1 = imread('im1corrected.jpg');
image2 = imread('im2corrected.jpg');

% Load the mocap data
load('mocapPoints3D.mat');

% Load camera parameters
load('Parameters_V1_1.mat');
load('Parameters_V2_1.mat');