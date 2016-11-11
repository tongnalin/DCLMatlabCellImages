clc
close all
clear
%%%生成高斯平滑滤波模板%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
hg=zeros(3,3);  
%设定高斯平滑滤波模板的大小为3*3
delta=0.5;
for x=1:1:3    
    for y=1:1:3        
        u=x-2;        
        v=y-2;        
        hg(x,y)=exp(-(u^2+v^2)/(2*pi*delta^2));    
    end
end
h=hg/sum(hg(:));
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%读入图像%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%
f = imread('easy/2.jpg'); 
% 读入图像文件
f=rgb2gray(im2double(f));
imshow(f)
title('原始图像');
figure,imshow(edge(f,'Roberts'));
title('edge');
[m,n]=size(f);
ftemp=zeros(m,n);
rowhigh=m-1;
colhigh=n-1;
%%%高斯滤波%%%
for x=2:1:rowhigh-1    
    for y=2:1:colhigh-1        
        mod=[f(x-1,y-1) f(x-1,y) f(x-1,y+1); f(x,y-1) f(x,y) f(x,y+1);f(x+1,y-1) f(x+1,y) f(x+1,y+1)];
        A=h.*mod;
        ftemp(x,y)=sum(A(:));
    end
end
f=ftemp;
figure,imshow(f);
title('通过高斯滤波器后的图像');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%利用roberts算子进行边缘检测%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sx=[-1 -2 -1;0 0 0;1 2 1];
sy=[-1 0 1;-2 0 2;-1 0 1];%Roberts
% sx=[-1 -2 -1;0 0 0;1 2 1];
% sy=[-1 0 1;-2 0 2;-1 0 1];%Sobel
for x=2:1:rowhigh-1    
    for y=2:1:colhigh-1        
        mod=[f(x-1,y-1) f(x-1,y) f(x-1,y+1); f(x,y-1) f(x,y) f(x,y+1);f(x+1,y-1) f(x+1,y) f(x+1,y+1)];
        fsx=sx.*mod;
        fsy=sy.*mod;
        ftemp(x,y)=sqrt((sum(fsx(:)))^2+(sum(fsy(:)))^2);
    end
end
fr=im2uint8(ftemp);
figure,imshow(fr);
title('用roberts算子边缘检测的原始图像');
%%%域值分割%%%
TH1=110;  
%设定阈值
for x=2:1:rowhigh-1    
    for y=2:1:colhigh-1        
        if (fr(x,y)>=TH1)&&((fr(x,y-1) <= fr(x,y)) && (fr(x,y) > fr(x,y+1)) )
            fr(x,y)=255;      
        elseif(fr(x,y)>=TH1)&&( (fr(x-1,y) <=fr(x,y)) && (fr(x,y) >fr(x+1,y)))          
            fr(x,y)=255;      
        else fr(x,y)=0;        
        end
    end
end
figure,imshow(~im2bw(fr));
title('用roberts算子边缘检测并细化后的图像');
