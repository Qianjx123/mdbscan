clc;clear;close all
%addpath('D:\mega\work\evaluation', 'D:\mega\work\Complicate','D:\mega\work\UCI','D:\mega\work\drawGraph');
%addpath 'F:\mega\work\Clustering-Datasets-master\01. UCI'
load ('Jain.mat');
%% parameters setting
k=38;% for knn
t=0.35;% for selecting low density data
epsilon=2.2; % for dbscan
MinPts=14; % for dbscan
%% ����ܶȲ���
D = pdist(data);
Simi=squareform(D);%�õ��������
for i=1:size(Simi,1)
    Simi(i,i)=inf;
end%�����ݵ����Լ��ľ�����Ϊ���������������ܶ�ʱ���Լ����ȥ
[sdismat,index] = sort(Simi,2);
%��ÿһ�е����ݰ����������γ��µľ���index��ʾ�¾���ÿ��������ԭ���������е�λ�� to obtian KNN
index=index(:,1:k);%����ѹ��Ϊǰk�У���ȡ���ݵ��k���ڵ�λ����ԭ��������е�������
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
 xlim([0 45]);
 ylim([0 30]);
hold off
figure(2)
scatter(1:size(data,1),knndensity)%����ÿ���������ܶȵ�ɢ��ͼ
hold on
for i=1:size(data,1)
    txt={i};
    text(i,knndensity(i),txt,'FontSize',8);
    hold on;
end%���ɢ��ͼ��ÿ�����λ�������˳���ǩ
data_lowdensity=find(knndensity<=t);%�ҵ�����ܶ�С��t�ĵ������
data_low=data(data_lowdensity,:);%�ҳ����ܶȵ�

label_low=label(data_lowdensity);%�ҳ����ܶȵ��ԭ����
hold off
figure(4);
drawgraph(label_low,data_low);
figure(5);
drawgraph(label,data);
hold off
%% ������ܶȵ������ܶ�
nD = pdist(data_low);
nSimi=squareform(nD);%�õ��������
for i=1:size(nSimi,1)
    nSimi(i,i)=inf;
end%�����ݵ����Լ��ľ�����Ϊ���������������ܶ�ʱ���Լ����ȥ
[nsdismat,nindex] = sort(nSimi,2);
%��ÿһ�е����ݰ����������γ��µľ���index��ʾ�¾���ÿ��������ԭ���������е�λ�� to obtian KNN
nindex=nindex(:,1:k);%����ѹ��Ϊǰk�У���ȡ���ݵ��k���ڵ�λ����ԭ��������е�������
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

% B=newdata(:,1);%BΪ������ֵ
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









