function many_function = ManyFunction
many_function.if_sub_matrix = @if_sub_matrix;
many_function.Circle_Region_Extract = @Circle_Region_Extract;
end
%% �ж��Ƿ��Ӿ���
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

%% ��ȡԲ��һ����ͼ
function IMG_Out=Circle_Region_Extract(IMG_In,Radius,Center)
 
%IMG_In  ������ͼ�񣬿����ǻҶ�ͼ��Ҳ����ʹRGB��ʽ�Ĳ�ɫͼ
%Radius  Ҫ��ȡԲ������İ뾶ֵ
%Center  Բ�ĵ����꣬Center��1��Ϊx���꣬Center��2��Ϊy���꣬CenterΪ1x2�ṹ
%IMG_Out ���ͼ��
 
 
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
