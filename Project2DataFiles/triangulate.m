

% Triangulation
function worldPoints = triangulate(cam1_2D, cam2_2D, proj_mat_1, proj_mat_2)


    
end


% worldPoints = triangulate(camera1_2D', camera2_2D', proj_mat_1, proj_mat_2)



% Load the 2D pixel locations from Task 1
load('all_2D_points.mat'); % Assuming you have a file with the 39 2D pixel locations

% Load camera parameters for both cameras
load('Parameters_V1_1.mat');
Pmat_mat = [Parameters.Pmat; [0, 0, 0, 1]];
Kmat_mat = [Parameters.Kmat, [0,0,0]'];
proj_mat_1 = Kmat_mat * Pmat_mat

load('Parameters_V2_1.mat');
Pmat_mat = [Parameters.Pmat; [0, 0, 0, 1]];
Kmat_mat = [Parameters.Kmat, [0,0,0]'];
proj_mat_2 = Kmat_mat * Pmat_mat



