function[image_ref_correspondence,image_correspondence]=matching_features(row,dist_ref_img,ref_circle,img_circle,img);

k=0;
for i=1:row
    sorted=sort(dist_ref_img(i,:));
    nearest_neighbor=sorted(1)/sorted(2);
    if(nearest_neighbor<0.45)
        k=k+1;
    end
end

image_ref_correspondence=zeros(2,k);
image_correspondence=zeros(2,k);
a=1;
for i=1:row
    sorted=sort(dist_ref_img(i,:));
    nearest_neighbor=sorted(1)/sorted(2);
    if(nearest_neighbor<0.45)
        image_cores=find(dist_ref_img(i,:)==min(dist_ref_img(i,:)),1); 
        image_ref_correspondence(1,a)=ref_circle(i,1);
        image_ref_correspondence(2,a)=ref_circle(i,2);
        image_correspondence(1,a)=img_circle(image_cores,1);
        image_correspondence(2,a)=img_circle(image_cores,2);
        a=a+1;
    end
end

