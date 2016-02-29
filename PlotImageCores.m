function PlotImageCores(image_ref_correspondence,image_correspondence,img)

figure;clf;imagesc(img);hold on;
%show feature detected in image_ref 1
plot (image_correspondence(1,:),image_correspondence(2,:),'+g');
%show displacements
line([image_correspondence(1,:);image_ref_correspondence(1,:)],[image_correspondence(2,:);image_ref_correspondence(2,:)],'color','y');

