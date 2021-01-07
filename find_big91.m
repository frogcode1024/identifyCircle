function count = find_big91(new_path)

%% Step 1: 导入图像
%afier_image = imread('11_lvbo_cut.jpg');
afier_image = imread(new_path);
imshow(afier_image)
[i_max,j_max] = size(afier_image);
%% Step 6: Use the Second Method (Two-stage) for Finding Circles
% [centers,radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark', ...
% 'Sensitivity',0.92,'Method','twostage');

% h = viscircles(centers,radii);
%59---65
%
[centers,radii] = imfindcircles(afier_image,[60 70],'ObjectPolarity','dark', ...
'Sensitivity',0.93,'Method','twostage');
% delete(h)
%viscircles(centers,radii);

%% 分成91张子图
many_function = ManyFunction;
count = 0;
for i = 1:91
    temp_zuobiao = centers(i,:);
    temp_banjing = radii(i)-0;
    img_out=many_function.Circle_Region_Extract(afier_image(:,:,1),temp_banjing,temp_zuobiao);
    url = ['abs_pic/result',num2str(i),'.jpg'];
    imwrite(img_out,url);
    img = imread(url);
    %img = img_out;
    %% 缩小尺寸  为66x66
    %ImgOut_cut =imcrop(ImgOut,[x_min y_min x_max-x_min y_max-y_min]);
    after_cut =imcrop(img,[temp_zuobiao(1)-50 temp_zuobiao(2)-50 140 140]);
    %% 调整颜色
    for i2 = 1:140
        for j = 1:140
            if after_cut(i2,j)<135
                after_cut(i2,j)=0;  
            else
                after_cut(i2,j)=1*after_cut(i2,j);
            end
        end
    
    end
    imwrite(after_cut,url);
    
    %% 进一步裁剪
    abs_abs_img = imread(url);
    [abs_centers,abs_radii] = imfindcircles(abs_abs_img,[30 40],'ObjectPolarity','bright', ...
    'Sensitivity',0.98,'Method','twostage');
%22222222222222222
%     i
%     abs_centers
%     abs_radii
%2222222222222222222
    if isempty(abs_centers) == 0
        abs_img_out=many_function.Circle_Region_Extract(abs_abs_img(:,:,1),abs_radii(1,:),abs_centers(1,:));
        imwrite(abs_img_out,url);
        
        %1111111111
        abs_img = imread(url);
        count_white = 0;
        [m,n]=size(abs_img);
        for ii =1:m
            for jj=1:n
                if abs_img(ii,jj)>0
                    count_white = count_white+1;
                end
            end
        end
    
        if count_white>floor(3*m*n/16)
            count = count+1;
            viscircles(temp_zuobiao,temp_banjing);
        end
        %11111111111
    end
    %% 不进一步裁剪，直接通过判断白点数量

%     abs_img = imread(url);
%     count_white = 0;
%     [m,n]=size(abs_img);
%     for ii =1:m
%         for jj=1:n
%             if abs_img(ii,jj)>0
%                 count_white = count_white+1;
%             end
%         end
%     end
%     
%     if count_white>floor(3*m*n/16)
%         count = count+1;
%         viscircles(temp_zuobiao,temp_banjing);
%     end
    
end
new_new_path = strrep(new_path,'temp_pic/','red_pic/');
f = getframe(gca);
imwrite(f.cdata, new_new_path, 'quality', 100);
end