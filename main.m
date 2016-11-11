clear;
close all;
Nrgb = imread('easy\1.jpg');
BW = preprocess(Nrgb);

% BW_filled = imfill(BW,'holes');
BW_filled = myfill(BW);

boundaries = mybwbound(BW_filled);
% boundaries = bwboundaries(BW_filled);
Nrgb = cellrecog(boundaries,Nrgb);
figure,imshow(Nrgb);