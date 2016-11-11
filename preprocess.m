function [BW ] = preprocess(Nrgb)
% begin preprocess
[M, N, ~] = size(Nrgb);

img_gray = rgb2gray(Nrgb);
thre = otsuthresh(img_gray, 256);
BW = false(M, N);
for i = 1:M
    for j = 1:N
        if img_gray(i,j) <= thre
            BW(i, j) = true;
        end
    end
end
BW(1,:) = 0;
BW(end,:) = 0;
BW(:,1) = 0;
BW(:,end) = 0;


% img_histeq = histeq(img_gray);
% thre = graythresh(img_histeq);
% BW = ~im2bw(img_histeq,thre);
SE = strel('square',4);
BW = imerode(BW, SE);

end
