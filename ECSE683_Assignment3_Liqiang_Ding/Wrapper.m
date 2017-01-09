function [ X2 Y2 ] = Wrapper( IMG_seq,X1,Y1 )


if nargin > 0 
	[M N IMG_NUM] = size(IMG_seq);
	Point_MAX = 50;
	if ~exist('Y1','var')
		[Y1 X1] = corner_Harris(IMG_seq(:,:,1),Point_MAX);
		borderTh = 10;
		discard = Y1<borderTh | Y1>M-borderTh |...
			X1<borderTh | X1>N-borderTh; 
        % If points are too far away, ignore them
		Y1 = Y1(~discard);
		X1 = X1(~discard);
	end

	X2 = zeros(length(X1),IMG_NUM);
	Y2 = zeros(length(X1),IMG_NUM);
	X2(:,1) = X1;
	Y2(:,1) = Y1;

    %% Iterative Warpping
	for p = 2:IMG_NUM
		[X2(:,p) Y2(:,p)] = Iterative_W(IMG_seq(:,:,p-1),IMG_seq(:,:,p),X2(:,p-1),Y2(:,p-1));
	end

	if nargout == 0
		figure,pause 
    %% Show the Corners
        
    % length of the line represents the speed
		sc = min(M,N)/30; 
		for p = 1:IMG_NUM
			imshow(IMG_seq(:,:,p)),hold on
			X2p = X2(:,p); Y2p = Y2(:,p);
			plot(X2p,Y2p,'go');
			if p > 1 
                % display speed
				plot([X2p,X2p+(X2p-X2pl)*sc]', [Y2p,Y2p+(Y2p-Y2pl)*sc]','m-');
			end
			pause;
			X2pl = X2p; Y2pl = Y2p;
		end
    end
	
	

end

