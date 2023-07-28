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
%% ��������
percent=0.4% ��ȡ2%����0�����е������ľ��루����õ�
shapeset =data;
distset = computeSimi(shapeset);% ŷʽ����������
dc = computeDc(distset, percent);% ����dcֵ
% dc=1.0977
knndensity = getLocalDensity(distset, dc);%����ÿ����ľֲ��ܶ�
[deltas, nneigh] = getDistanceToHigherDensity(distset, knndensity);% ��������һ������deltas
f=figure; 
set(gca,'looseInset',[0 0 0 0]);
plot(knndensity(:),deltas(:),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k');
xlim([0,max(knndensity)+2])
ylim([0,max(deltas)+2])
rect = getrect(f); %�����Ȧһ�����Σ������������ε�[minx,miny,width,height]�洢��rect��
hold on;
rectangle('position',rect,'edgecolor','r','LineWidth',3)
xlabel ('\rho')
ylabel ('\delta')
min_rho   = rect(1);
min_delta = rect(2);
filter = (knndensity > min_rho) & (deltas > min_delta);%��ȡ��ѡ�еĵ�
cluster_num = sum(filter)%��ȡ���ٵ㣬�������ĸ���
ords = find(filter);%�洢����Щ����������
trueords=ords;%����һ��������
cluster = zeros(size(knndensity));% �����ݸ���ͬ�ε�1ά0����������ÿ���������
color = 1;
for i = 1:size(ords, 2)
    cluster(ords(i)) = color;% �����Ķ����1,2,3,4......����
    color = color + 1;
end
%% ��������㵽 �����ģ�ÿ������䵽���������������ġ�
[sorted_rhos, rords] =  sort(knndensity, 'descend');%�ֲ��ܶȽ������� rords������λ��
for i = 1:size(rords, 2) % �������еĵ���б�����˳���Ǿֲ��ܶȴӴ�С
    if cluster(rords(i)) == 0% �����ǰ�ĵ㲻�������ģ���ô��ʼ���������
        neigh_cluster = cluster(nneigh(rords(i)));
        assert(neigh_cluster ~= 0, 'neigh_cluster has not assign!');
        cluster(rords(i)) = neigh_cluster;% �ı䵱ǰ�������
    end
end
figure;
drawgraph(cluster',data);
set(gca,'looseInset',[0 0 0 0]);
Evaluation(label,cluster');

