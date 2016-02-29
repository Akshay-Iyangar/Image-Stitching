function[H]=computeH(ref,img);
A=zeros(8,9);
[row,col]=size(ref);
%form the A matrix 
j=1;
for i=1:2:(2*col)
    
    A(i,1)=-img(1,j);
    A(i,2)=-img(2,j);
    A(i,3)=-1;
    A(i,7)=ref(1,j)*img(1,j);
    A(i,8)=img(2,j)*ref(1,j);
    A(i,9)=ref(1,j);
    A(i+1,4)= -img(1,j);
    A(i+1,5)= -img(2,j);
    A(i+1,6)=-1;
    A(i+1,7)=img(1,j)*ref(2,j);
    A(i+1,8)=ref(2,j)*img(2,j);
    A(i+1,9)=ref(2,j);
    j=j+1;
end
[U S V]=svd(A);
x=V(:,end);
H=reshape(x,[3,3]);