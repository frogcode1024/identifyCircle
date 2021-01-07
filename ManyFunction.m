function many_function = ManyFunction
many_function.if_sub_matrix = @if_sub_matrix;
many_function.Circle_Region_Extract = @Circle_Region_Extract;
end
%% 判断是否子矩阵
function k = if_sub_matrix(A,B)
szA = size(A);
szB = size(B);
k = 0;

for j = 1:szB(2)-szA(2)+1
	if isequal(A, B(:,j:j+szA(2)-1))
        k = k+1;
        break;
	end
end
end

%% 提取圆到一张新图
function IMG_Out=Circle_Region_Extract(IMG_In,Radius,Center)
 
%IMG_In  是输入图像，可以是灰度图，也可以使RGB格式的彩色图
%Radius  要截取圆形区域的半径值
%Center  圆心的坐标，Center（1）为x坐标，Center（2）为y坐标，Center为1x2结构
%IMG_Out 输出图像
 
 
if ~(abs(Center(1)-Radius)<0 & abs(Center(2)-Radius)<0)
    [m,n,~]=size(IMG_In);
    [X,Y]=meshgrid(1:n,1:m);
    R_temp=sqrt((X-Center(1)).^2+(Y-Center(2)).^2);
    R_temp1=R_temp<=Radius;
    if(numel(size(IMG_In))>2)
        R_Out=R_temp1.*im2double(IMG_In(:,:,1));
        G_Out=R_temp1.*im2double(IMG_In(:,:,2));
        B_Out=R_temp1.*im2double(IMG_In(:,:,3));
        IMG_Out(:,:,1)=R_Out;
        IMG_Out(:,:,2)=G_Out;
        IMG_Out(:,:,3)=B_Out;
    else
        IMG_Out=R_temp1.*im2double(IMG_In); 
    end
else
    disp('exceed Radius');
end
end
%imshow(IMG_Out);
