function [ X2 Y2 ] = Iterative_W( img1, img2, X1, Y1 )


winR = 6;
th = .01;
Iteration_MAX = 20;
Img_Size_MIN = 64; 
% if high pyramid level, blurred corners
LEVEL_MAX = floor(log2(min(size(img1))/Img_Size_MIN));

img1pyrs = Generate_Pyramid(img1,'gauss',LEVEL_MAX);
img2pyrs = Generate_Pyramid(img2,'gauss',LEVEL_MAX);
h = fspecial('sobel');

Point_NUM = size(X1,1);
X2 = X1/2^LEVEL_MAX;
Y2 = Y1/2^LEVEL_MAX;

for level = LEVEL_MAX:-1:1
	img1 = img1pyrs{level};
	img2 = img2pyrs{level};
	[M N] = size(img1);
	
	img1x = imfilter(img1,h','replicate');
	img1y = imfilter(img1,h,'replicate');
	
	for p = 1:Point_NUM
		xt = X2(p)*2;
		yt = Y2(p)*2;
		[iX iY oX oY isOut] = Generate(xt,yt,winR,M,N);
		if isOut, continue; end 
        % X and Y are reverse
		Ix = interp2(iX,iY,img1x(iY,iX),oX,oY); 
		Iy = interp2(iX,iY,img1y(iY,iX),oX,oY);
		I1 = interp2(iX,iY,img1(iY,iX),oX,oY);
		
		for q = 1:Iteration_MAX
			[iX iY oX oY isOut] = Generate(xt,yt,winR,M,N);
			if isOut, break; end
			It = interp2(iX,iY,img2(iY,iX),oX,oY) - I1;
			
			vel = [Ix(:),Iy(:)]\It(:);
			xt = xt+vel(1);
			yt = yt+vel(2);
			if max(abs(vel))<th, break; end
		end
		X2(p) = xt;
		Y2(p) = yt;
	end
	
end

end

function [iX iY oX oY isOut] = Generate(xt,yt,winR,M,N)

l = xt-winR;
t = yt-winR;
%r = xt+winR;


[oX,oY] = meshgrid(l:r,t:b);
cb = ceil(b);
fl = floor(l);
iX = fl:cr;
end