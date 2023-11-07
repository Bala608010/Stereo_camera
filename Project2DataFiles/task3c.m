clear all
clc

x1 = [1071.36092715232, 1059.91721854305,572.129139072848,570.698675496689,693.718543046358,1459.01655629139]'
y1 = [301.612582781457, 531.917218543046, 390.301324503311, 540.500000000000, 700.711920529801, 257.268211920530]'
x2 = [98.6456953642385, 125.824503311258, 1035.59933774834, 999.837748344371, 985.533112582781, 715.175496688742]'
y2 = [187.175496688742, 509.029801324503, 344.526490066225, 549.082781456954, 713.586092715232, 152.844370860927]'


% Load camera parameters for both cameras
load('Parameters_V1_1.mat');
Pmat_mat = [Parameters.Pmat; [0, 0, 0, 1]];
Kmat_mat = [Parameters.Kmat, [0,0,0]'];
proj_mat_1 = Kmat_mat * Pmat_mat

load('Parameters_V2_1.mat');
Pmat_mat = [Parameters.Pmat; [0, 0, 0, 1]];
Kmat_mat = [Parameters.Kmat, [0,0,0]'];
proj_mat_2 = Kmat_mat * Pmat_mat

%{
im = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');


figure(1); imagesc(im); axis image; drawnow;
figure(2); imagesc(im2); axis image; drawnow;


figure(1); [x1,y1] = getpts
figure(1); imagesc(im); axis image; hold on
for i=1:length(x1)
   h=plot(x1(i),y1(i),'*'); set(h,'Color','g','LineWidth',2);
   text(x1(i),y1(i),sprintf('%d',i));
end
hold off
drawnow;

figure(2); imagesc(im2); axis image; drawnow;
[x2,y2] = getpts
figure(2); imagesc(im2); axis image; hold on
for i=1:length(x2)
   h=plot(x2(i),y2(i),'*'); set(h,'Color','g','LineWidth',2);
   text(x2(i),y2(i),sprintf('%d',i));
end
hold off
drawnow;

%}

camera1_2D = vertcat(x1', y1');
camera2_2D = vertcat(x2', y2');

% Perform triangulation to recover 3D points
worldPoints = triangulate(camera1_2D', camera2_2D', proj_mat_1, proj_mat_2)

% Height of doorway 
height_doorway = sqrt(sum((worldPoints(1,:) - worldPoints(2,:)).^2))

% Height of the person 
height_person = sqrt(sum((worldPoints(3,:) - worldPoints(4,:)).^2)) + sqrt(sum((worldPoints(4,:) - worldPoints(5,:)).^2))

% Coordinates of the camera
coord_cam = worldPoints(6,:)