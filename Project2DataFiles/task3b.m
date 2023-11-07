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


x1 = [1202.96357615894, 1660.71192052980, 1150.03642384106]'
y1 = [311.625827814569, 471.837748344371, 501.877483443709]'
x2 = [351.837748344371, 835.334437086093, 298.910596026490]'
y2 = [200.049668874172, 337.374172185430, 447.519867549669]'

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