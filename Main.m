clc;
clear all;
warning('off');
file_path =  './origin_pic/';% 图像文件夹路径
img_path_list = dir(strcat(file_path,'*.jpg'));%获取该文件夹中所有jpg格式的图像
img_num = length(img_path_list);
 
if img_num > 0 
    for j = 1:img_num 
        image_name = img_path_list(j).name;
        fprintf('%d %s %s\n',j,'正在处理：',strcat(file_path,image_name));% 显示正在处理的图像名
        path1 = strcat(file_path,image_name);
        path = strrep(path1,'./','');
        zz = strsplit(path,'.');
        %new_path = [zz{1},'_lvbo_cut.',zz{2}];
        new_path = [strrep(zz{1},'origin_pic','temp_pic'),'_lvbo_cut.',zz{2}];
        lvbo_cut(path);
        count = find_big91(new_path);
        content = [image_name,'  白圆圈的个数：  ',num2str(count)];
        fid=fopen('result.txt','a');%写入结果文件路径
        fprintf(fid,'%s\r\n',content);
        fclose(fid);
    end
end
close all;
fprintf('%s\n' ,'处理完成');