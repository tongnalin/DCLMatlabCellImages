function [ th ] = otsuthresh( grayimg, L )

    [M, N] = size(grayimg);
    %hist = imhist(grayimg);
    count = 0;
    for a = 1:M
        for b = 1:N
         if grayimg(a,b) ~=0
            count = count + 1;
            hist(grayimg(a,b)) = hist(grayimg(a,b)) + 1;   
         end
        end
    end
    histp = hist/(M*N);
    mg = 0.0;
    for i = 0:L-1
        mg = mg + histp(i+1)*i;
    end
    %calc mg
    v= 0;
    for s = 0:L-1
        if hist(s+1) ~= 0
            break;
        end
    end
    mk = 0.0;
    pk = 0.0;
    for i = s: L-1  
        pk = pk + histp(i+1);
        mk = mk + histp(i+1)*i;
        vtmp = ((mg*pk-mk)^2)/(pk*(1-pk));
        if vtmp > v
            v = vtmp;
            th = i;
        end  
    end
    %calc th
end

