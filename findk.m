% 使用相对密度的概念，提取低密度区域的�?有点�?
clc;clear;close all
%addpath('D:\mega\work\evaluation', 'D:\mega\work\Complicate','D:\mega\work\UCI','D:\mega\work\drawGraph');
%addpath 'F:\mega\work\Clustering-Datasets-master\01. UCI'
load ('Aggregation.mat');
%% parameters setting
k=100;% for knn
t=0.5;
epsilon=2; % for dbscan
MinPts=10; % for dbscan
%% ����ܶȲ���
D = pdist(data);
Simi=squareform(D);%�õ��������
for i=1:size(Simi,1)
    Simi(i,i)=inf;
end%�����ݵ����Լ��ľ�����Ϊ���������������ܶ�ʱ���Լ����ȥ
[sdismat,index] = sort(Simi,2);
%��ÿһ�е����ݰ����������γ��µľ���index��ʾ�¾���ÿ��������ԭ���������е�λ�� to obtian KNN
index=index(:,1:k);%����ѹ��Ϊǰ���У���ȡ���ݵ��k���ڵ�λ����ԭ��������е�������
for i=1:size(data,1)
    knndensity(i)=k/sum(Simi(i,index(i,:)));
end%��ÿ���������ܶ�
x=data(:,1);
y=data(:,2);%���ݵ��һ�к͵ڶ���
figure(1)  
for i=1:size(data,1)
    txt={i};
    text(data(i,1),data(i,2),txt,'r',8);%������ͼ����˵��������
    hold on;
end%���ԭͼ��ÿ�����λ��������˳���ǩ
% xlim([5 45]);
% ylim([4 24]);
hold off
figure(2)
scatter(1:size(data,1),knndensity)%����ÿ���������ܶȵ�ɢ��ͼ,10,'k','filled'
hold on
for i=1:size(data,1)
    txt={i};
    text(i,knndensity(i),txt,'FontSize',8);
    hold on;
end