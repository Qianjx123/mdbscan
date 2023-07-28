function [clusterIds, coreIdx] = aa_dbscan(X, epsilon, minPts)
% 输入参数：
% X：数据矩阵，每一行代表一个数据点，每一列代表一个特征。
% epsilon：DBSCAN中的邻域半径参数。
% minPts：DBSCAN中的核心点要求的最小邻居数。
% 输出参数：
% clusterIds：聚类结果，向量长度等于数据点数目，-1代表噪音点，其他数字代表所属聚类簇的编号。
% coreIdx：核心点索引向量，长度等于核心点个数。

n = size(X,1); % 数据点数目
distMatrix = squareform(pdist(X)); % 计算欧氏距离矩阵
coreIdx = find(sum(distMatrix < epsilon, 2) >= minPts); % 找出所有核心点
nCore = length(coreIdx); % 核心点数目

clusterIds = 100 * ones(n, 1); % 初始时所有点为噪音点
clusterId = 0; % 初始聚类簇编号为0

for i = 1:nCore % 从每个核心点开始扩展聚类簇
    if clusterIds(coreIdx(i)) == 100 % 如果这个点还没有被归为聚类簇
        clusterId = clusterId + 1; % 新建一个聚类簇
        neighbors = find(distMatrix(coreIdx(i),:) < epsilon); % 找出它的所有邻居
        clusterIds(coreIdx(i)) = clusterId; % 把它本身归为该聚类簇
        while ~isempty(neighbors) % 不断扩展聚类簇
            nextPoint = neighbors(1); % 取出队列中的下一个点
            if clusterIds(nextPoint) == 100 % 如果这个点还没有被归为聚类簇
                clusterIds(nextPoint) = clusterId; % 把它归为该聚类簇
                pointNeighbors = find(distMatrix(nextPoint,:) < epsilon); % 找出它的所有邻居
                if length(pointNeighbors) >= minPts % 如果它是核心点
                    neighbors = [neighbors, pointNeighbors]; % 将其邻居加入队列
                end
            end
            neighbors(1) = []; % 从队列中删除已经处理过的点
        end
    end
end