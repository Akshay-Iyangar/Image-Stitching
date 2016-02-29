%function used to perform mosacing of images

function [final_mosaic]=Mosaicing(ref,img,H)
bbox=[-400 1200 -200 700]%image space for mosaic
Im2w=vgg_warp_H(im2double(ref),eye(3),'linear',bbox);
Im2w=im2uint8(Im2w);
Im1w=vgg_warp_H(im2double(img),H','linear',bbox);
Im1w=im2uint8(Im1w);
% figure;
% imshow(Im1w);
[rowF,colF,K]=size(Im2w);
final_mosaic=zeros(rowF,colF,3);
for i=1:rowF
    for j=1:colF
        for k=1:K
            if Im2w(i,j,k)>Im1w(i,j,k)
                final_mosaic(i,j,k)=Im2w(i,j,k);
            elseif Im2w(i,j,k)<Im1w(i,j,k)
                final_mosaic(i,j,k)=Im1w(i,j,k);
            elseif Im2w(i,j,k)==Im1w(i,j,k)
                final_mosaic(i,j,k)=Im1w(i,j,k);
            end
        end
    end
end


