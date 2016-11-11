function [B_img] = myfill(img)

[row,col] = size(img);
img_tmp = marking(img,1,1);
img_tmp = ~img_tmp;

for i = 1:row
    for j = 1:col
        if(img_tmp(i,j) == 1)
            img(i,j) = 1;
        end
    end
end

B_img = img;
