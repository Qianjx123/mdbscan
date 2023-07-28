clc;clear;close all
%addpath('D:\mega\work\evaluation', 'D:\mega\work\Complicate','D:\mega\work\UCI','D:\mega\work\drawGraph');
%addpath 'F:\mega\work\Clustering-Datasets-master\01. UCI'
load ('Jain.mat');
%% parameters setting
k=38;% for knn
t=0.35;% for selecting low density data
epsilon=2.2; % for dbscan
MinPts=14; % for dbscan
%% 相对密度部分
D = pdist(data);
Simi=squareform(D);%得到距离矩阵
for i=1:size(Simi,1)
    Simi(i,i)=inf;
end%将数据点与自己的距离设为无穷，，避免算近邻密度时将自己算进去
[sdismat,index] = sort(Simi,2);
%将每一行的数据按升序排列形成新的矩阵，index表示新矩阵每行数字在原本矩阵行中的位置 to obtian KNN
index=index(:,1:k);%索引压缩为前k列（即取数据点的k近邻的位置在原距离矩阵中的索引）
for i=1:size(data,1)
    knndensity(i)=k/sum(Simi(i,index(i,:)));
end%求每个点的相对密度
x=data(:,1);
y=data(:,2);%数据点第一列和第二列
figure(1)  
for i=1:size(data,1)
    txt={i};
    text(data(i,1),data(i,2),txt,'r',8);%用来给图加上说明性文字
    hold on;
end%标出原图中每个点的位置上增加顺序标签
 xlim([0 45]);
 ylim([0 30]);
hold off
figure(2)
scatter(1:size(data,1),knndensity)%画出每个点的相对密度的散点图
hold on
for i=1:size(data,1)
    txt={i};
    text(i,knndensity(i),txt,'FontSize',8);
    hold on;
end%标出散点图中每个点的位置上添加顺序标签
data_lowdensity=find(knndensity<=t);%找到相对密度小于t的点的索引
data_low=data(data_lowdensity,:);%找出低密度点

label_low=label(data_lowdensity);%找出低密度点的原分类
hold off
figure(4);
drawgraph(label_low,data_low);
figure(5);
drawgraph(label,data);
hold off
%% 重算低密度点的相对密度
nD = pdist(data_low);
nSimi=squareform(nD);%得到距离矩阵
for i=1:size(nSimi,1)
    nSimi(i,i)=inf;
end%将数据点与自己的距离设为无穷，，避免算近邻密度时将自己算进去
[nsdismat,nindex] = sort(nSimi,2);
%将每一行的数据按升序排列形成新的矩阵，index表示新矩阵每行数字在原本矩阵行中的位置 to obtian KNN
nindex=nindex(:,1:k);%索引压缩为前k列（即取数据点的k近邻的位置在原距离矩阵中的索引）
for i=1:size(data_low,1)
    newknndensity(i)=k/sum(Simi(i,index(i,:)));
end%
low=newknndensity;
figure;
boxplot(low);
q= prctile(low,[25,75]);
Q1=q(1,1);
Q3=q(1,2);
IQR=Q3-Q1;
index=(low>Q3+1.5*IQR|low<Q1-1.5*IQR);
y=find(index==0);
newlow=low(y);
figure(6);
drawgraph(label_low(y),data_low(y,:));
new_low=label_low;
new_low(y)=200;
for i=1:size(label_low,1)
    if label_low(i)==0;
        label_low(i)=100;
    end
end
Evaluation(label_low,new_low);

% B=newdata(:,1);%B为横坐标值
% figure;
% boxplot(B);
% q= prctile(B,[25,75]);
% Q1=q(1,1);
% Q3=q(1,2);
% IQR=Q3-Q1;
% index=(B>Q3+1.5*IQR|B<Q1-1.5*IQR);
% y=find(index==0);
% newnewdata=data(y,:);
% newnewxx=newnewdata(:,1);
% newnewyy=newnewdata(:,2);
% figure;
% scatter(newnewxx,newnewyy,25,'filled');









