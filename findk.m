% 浣跨敤鐩稿瀵嗗害鐨勬蹇碉紝鎻愬彇浣庡瘑搴﹀尯鍩熺殑鎵?鏈夌偣銆?
clc;clear;close all
%addpath('D:\mega\work\evaluation', 'D:\mega\work\Complicate','D:\mega\work\UCI','D:\mega\work\drawGraph');
%addpath 'F:\mega\work\Clustering-Datasets-master\01. UCI'
load ('Aggregation.mat');
%% parameters setting
k=100;% for knn
t=0.5;
epsilon=2; % for dbscan
MinPts=10; % for dbscan
%% 相对密度部分
D = pdist(data);
Simi=squareform(D);%得到距离矩阵
for i=1:size(Simi,1)
    Simi(i,i)=inf;
end%将数据点与自己的距离设为无穷，，避免算近邻密度时将自己算进去
[sdismat,index] = sort(Simi,2);
%将每一行的数据按升序排列形成新的矩阵，index表示新矩阵每行数字在原本矩阵行中的位置 to obtian KNN
index=index(:,1:k);%索引压缩为前两列（即取数据点的k近邻的位置在原距离矩阵中的索引）
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
% xlim([5 45]);
% ylim([4 24]);
hold off
figure(2)
scatter(1:size(data,1),knndensity)%画出每个点的相对密度的散点图,10,'k','filled'
hold on
for i=1:size(data,1)
    txt={i};
    text(i,knndensity(i),txt,'FontSize',8);
    hold on;
end