function [ areas ] = myarea( inboundary )
%MYAREA Summary of this function goes here
%   Detailed explanation goes here
top = max(max(inboundary(:,1)));
bottom = min(min(inboundary(:,1)));
[Y, ~] = size(inboundary);
areas = 0;
for i = bottom:top
%     minp = inboundary()
    for j = 1:Y
        if inboundary(j,1) == i
            maxp = inboundary(j,2);
            minp = inboundary(j,2);
            break;
        end
    end
    
    for j = 1:Y
        if inboundary(j,1) == i
            if inboundary(j,1) > maxp
                maxp = inboundary(j,1);
            end
            if inboundary(j,1) <= minp
                minp = inboundary(j,1);
            end
        end
    end
    plot([minp maxp],[i i],'Marker','.');
    areas = areas + maxp-minp;
    
end

end

