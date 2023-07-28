clc;clear;close all
load ('2circles.mat');
% %% parameters setting
% k=55;% for knn
% t=0.15;% for selecting low density data
% epsilon=1.6; % for dbscan
% MinPts=10; % for dbscan
%% DBSCAN算法
% epsilon=0.1; 
% MinPts=24; 
% IDX=DBSCAN(data,epsilon,MinPts);
% D = pdist(data);
% Simi=squareform(D);%得到距离矩阵
t=1;
acc=[];
a=0;
inxi=0;
inxj=0;
for i=0:0.1:3
    for j=30:50
        IDX=DBSCAN(data,i,j);
        acc(t)=Copy_of_Evaluation(label,IDX);
        if acc(t)>a
            inxi=i;
            inxj=j;
            a=acc(t);
        end
        t=t+1;
    end
end
fprintf('epsilon：%5.4f   \n',inxi);
fprintf('minpts：%5.4f   \n',inxj);
fprintf('acc指标：%5.4f   \n',a);
IDX=DBSCAN(data,inxi,inxj);
Evaluation(label,IDX);
% for i=1:10
%   length(find(Simi(:,i)<epsilon))
% end
% drawgraph(IDX,data);




% Evaluation(label,IDX);
finall=length(unique(IDX));
finalll=length(unique(label));
fprintf('聚类个数：%d \n',finall);
fprintf('聚类实际个数：%d \n',finalll);
%% PACA-DBSCAN算法
% [labels] = pacadbscan(data,1.3,6,0.55);
% fprintf('PACA-DBSCAN算法： \n');
% Evaluation(label,labels);
%% AA-DBSCAN算法
% [clusterIds, coreIdx] = aa_dbscan(data,1,6);
% fprintf('AA-DBSCAN算法： \n');
% Evaluation(label,clusterIds);





% load('wpbc.mat','data')  %加载spectra_data.csv中的octane
% csvwrite('wpbc2.csv',data) %将octane里面的数据写入octane.csv中
% load('wpbc.mat','label')
% csvwrite('wpbclabel.csv',label)