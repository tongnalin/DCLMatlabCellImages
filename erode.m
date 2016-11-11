function I = erode( ImgTest )
I = ImgTest;
[height,width]=size(ImgTest);
for i = 1:height
    for j = 1:width
        if i-1 > 0 && i+1 <= height && j-1 >0 && j+1 <= width
            if ImgTest(i-1,j-1)==1&&ImgTest(i-1,j)==1&&ImgTest(i-1,j+1)==1&&ImgTest(i,j-1)==1&&ImgTest(i,j)==1&&ImgTest(i,j+1)==1&&ImgTest(i+1,j)==1&&ImgTest(i+1,j+1)==1
                I(i,j)=1;
            else
                I(i,j)=0;
            end
        end
    end
end

end
