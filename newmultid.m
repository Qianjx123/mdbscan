clc;clear;close all
%addpath('D:\mega\work\evaluation', 'D:\mega\work\Complicate','D:\mega\work\UCI','D:\mega\work\drawGraph');
%addpath 'F:\mega\work\Clustering-Datasets-master\01. UCI'
load ('Compound.mat');
%% parameters setting
k=5;% for knn
t=0.7;% for selecting low density data
epsilon=1.3; % for dbscan
MinPts=3; % for dbscan
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
 xlim([5 45]);
 ylim([4 24]);
% hold off
figure(2)
scatter(1:size(data,1),knndensity)%画出每个点的相对密度的散点图
xlabel('samples index','Fontangle','italic','FontSize',15);
ylabel('rd','Fontangle','italic','FontSize',15);
hold on
for i=1:size(data,1)
    txt={i};
    text(i,knndensity(i),txt,'FontSize',8);
    hold on;
end%标出散点图中每个点的位置上添加顺序标签
data_lowdensity=find(knndensity<=t);%找到相对密度小于t的点的索引
data_low=data(data_lowdensity,:);%找出低密度点

label_low=label(data_lowdensity);%找出低密度点的原分类
% hold off
figure(4);
drawgraph(label_low,data_low);
% xlim([5 45]);
% ylim([4 24]);
figure(5);
drawgraph(label,data);
%  xlim([0 45]);
%  ylim([0 30]);
% hold off

Clust_low=cell(1,length(label_low));%建立一个1*size（低密度点数55）的元胞数组

iter=1;

for i=1:length(label_low)%1到55
    for j=i+1:length(label_low)%i+1到55
        if intersect(index(data_lowdensity(i),:),index(data_lowdensity(j),:))
            %index(data_lowdensity(i),:)表示低密度点的k近邻居在数据集中的位置
            %如果两点的k近邻居存在交集
            Clust_low{iter}=unique([Clust_low{iter},i,j]);
            %则元胞数组第i个位置存放 与第i个数据点拥有相同的k近邻居 的低密度数据点
        end
    end
    iter=iter+1;
end%如果一个数据点没有与它拥有共同的k近邻居的点，那这个点的元胞数组为空（有位置，没内容）

% continue to merge继续合并找出来的低密度点(排除异常值)
co2=Clust_low;
for i=1:10000
    delrec=[];%初始化矩阵
    for i=1:size(co2,2)%1到size(co2,2)循环
        for j=i+1:size(co2,2)%i+1到size(co2,2)循环
            if length(intersect(co2{i}, co2{j} ))>=1%如果i和j两个元胞数组的交集大于1
                co2{i}=unique([co2{i},co2{j}]);
                co2{j}=[];
                %j表中的合并到i表，并即将j表置空(只删除内容)，外部循环到j次时则直接跳过
                delrec=[delrec
                    j];%将该轮置空的cell加入delrec数组
            end%如果内部的co2无内容，则直接下一次循环且位置也不会被删掉
        end
    end
    
    if isempty(delrec)%没有需要合并的就跳出循环
        break;
    end  
    %鍒犻櫎co2鎵?鏈夌┖鏍笺??
 
    co2(delrec)=[];%将第delrec个cell的位置删除
    delrec=[];
    
end

% 鑾峰彇浣庡瘑搴︽暟鎹殑鑱氱被缁撴灉
Clust_low=[];
for j=1:length(data_low)%1到x(低密度点个数)次循环
    for i=1:length(co2)
        if find(co2{i}==j)%如果第i个元胞数组里有第j个低密度点
            Clust_low(j)=i;%第j个位置存入当前低密度点属于的元胞数组的位置
        end
    end
end
% 瀵箂nn鑱氱被鑱氱被缁撴灉杩涜鍒ゆ柇锛岀偣鐩稿灏戠殑鏄痚dge points,鐐圭浉瀵瑰鐨勬槸浣庡瘑搴︾被
% cluster_low_order=[];

%% 已修改原版见test1
if isempty(co2)==0
  for i=1:length(co2)
      num_co2(i)=length(co2{i});
  end%表示每个元胞数组里数据点的个数
  cluster_low_order=data_lowdensity(co2{find(num_co2>=sum(num_co2)/length(find(num_co2~=0)))});%
else
  cluster_low_order=[];
end
idx=zeros(length(label),1);%建立一个和聚类标签大小一样的空数组

%修改sum(num_co2)/length(find(num_co2~=0))
% cluster_low_order=data_lowdensity(co2{find (num_co2>=mean(num_co2))});




%cluster_low_order=data_lowdensity(co2{find(num_co2==max(num_co2))});

%find (num_co2>=mean(num_co2))找到元胞数组内数据点数量高于平均值的元胞数组
%co2{find (num_co2>=mean(num_co2))}表示上一行的元胞数组内的数据点在低密度点中的次序
%data_lowdensity(co2{find
%(num_co2>=mean(num_co2))})找到上上一行的元胞数组内的数据点在所有数据点中的次序
for i=1:length(cluster_low_order)
    idx(cluster_low_order(i))=200;% 鎵?鏈変綆瀵嗗害绫荤殑鏁版嵁鐐圭殑鏍囩閮借缃负200
end%将满足上述条件的点的聚类标签均设为200（低密度点自成一类）
figure(6);
drawgraph(idx(cluster_low_order),data(cluster_low_order,:));
%  xlim([0 45]);
%  ylim([0 30]);
data_order=1:length(label);%=1:size(data,1)
data_remain=setdiff(data_order,cluster_low_order);
%所有的次序减去符合条件的低密度点在原数据集中的次序，剩下用于DBSCAN的数据点的次序（高密度点以及不符合条件的低密度点）
data_high=data(data_remain,:);%得到高密度点数据集data_remain为data_high在原数据集中的位置
%% dbscan 鑱氱被楂樺瘑搴︽暟鎹?
%在高密度点数据集上运行DBSCAN
Clust_high=DBSCAN(data_high,epsilon,MinPts);
idx(data_remain)=Clust_high;%给剩余点标上标签
figure(7);
drawgraph(Clust_high,data_high);
% 灏嗗櫔澹扮偣鍒嗛厤缁欐渶杩戠殑dbscan绫汇??
noise=data_remain(find(Clust_high==100));%找出DBSCAN算法找出来的噪音点在元数据集的位置
non_noise_and_low=setdiff(data_remain,noise);
%在用于DBSCAN的数据集中排除噪音点，留下既不是噪音点又不是低密度点在原数据集中的位置
simi_noise_nonnoise=Simi(noise,non_noise_and_low);%得到噪音点和点（既不是噪音点又不是低密度点）的距离矩阵
[val,pos]=min(simi_noise_nonnoise,[],2);%找出上述距离矩阵每一行的最小值，并返回最小值在每一行的位置
for i=1:length(noise)
    pos_order=non_noise_and_low(pos);
    idx(noise(i))=idx(pos_order(i));
end%将噪音点分配给离他最近的点所在的聚类
figure(8);
drawgraph(idx,data);
Evaluation(label,idx);
% figure(7);
% drawgraph(label,data);




finall=length(unique(idx));
finalll=length(unique(label));
fprintf('聚类个数：%d \n',finall);
fprintf('聚类实际个数：%d \n',finalll);



