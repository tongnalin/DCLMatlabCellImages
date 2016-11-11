function [canvas] = segment2( boundaries, canvas)
%SEGMENT Summary of this function goes here
%   Detailed explanation goes here

neighbour = [-1 -1;0 -1;1 -1;1 0;1 1;0 1;-1 1;-1 0;0 0];
[holenum,~] = size(boundaries);
% find max Dx Dy & generate a list of radii
% sumDx = 0;
% sumDy = 0;
maxDx = 0;
maxDy = 0;
Dxlist = zeros(1,holenum);
Dylist = zeros(1,holenum);
for k = 1:holenum
    b = boundaries{k,1};
    Dxlist(k) = max(b(:,1))-min(b(:,1));
    Dylist(k) = max(b(:,2))-min(b(:,2));
    %     sumDy = sumDy + Dylist(k);
    %     sumDx = sumDx + Dxlist(k);
    if Dxlist(k) > maxDx
        maxDx = Dxlist(k);
    end
    if Dylist(k) > maxDy
        maxDy = Dylist(k);
    end
end
% avgDx = sumDx/holenum(1);
% avgDy = sumDy/holenum(1);
Dxlimit = maxDx/2.3;
Dylimit = maxDy/2.3;
%find valid cell numbers
%find cell length range by cell number and image scale
% scalecell = ;
% scalepeak = 3;
% checkstep = 3;

% find those cells whose edge varies a lot
% figure, imshow(Nrgb), hold on;
for k = 1:holenum
    b = boundaries{k,1};
    %    if the pattern is too small, eliminate
    if max(b(:,2))-min(b(:,2))<Dylimit||max(b(:,1))-min(b(:,1))<Dxlimit
        continue;
    end
    
    %     centrey = round((max(b(:,2))+min(b(:,2)))/2);
    %     centrex = round((max(b(:,1))+min(b(:,1)))/2);
    [Y, ~] = size(b);
    
    %    better xe ye can be obtained automatically for example via script
    %    xe diff x+ and x- changing rate
    xe = 3;
    ye = 3;
    %----------------checkstepdiv should vary with each cell----------------------%
    checkstepdiv = Y/14;
    checkstep = round(((max(b(:,2))-min(b(:,2)))/checkstepdiv + (max(b(:,1))-min(b(:,1)))/checkstepdiv)/2);
    %     checkstep = round(sqrt((max(b(:,2))-min(b(:,2)))^2 + (max(b(:,1))-min(b(:,1)))^2)/checkstepdiv);
    %     checkstep = round(Y/50);
    corner = 0;
    for start = 0:checkstep
        for i = 1+checkstep+start:checkstep:Y-checkstep
            dxp = abs(b(i,1)-b(i-checkstep,1));
            dyp = abs(b(i,2)-b(i-checkstep,2));
            dxn = abs(b(i,1)-b(i+checkstep,1));
            dyn = abs(b(i,2)-b(i+checkstep,2));
            if abs(dyn-dyp) > ye || abs(dxn-dxp) > xe
                corner = corner + 1;
                for p = 1:9
                    canvas(b(i+neighbour(p,1),1),b(i+neighbour(p,2),2),:) = [0,0,255];
                end
            end
        end
    end
    
    if corner <= 3
        for p = 1:Y
            canvas(b(p,1),b(p,2),:) = [0,255,0];
        end
        %         canvas(centrey-1:centrey+1,centrex-1:centrex+1,:) = [0,255,0];
        %         plot(b(:,2),b(:,1),'g','LineWidth',1);
        %         plot(centrey, centrex, 'g', 'LineWidth' ,1,'LineStyle', 'none', 'Marker', '^');
        
    elseif corner > 3 && corner <50
        for p = 1:Y
            canvas(b(p,1),b(p,2),:) = [255,0,0];
        end
        
    else
        for p = 1:Y
            canvas(b(p,1),b(p,2),:) = [0,0,255];
        end
    end
    
end
figure, imshow(canvas);
end