function [inliners]=RANSAC(img_ref,image_cores)

N=1;
while N<50
[r,c]=size(img_ref);
index=randperm(c,4);
ref=[img_ref(1,index(1)) img_ref(1,index(2)) img_ref(1,index(3)) img_ref(1,index(4));img_ref(2,index(1)) img_ref(2,index(2)) img_ref(2,index(3)) img_ref(2,index(4))];
%ref=[358 651 376 265;379 73 155 295];
img=[image_cores(1,index(1)) image_cores(1,index(2)) image_cores(1,index(3)) image_cores(1,index(4));image_cores(2,index(1)) image_cores(2,index(2)) image_cores(2,index(3)) image_cores(2,index(4))]; 
%calculate the homography
H=computeH(ref,img);
%calculate some of square differences and compare to threshold

%a=[ref(1,2) ref(2,2) 1]';
e=zeros(size(c));
count=1;
for i=1:c
    a=[image_cores(1,i) image_cores(2,i) 1];
    P=a*H;
    xmap=P(1)/P(3);
    ymap=P(2)/P(3);
    e(i)= sqrt((xmap-img_ref(1,i)).^2 + (ymap-img_ref(2,i)).^2);
    if e(i)< 3
       %save the index
       inliners(N,count)=i;
       count=count +1;
    end
    
end

N=N+1;
end