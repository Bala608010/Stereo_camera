clear all
clc


% Load the 2D pixel locations from Task 1
load('all_2D_points.mat'); % Assuming you have a file with the 39 2D pixel locations

im = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');


%run 8-point alg
x1 = camera1_2D(1, 1:8); y1 = camera1_2D(2, 1:8); 
x2 = camera2_2D(1, 1:8); y2 = camera2_2D(2, 1:8);
sx1 = x1; sy1 = y1; sx2 = x2; sy2 = y2;
stdxy = (std(x1)+std(y1))/2;
T1 = [1 0 -mean(x1); 0 1 -mean(y1); 0 0 stdxy]/stdxy;
nx1 = (x1-mean(x1))/stdxy;
ny1 = (y1-mean(y1))/stdxy;
stdxy = (std(x2)+std(y2))/2;
T2 = [1 0 -mean(x2); 0 1 -mean(y2); 0 0 stdxy]/stdxy;
nx2 = (x2-mean(x2))/stdxy;
ny2 = (y2-mean(y2))/stdxy;


A = [];
for i=1:length(nx1);
    A(i,:) = [nx1(i)*nx2(i) nx1(i)*ny2(i) nx1(i) ny1(i)*nx2(i) ny1(i)*ny2(i) ny1(i) nx2(i) ny2(i) 1];
end
%get eig-vector for smallest eig-value of A' * A
[u,d] = eigs(A' * A,1,'SM');
F = reshape(u,3,3);

%make F rank 2
oldF = F;
[U,D,V] = svd(F);
D(3,3) = 0;
F = U * D * V';

F = T2' * F * T1;

save('Fundamental_matrix.mat', 'F');

colors =  'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';
%overlay epipolar lines on im2
L = F * [sx1 ; y1; ones(size(sx1))];
[nr,nc,nb] = size(im2);
figure(2); clf; imagesc(im2); axis image;
hold on; plot(x2,y2,'*'); hold off
for i=1:length(L)
    a = L(1,i); b = L(2,i); c=L(3,i);
    if (abs(a) > (abs(b)))
       yl=0; yh=nr; 
       xl = (-b * yl - c) / a;
       xh = (-b * yh - c) / a;
       hold on
       h=plot([xl; xh],[yl; yh]);
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    else
       xl=0; xh=nc; 
       yl = (-a * xl - c) / b;
       yh = (-a * xh - c) / b;
       hold on
       h=plot([xl; xh],[yl; yh],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    end
end


%overlay epipolar lines on im1
L = ([x2 ; y2; ones(size(x2))]' * F)' ;
[nr,nc,nb] = size(im);
figure(1); clf; imagesc(im); axis image;
hold on; plot(sx1,y1,'*'); hold off
for i=1:length(L)
    a = L(1,i); b = L(2,i); c=L(3,i);
    if (abs(a) > (abs(b)))
       yl=0; yh=nr; 
       xl = (-b * yl - c) / a;
       xh = (-b * yh - c) / a;
       hold on
       h=plot([xl; xh],[yl; yh],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    else
       xl=0; xh=nc; 
       yl = (-a * xl - c) / b;
       yh = (-a * xh - c) / b;
       hold on
       h=plot([xl; xh],[yl; yh],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    end
end



