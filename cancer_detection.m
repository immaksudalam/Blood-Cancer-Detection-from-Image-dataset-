clc;
close all;
clear all;

OutputFolder = 'C:\Users\Maksud Alam Rony\Documents';  
dinfo = dir('*.jpg');

x = length(dinfo);
disp(x);

 for K = 1 : length(dinfo)
   thisimage = dinfo(K).name;
   I   = imread(thisimage);

   I=  imresize(I,[300,400]);
   Gray  = rgb2gray(I);
   rgb = imopen(I,strel('disk',1));
   size(I)
  
  imshow(I)
  
  
  
  
  figure;
  imshow(rgb);
  gray_image = rgb2gray(rgb);
  imshow(gray_image);
  title('background');

  [centers, radii] = imfindcircles(rgb,[2 80],'ObjectPolarity','dark','Sensitivity',0.9);
  imshow(rgb);

  cell = length(centers);
  M = mean(radii);
  Max = max(radii);

  h = viscircles(centers,radii);

  red= rgb(:,:,1); green= rgb(:,:,2);  blue= rgb(:,:,3);

  out = red>25 & red<199 &green<130 & blue>140 & blue<225;

  out1 = imfill(out,'holes');
  
  out2= bwmorph(out1,'erode');

  out3 = bwmorph(out2,'dilate',1.2);
  
  out3 = imfill(out3,'holes');
  
  out3 = bwareaopen(out3, 100);

  figure;
  imshow(out3);
  title('Cancer cells')
  
  out3 = im2bw(out3);
  [l,NUM] = bwlabel(out3, 4);

  cancer = (NUM/cell)*100;
  
  disp('Myeloid cells percentage is')
    disp(cancer);
  if cancer<0.8
    disp('Healthy. No Problem');
  elseif cancer<1 & cancer>0.8
        disp('High myeloid cell concentration.');

    elseif cancer > 1 & cancer < 8
            disp('Initial Stage Leukemia');
        
        elseif cancer > 8
                disp('Advanced Stage Leukemia');
            
  end
  pause(20);
end