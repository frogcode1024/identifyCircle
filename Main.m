clc;
clear all;
warning('off');
file_path =  './origin_pic/';% ͼ���ļ���·��
img_path_list = dir(strcat(file_path,'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��
img_num = length(img_path_list);
 
if img_num > 0 
    for j = 1:img_num 
        image_name = img_path_list(j).name;
        fprintf('%d %s %s\n',j,'���ڴ���',strcat(file_path,image_name));% ��ʾ���ڴ����ͼ����
        path1 = strcat(file_path,image_name);
        path = strrep(path1,'./','');
        zz = strsplit(path,'.');
        %new_path = [zz{1},'_lvbo_cut.',zz{2}];
        new_path = [strrep(zz{1},'origin_pic','temp_pic'),'_lvbo_cut.',zz{2}];
        lvbo_cut(path);
        count = find_big91(new_path);
        content = [image_name,'  ��ԲȦ�ĸ�����  ',num2str(count)];
        fid=fopen('result.txt','a');%д�����ļ�·��
        fprintf(fid,'%s\r\n',content);
        fclose(fid);
    end
end
close all;
fprintf('%s\n' ,'�������');