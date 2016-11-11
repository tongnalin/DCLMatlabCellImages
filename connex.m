function  [Number,Image]=connex(A) 

[m,n]=size(A); 
Image=double(A);          
seed=0; 
Number=1; 

for high=1:m 
    for width=1:n 
        K=zeros(1000,2);          
        if Image(high,width)==1   
             seed=1; K(seed,1)=high;K(seed,2)=width; 
            Number=Number+1; 
            Image(high,width)=Number; 
        end 
        while seed~=0 
            H=K(seed,1);W=K(seed,2); 
            seed=seed-1; 
             for i=-1:1 
               for j=-1:1 
                    if H+i>=1 && W+j>=1 && H+i<=m && W+j<=n && Image(H+i,W+j)==1;  
                       Image(H+i,W+j)=Number; 
                       seed=seed+1; 
                      K(seed,1)=H+i; K(seed,2)=W+j; 
                   end  
               end  
            end  
         end  
     end  
 end  
  
 Number=Number-1;
end