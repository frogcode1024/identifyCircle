function [x_min,y_min,x_max,y_max] = ReturnCutSize(rgb)
%clear all
%rgb = imread('11.jpg');
gray_image = rgb2gray(rgb);
[m,n]=size(gray_image);
%% 处理大圆，大圆填黑
for i=1:m
    for j=1:n
        if gray_image(i,j)<50
            gray_image(i,j)=0;
        else
            gray_image(i,j)=gray_image(i,j)*2;
        end
    end
end
%imwrite(gray_image,'black_circle.jpg');

%% 初始化参数
A = [0,0,0,0];
B = [1,2,0,0,7,4,0,0,5];

%black_circle = imread('black_circle.jpg');
black_circle = gray_image;
%[m,n] = size(black_circle);
many_function = ManyFunction;

%% 求y的最大、最小
k = 0;
y_min = 0;
A = zeros(1,floor(4*n/9));
for i = 1:m
    
    B = black_circle(i,:);
    k = many_function.if_sub_matrix(A,B);
    if k == 1
        y_min = i;
        break;
    end
end

k = 0;
y_max = m;
A = zeros(1,floor(n/3));
for i = 1:m
 
    B = black_circle(m+1-i,:);
    k = many_function.if_sub_matrix(A,B);
    if k == 1
        y_max = m+1-i;
        break;
    end
end

%% 求x的最大、最小
k = 0;
x_min = 0;
A = zeros(1,floor(m/4));
for i = 1:n
    B = black_circle(:,i)';
    k = many_function.if_sub_matrix(A,B);
    if k == 1
        x_min = i;
        break;
    end
end

k = 0;
x_max = n;
A = zeros(1,floor(m/4));
for i = 1:n
    B = black_circle(:,n+1-i)';
    k = many_function.if_sub_matrix(A,B);
    if k == 1
        x_max = n+1-i;
        break;
    end
end
%% 截取图像
cc =imcrop(black_circle,[x_min y_min x_max-x_min y_max-y_min]);
%imshow(cc);
end