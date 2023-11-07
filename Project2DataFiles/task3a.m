clear all
clc

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

x1 = [972.658940397351, 1291.65231788079, 643.652317880795]'
y1 = [929.586092715232, 797.983443708609, 819.440397350993]'
x2 = [1707.91721854305, 1363.17549668874, 1450.43377483444]'
y2 = [697.850993377483, 597.718543046358, 760.791390728477]'

camera1_2D = vertcat(x1', y1');
camera2_2D = vertcat(x2', y2');

% Perform triangulation to recover 3D points
worldPoints = triangulate(camera1_2D', camera2_2D', proj_mat_1, proj_mat_2)

Vector1 = worldPoints(2,:) - worldPoints(1,:)
Vector2 = worldPoints(3,:) - worldPoints(1,:)
A = worldPoints(1,:)

normal_vector = cross(Vector1, Vector2)
unit_vector = normal_vector / norm(normal_vector)

Constant_value = (unit_vector(1)*A(1) + unit_vector(2)*A(2) + unit_vector(3)*A(3))

% unit_vector(1)*X + unit_vector(2)*Y + unit_vector(3)*Z - (unit_vector(1)*A(1) + unit_vector(2)*A(2) + unit_vector(3)*A(3))
