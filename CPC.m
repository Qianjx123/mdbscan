clc;clear;close all
addpath('D:\mega\work\evaluation', 'D:\mega\work\Complicate','D:\mega\work\UCI','D:\mega\work\drawGraph');
addpath('D:\mega\work\Celldata');
%load ('yeast.mat');
load ('compound.mat');
k=2;
D = pdist(data);
Simi=squareform(D);
for i=1:size(Simi,1)
    Simi(i,i)=inf;
end
[sdismat,index] = sort(Simi,2);% sort them in ascending order to obtian KNN
index=index(:,1:k);
for i=1:size(data,1)
    kdist(i)=Simi(i,[index(i,k)]);
end
for i=1:size(data,1)
    for j=1:size(data,2)
        Simi(i,j)=max(Simi(i,j),kdist(j));
    end
end
%%
for i=1:size(data,1)
    knndensity(i)=k/sum(Simi(i,index(i,:)));
end
%% 参数设置
percent=0.4% 即取2%比例0的所有的两点间的距离（排序好的
shapeset =data;
distset = computeSimi(shapeset);% 欧式距离矩阵计算
dc = computeDc(distset, percent);% 计算dc值
% dc=1.0977
knndensity = getLocalDensity(distset, dc);%计算每个点的局部密度
[deltas, nneigh] = getDistanceToHigherDensity(distset, knndensity);% 计算另外一个参数deltas
f=figure; 
set(gca,'looseInset',[0 0 0 0]);
plot(knndensity(:),deltas(:),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k');
xlim([0,max(knndensity)+2])
ylim([0,max(deltas)+2])
rect = getrect(f); %用鼠标圈一个矩形，并将所画矩形的[minx,miny,width,height]存储在rect中
hold on;
rectangle('position',rect,'edgecolor','r','LineWidth',3)
xlabel ('\rho')
ylabel ('\delta')
min_rho   = rect(1);
min_delta = rect(2);
filter = (knndensity > min_rho) & (deltas > min_delta);%获取被选中的点
cluster_num = sum(filter)%获取多少点，即簇中心个数
ords = find(filter);%存储了哪些点是类中心
trueords=ords;%保存一下类中心
cluster = zeros(size(knndensity));% 与数据个数同形的1维0向量，保存每个点的类标号
color = 1;
for i = 1:size(ords, 2)
    cluster(ords(i)) = color;% 簇中心都变成1,2,3,4......类标号
    color = color + 1;
end
%% 分配各个点到 类中心，每个点分配到离它最近的类簇中心。
[sorted_rhos, rords] =  sort(knndensity, 'descend');%局部密度降序排列 rords是索引位置
for i = 1:size(rords, 2) % 对于所有的点进行遍历，顺序是局部密度从大到小
    if cluster(rords(i)) == 0% 如果当前的点不是类中心，那么开始分配给中心
        neigh_cluster = cluster(nneigh(rords(i)));
        assert(neigh_cluster ~= 0, 'neigh_cluster has not assign!');
        cluster(rords(i)) = neigh_cluster;% 改变当前点的类标号
    end
end
figure;
drawgraph(cluster',data);
set(gca,'looseInset',[0 0 0 0]);
Evaluation(label,cluster');

