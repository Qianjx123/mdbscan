function [labels] = pacadbscan(X, eps, MinPts, delta)
% X: 数据矩阵，每行代表一个样本
% eps: 聚类半径
% MinPts: 最小样本数
% delta: PACA-DBSCAN参数，控制样本距离和密度估计误差的平衡

% 初始化变量
n = size(X, 1);
visited = false(n, 1);
noise = false(n, 1);
labels = zeros(n, 1);
clusterId = 0;

% 计算距离矩阵和PACA参数
D = pdist(X);
P = squareform(D);
paca_param = eps * (1 + delta) / sqrt(2);

% 遍历所有点
for i = 1:n
    % 如果该点已经访问过，跳过
    if visited(i)
        continue;
    end
    
    % 标记该点已经访问过
    visited(i) = true;
    
    % 寻找该点的密度直达点
    neighbors = find(P(i,:) <= paca_param);
    if length(neighbors) < MinPts
        % 如果该点密度不足以成为核心点，则将其标记为噪声点
        noise(i) = true;
    else
        % 如果该点是核心点，则将其加入到新的簇中
        clusterId = clusterId + 1;
        labels(i) = clusterId;
        for j = 1:length(neighbors)
            visited(neighbors(j)) = true;
            labels(neighbors(j)) = clusterId;
        end
        
        % 将该簇中的所有密度可达点加入到同一簇中
        while ~isempty(neighbors)
            current = neighbors(1);
            neighbors(1) = [];
            current_neighbors = find(P(current,:) <= paca_param);
            if length(current_neighbors) >= MinPts
                for j = 1:length(current_neighbors)
                    if ~visited(current_neighbors(j))
                        visited(current_neighbors(j)) = true;
                        neighbors(end+1) = current_neighbors(j);
                    end
                    if labels(current_neighbors(j)) == 0
                        labels(current_neighbors(j)) = clusterId;
                    end
                end
            end
        end
    end
end

% 将所有噪声点标记为-1
labels(noise) = 800;
end