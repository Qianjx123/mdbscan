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
%  xlim([0 45]);
%  ylim([0 30]);
figure(5);
drawgraph(label,data);
%  xlim([0 45]);
%  ylim([0 30]);
hold off

Clust_low=cell(1,length(label_low));%����һ��1*size�����ܶȵ���55����Ԫ������

iter=1;

for i=1:length(label_low)%1��55
    for j=i+1:length(label_low)%i+1��55
        if intersect(index(data_lowdensity(i),:),index(data_lowdensity(j),:))
            %index(data_lowdensity(i),:)��ʾ���ܶȵ��k���ھ������ݼ��е�λ��
            %��������k���ھӴ��ڽ���
            Clust_low{iter}=unique([Clust_low{iter},i,j]);
            %��Ԫ�������i��λ�ô�� ���i�����ݵ�ӵ����ͬ��k���ھ� �ĵ��ܶ����ݵ�
        end
    end
    iter=iter+1;
end%���һ�����ݵ�û������ӵ�й�ͬ��k���ھӵĵ㣬��������Ԫ������Ϊ�գ���λ�ã�û���ݣ�

% continue to merge�����ϲ��ҳ����ĵ��ܶȵ�(�ų��쳣ֵ)
co2=Clust_low;
for i=1:10000
    delrec=[];%��ʼ������
    for i=1:size(co2,2)%1��size(co2,2)ѭ��
        for j=i+1:size(co2,2)%i+1��size(co2,2)ѭ��
            if length(intersect(co2{i}, co2{j} ))>=1%���i��j����Ԫ������Ľ�������1
                co2{i}=unique([co2{i},co2{j}]);
                co2{j}=[];
                %j���еĺϲ���i��������j���ÿ�(ֻɾ������)���ⲿѭ����j��ʱ��ֱ������
                delrec=[delrec
                    j];%�������ÿյ�cell����delrec����
            end%����ڲ���co2�����ݣ���ֱ����һ��ѭ����λ��Ҳ���ᱻɾ��
        end
    end
    
    if isempty(delrec)%û����Ҫ�ϲ��ľ�����ѭ��
        break;
    end  
    %删除co2�?有空格�??
 
    co2(delrec)=[];%����delrec��cell��λ��ɾ��
    delrec=[];
    
end

% 获取低密度数据的聚类结果
Clust_low=[];
for j=1:length(data_low)%1��x(���ܶȵ����)��ѭ��
    for i=1:length(co2)
        if find(co2{i}==j)%�����i��Ԫ���������е�j�����ܶȵ�
            Clust_low(j)=i;%��j��λ�ô��뵱ǰ���ܶȵ����ڵ�Ԫ�������λ��
        end
    end
end
% 对snn聚类聚类结果进行判断，点相对少的是edge points,点相对多的是低密度类

for i=1:length(co2)
    num_co2(i)=length(co2{i});
end%��ʾÿ��Ԫ�����������ݵ�ĸ���
idx=zeros(length(label),1);%����һ���;����ǩ��Сһ���Ŀ�����
%�޸�sum(num_co2)/length(find(num_co2~=0))
% cluster_low_order=data_lowdensity(co2{find (num_co2>=mean(num_co2))});
cluster_low_order=data_lowdensity(co2{find(num_co2>sum(num_co2)/length(find(num_co2~=0)))});
%cluster_low_order=data_lowdensity(co2{find(num_co2==max(num_co2))});

%find (num_co2>=mean(num_co2))�ҵ�Ԫ�����������ݵ���������ƽ��ֵ��Ԫ������
%co2{find (num_co2>=mean(num_co2))}��ʾ��һ�е�Ԫ�������ڵ����ݵ��ڵ��ܶȵ��еĴ���
%data_lowdensity(co2{find
%(num_co2>=mean(num_co2))})�ҵ�����һ�е�Ԫ�������ڵ����ݵ����������ݵ��еĴ���
for i=1:length(cluster_low_order)
    idx(cluster_low_order(i))=200;% �?有低密度类的数据点的标签都设置为200
end%���������������ĵ�ľ����ǩ����Ϊ200�����ܶȵ��Գ�һ�ࣩ
figure(6);
drawgraph(idx(cluster_low_order),data(cluster_low_order,:));
%  xlim([0 45]);
%  ylim([0 30]);
data_order=1:length(label);%=1:size(data,1)
data_remain=setdiff(data_order,cluster_low_order);
%���еĴ����ȥ���������ĵ��ܶȵ���ԭ���ݼ��еĴ���ʣ������DBSCAN�����ݵ�Ĵ��򣨸��ܶȵ��Լ������������ĵ��ܶȵ㣩
data_high=data(data_remain,:);%�õ����ܶȵ����ݼ�data_remainΪdata_high��ԭ���ݼ��е�λ��
newdata=data(cluster_low_order,:);
A=data_low(:,1);
b=newdata(:,1);
[tf, weizhi] = ismember(b, A);
new_low=label_low;
new_low(weizhi)=200;
for i=1:size(label_low,1)
    if label_low(i)==0;
        label_low(i)=100
    end
end
Evaluation(label_low,new_low);


%% dbscan 聚类高密度数�?
%�ڸ��ܶȵ����ݼ�������DBSCAN
% Clust_high=DBSCAN(data_high,epsilon,MinPts);