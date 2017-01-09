%% Importing images
clear all;clc;

Input1=imread('pepsi04.jpg');
Input2=imread('pepsi05.jpg')
Sigma=1.5;


Input1_double = im2double(rgb2gray(Input1));
im1 = imresize(Input1_double, 0.5); 

Input2_double = im2double(rgb2gray(Input2));
im2 = imresize(Input2_double, 0.5); 
 
%% Implementing Lucas Kanade Method
WINDOW = 45;
w = round(WINDOW/2); %w=23

% Calculate the derivate respective to x, y and t of each image pixel
operator3 = [-1 0 1;-1 0 1;-1 0 1];
operator2 = [-1 1;-1 1];

%leave out the first and last k images
Ix_m = conv2(im1, operator2, 'valid'); % partial on x
Iy_m = conv2(im1, operator2', 'valid'); % partial on y
It_m = conv2(im1, operator2, 'same') + conv2(im2, -operator2, 'same'); % partial on t


u = zeros(size(im1));
v = zeros(size(im2));
 
% within window WINDOW * WINDOW
for i = w+1:size(Ix_m,1)-w
   for j = w+1:size(Ix_m,2)-w
      Ix = Ix_m(i-w:i+w, j-w:j+w);
      Iy = Iy_m(i-w:i+w, j-w:j+w);
      It = It_m(i-w:i+w, j-w:j+w);
      
      Ix = Ix(:);
      Iy = Iy(:);
      % Caluclate b
      b = -It(:); 
    
      % Calculate A matrix
      A = [Ix Iy]; 
      % Calculate the velocity here
      nu = pinv(A)*b; 

      u(i,j)=nu(1);
      v(i,j)=nu(2);
   end;
end;
 
% downsize u and v
u_small = u(1:10:end, 1:10:end);
v_small = v(1:10:end, 1:10:end);
% get coordinate for u and v in the original frame
[m, n] = size(Input1_double);
[X,Y] = meshgrid(1:n, 1:m);
X_small = X(1:20:end, 1:20:end);
Y_small = Y(1:20:end, 1:20:end);

%% Plot optical flow field
figure();
imshow(Input2);
hold on;
% Display the vector on the image
quiver(X_small, Y_small, u_small,v_small, 'y')
