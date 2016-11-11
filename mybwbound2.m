function [ cells ] = mybwbound2( I )
%MYBWBOUND Summary of this function goes here
%   Detailed explanation goes here
[M, N] = size(I);

%neighbourhood map
% 1 8 7    -1 -1|-1 0|-1 1
% 2 0 6     0 -1| 0 0| 0 1
% 3 4 5     1 -1| 1 0| 1 1

neighbour = [-1 -1 1;0 -1 8;1 -1 7;1 0 6;1 1 5;0 1 4;-1 1 3;-1 0 2];
markup = zeros(M,N);

% 1 2 3    -1 -1|-1 0|-1 1
% 8 0 4     0 -1| 0 0| 0 1
% 7 6 5     1 -1| 1 0| 1 1

% [y x dire] dire:new against old
findermap{5} = [ 1 -1 7; 1  0 6; 1  1 5; 0  1 4;-1  1 3]; %1
findermap{6} = [ 0 -1 8; 1 -1 7; 1  0 6; 1  1 5; 0  1 4]; %2
findermap{7} = [-1 -1 1; 0 -1 8; 1 -1 7; 1  0 6; 1  1 5]; %3
findermap{8} = [-1  0 2;-1 -1 1; 0 -1 8; 1 -1 7; 1  0 6]; %4
findermap{1} = [-1  1 3;-1  0 2;-1 -1 1; 0 -1 8; 1 -1 7]; %5
findermap{2} = [ 0  1 4;-1  1 3;-1  0 2;-1 -1 1; 0 -1 8]; %6
findermap{3} = [ 1  1 5; 0  1 4;-1  1 3;-1  0 2;-1 -1 1]; %7
findermap{4} = [ 1  0 6; 1  1 5; 0  1 4;-1  1 3;-1  0 2]; %8
% findermap{0/9} = [];
for i = 2:M-1
    for j = 2:N-1
        tmp = sum(sum(I(i-1:i+1,j-1:j+1)));
        if tmp ~= 0 && tmp < 4
            markup(i,j) = 1;
        end
    end
end
I = markup;
imshow(I);
hold on;
cellnum = 0;
markup = zeros(M,N);
for i = 2:M-1
    for j = 2:N-1
        if I(i,j) == 1 && sum(sum(markup(i-1:i+1,j-1:j+1))) == 0
            cellnum = cellnum + 1;
            pointnum = 1;
            markup(i,j) = 2;% start point of one edge
            plot(j,i,'marker','^','Color','g');
            cells{cellnum,1}(pointnum,:) = [i,j];
            
            for dire1 = 1:8
                ti = i+neighbour(dire1,1);
                tj = j+neighbour(dire1,2);
%                 plot(tj,ti,'marker','.');
                if I(ti,tj) == 1 && markup(ti,tj) == 0
                    markup(ti,tj) = 1;
                    ii = ti;
                    jj = tj;
                    dire = neighbour(dire1,3);
                    pointnum = pointnum + 1;
%                     plot(jj,ii,'marker','.');
                    cells{cellnum,1}(pointnum,:) = [ii,jj];
                    break;
                end
            end
            
            while markup(ii,jj) ~= 2
                everentered = 0;
                for mapindex = 1:5
                    tmpi = ii + findermap{dire}(mapindex,1);
                    tmpj = jj + findermap{dire}(mapindex,2);
%                     plot(tmpj,tmpi,'marker','.');
                    if markup(tmpi,tmpj) ==2
%                         plot(jj,ii,'marker','.');
                        ii = tmpi;
                        jj = tmpj;
                        everentered = 1;
                        break;
                    end
                    
                    if I(tmpi,tmpj) == 1 && markup(tmpi,tmpj) == 0
                        plot(tmpj,tmpi,'marker','.');
                        markup(tmpi,tmpj) = 1;
                        everentered = 1;
%                         oldii = ii;
%                         oldjj = jj;
%                         olddire = dire;
                        
                        ii = tmpi;
                        jj = tmpj;
                        dire = findermap{dire}(mapindex,3);
                        pointnum = pointnum + 1;
                        cells{cellnum,1}(pointnum,:) = [ii,jj];
%                         for t = 1:5
%                             markup(oldii+findermap{olddire}(t,1),oldjj+findermap{olddire}(t,2)) = 1;
%                             plot(oldjj+findermap{olddire}(t,2),oldii+findermap{olddire}(t,1),'marker','.');
%                         end
                        break;
                    end
                    
                end
                
                % not a circle
                if everentered == 0
                    plot(jj,ii,'marker','^','Color','r');
                    break;
                end
            end
        end
    end
end

% imshow(markup);
end
