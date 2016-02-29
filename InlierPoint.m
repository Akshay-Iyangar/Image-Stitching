
%function used to get the inliner points
function [final_inliner_ref,final_inliner_img]=InlierPoint(img_ref,image_cores,inliners)
[row_inliner,column_inliner]=size(inliners);

for i=1:row_inliner
    if sum(inliners(i,:)~=0)==column_inliner
        index_inliner=i;
    
    end
end

%find the corresponding points now on image and ref points 
final_inliners=inliners(index_inliner,:);
final_inliner_img=zeros(2,column_inliner);
final_inliner_ref=zeros(2,column_inliner);
for i=1:column_inliner
    
 final_inliner_img(1,i)=image_cores(1,final_inliners(i));
 final_inliner_img(2,i)=image_cores(2,final_inliners(i));
 final_inliner_ref(1,i)=img_ref(1,final_inliners(i));
 final_inliner_ref(2,i)=img_ref(2,final_inliners(i));
    
end