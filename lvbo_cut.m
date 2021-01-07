function lvbo_cut(path)

close all;

%% ����ԭʼͼ��
%rgb = imread('33.jpg');
rgb = imread(path);
zz = strsplit(path,'.');
%new_path = [zz{1},'_lvbo_cut.',zz{2}];
new_path = [strrep(zz{1},'origin_pic','temp_pic'),'_lvbo_cut.',zz{2}];
gray_image = rgb2gray(rgb);
%% ֱ��ͼ����
ImgIn=gray_image;
ImgHistEq=histeq(ImgIn,256);
% �Զ���ֱ��ͼ����
[counts,x]=imhist(ImgIn,256);
cum_counts=cumsum(counts);
cum_counts=uint8(cum_counts/max(cum_counts)*255);% ת������
ImgOut=nan(size(ImgIn));
for i=1:length(x)
    ImgOut(ImgIn==x(i))=cum_counts(i);
end
ImgOut=uint8(ImgOut);
%% �ü��˲����ͼ��
[x_min,y_min,x_max,y_max] = ReturnCutSize(rgb);
ImgOut_cut =imcrop(ImgOut,[x_min y_min x_max-x_min y_max-y_min]);
imshow(ImgOut_cut);
%imwrite(ImgOut_cut,'11_lvbo_cut.jpg');
imwrite(ImgOut_cut,new_path);
end