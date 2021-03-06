
%Image Stitching assignment

img1=imread('keble_a.jpg');

%set this image as the reference image.
ref_img2=imread('keble_b.jpg');

img2=imread('keble_c.jpg');

% find homography between img1 and ref image img2
%use harris and stephens corner detector to get the loacl features of the image.
[ref_a,ref_b,ref_c]=harris(ref_img2);
[a1,b1,c1]=harris(img1);
[a2,b2,c2]=harris(img2);
% now use the SIFT decriptor to get the descriptors of both the image 
% Only scale invariant not rotational invariant. Not needed for this
% assignment.
%find circles for ref and img_1
%radius of ref_img
radius_ref=repmat(3,size(ref_c),1);
%radius of img_1;
radius_img1=repmat(3,size(c1),1);
%radius of img3
radius_img2=repmat(3,size(c2),1);
%create a circle array of N*3 size for repmat
ref_circle=[ref_a,ref_b,radius_ref];
img1_circle=[a1,b1,radius_img1];
img2_circle=[a2,b2,radius_img2];

%use sift descriptors
sift_desc_ref=find_sift(ref_img2,ref_circle,2);
sift_desc_img1=find_sift(img1,img1_circle,2);
sift_desc_img2=find_sift(img2,img2_circle,2);   
%Match features between two images.
%use the dist2 function two find the 2-nearest neighbors
dist_ref_img1=dist2(sift_desc_ref,sift_desc_img1);
dist_ref_img2=dist2(sift_desc_ref,sift_desc_img2);

[row col]=size(dist_ref_img1);
[row1 col1]=size(dist_ref_img2);
%function for matching
[img_ref,image_cores]=matching_features(row,dist_ref_img1,ref_circle,img1_circle,img1);
[img_ref1,image_cores1]=matching_features(row1,dist_ref_img2,ref_circle,img2_circle,img2);
%Plot correspondence
PlotImageCores(img_ref,image_cores,img1);
PlotImageCores(img_ref1,image_cores1,img2);

%Use Ransac to get good amount of inliners.
inliners=RANSAC(img_ref,image_cores);
inliners1=RANSAC(img_ref1,image_cores1);
%Find inliner points for the image
[final_inliner_ref,final_inliner_img]=InlierPoint(img_ref,image_cores,inliners);
[final_inliner_ref1,final_inliner_img1]=InlierPoint(img_ref1,image_cores1,inliners1);

%Plot new inliner correspondence
PlotImageCores(final_inliner_ref,final_inliner_img,img1);
PlotImageCores(final_inliner_ref1,final_inliner_img1,img2);
%re-compute the homography using the points.
H_re=computeH(final_inliner_ref,final_inliner_img);
H_re1=computeH(final_inliner_ref1,final_inliner_img1);
%reproject on the image and do the image stitching 
final_mosaic=Mosaicing(ref_img2,img1,H_re);
final_mosaic=uint8(final_mosaic);
final_mosaic1=Mosaicing(ref_img2,img2,H_re1);
final_mosaic1=uint8(final_mosaic1);
final_image=Mosaicing(final_mosaic,final_mosaic1,eye(3));
[rowF,colF,K]=size(final_mosaic);
final_image=zeros(rowF,colF,3);
for i=1:rowF
    for j=1:colF
        for k=1:K
            if final_mosaic(i,j,k)>final_mosaic1(i,j,k)
                final_image(i,j,k)=final_mosaic(i,j,k);
            elseif final_mosaic(i,j,k)<final_mosaic1(i,j,k)
                final_image(i,j,k)=final_mosaic1(i,j,k);
            elseif final_mosaic(i,j,k)==final_mosaic1(i,j,k)
                final_image(i,j,k)=final_mosaic(i,j,k);
            end
        end
    end
end
figure;
imshow(uint8(final_image));