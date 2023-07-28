% 使用相对密度的概念，提取低密度区域的�?有点�?
clc;clear;close all
load ('Compound.mat');
%% parameters setting
k=5;% for knn
t=0.7;% for selecting low density data
epsilon=1.5; % for dbscan
MinPts=3; % for dbscan
%%
D = pdist(data);
Simi=squareform(D);
for i=1:size(Simi,1)
    Simi(i,i)=inf;
end
[sdismat,index] = sort(Simi,2);% sort them in ascending order to obtian KNN
index=index(:,1:k);
for i=1:size(data,1)
    knndensity(i)=k/sum(Simi(i,index(i,:)));
end
x=data(:,1);
y=data(:,2);
figure(1)  
for i=1:size(data,1)
    txt={i};
    text(data(i,1),data(i,2),txt,'FontSize',8);
    hold on;
end
hold off
figure(2)
scatter(1:size(data,1),knndensity)
hold on
for i=1:size(data,1)
    txt={i};
    text(i,knndensity(i),txt,'FontSize',8);
    hold on;
end
data_lowdensity=find(knndensity<=t);
data_low=data(data_lowdensity,:);
label_low=label(data_lowdensity);
hold off
% figure(4);
% drawgraph(label_low,data_low);

hold off
%% 聚类低密度数�?
Clust_low=cell(1,length(label_low));

iter=1;
% 低密度数据聚�?
for i=1:length(label_low)
    for j=i+1:length(label_low)
        if intersect(index(data_lowdensity(i),:),index(data_lowdensity(j),:))
            Clust_low{iter}=unique([Clust_low{iter},i,j]);
            
        end
    end
    iter=iter+1;
end

% continue to merge
co2=Clust_low;
for i=1:100
    delrec=[];
    for i=1:size(co2,2)
        for j=i+1:size(co2,2)
            if length(intersect(co2{i}, co2{j} ))>=1%共享共线点大�?1
                co2{i}=unique([co2{i},co2{j}]);
                co2{j}=[];
                delrec=[delrec
                    j];
            end
        end
    end
    if isempty(delrec)%如果不再进行聚合
        break;
    end
    %删除co2�?有空格�??
    co2(delrec)=[];
    delrec=[];
end

% 获取低密度数据的聚类结果
Clust_low=[];
for j=1:length(label_low)
    for i=1:length(co2)
        if find(co2{i}==j)
            Clust_low(j)=i;
        end
    end
end
% 对snn聚类聚类结果进行判断，点相对少的是edge points,点相对多的是低密度类
for i=1:length(co2)
    num_co2(i)=length(co2{i});
end
idx=zeros(length(label),1);
% cluster_low_order=data_lowdensity(co2{find (num_co2>=mean(num_co2))});
cluster_low_order=data_lowdensity(co2{find(num_co2>=sum(num_co2)/length(find(num_co2~=0)))});

for i=1:length(cluster_low_order)
    idx(cluster_low_order(i))=200;% �?有低密度类的数据点的标签都设置为200
end
data_order=[1:length(label)];
data_remain=setdiff(data_order,cluster_low_order);
data_high=data(data_remain,:);
%% dbscan 聚类高密度数�?

Clust_high=DBSCAN(data_high,epsilon,MinPts);
idx(data_remain)=Clust_high;
% 将噪声点分配给最近的dbscan类�??
noise=data_remain(find(Clust_high==100));
non_noise_and_low=setdiff(data_remain,noise);
simi_noise_nonnoise=Simi(noise,non_noise_and_low);
[val,pos]=min(simi_noise_nonnoise,[],2);
for i=1:length(noise)
    pos_order=non_noise_and_low(pos);
    idx(noise(i))=idx(pos_order(i));
end
figure(6);
drawgraph(idx,data);
Evaluation(label,idx);
% figure(7);
% drawgraph(label,data);
  



