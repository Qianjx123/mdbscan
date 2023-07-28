function [labels] = pacadbscan(X, eps, MinPts, delta)
% X: ���ݾ���ÿ�д���һ������
% eps: ����뾶
% MinPts: ��С������
% delta: PACA-DBSCAN��������������������ܶȹ�������ƽ��

% ��ʼ������
n = size(X, 1);
visited = false(n, 1);
noise = false(n, 1);
labels = zeros(n, 1);
clusterId = 0;

% �����������PACA����
D = pdist(X);
P = squareform(D);
paca_param = eps * (1 + delta) / sqrt(2);

% �������е�
for i = 1:n
    % ����õ��Ѿ����ʹ�������
    if visited(i)
        continue;
    end
    
    % ��Ǹõ��Ѿ����ʹ�
    visited(i) = true;
    
    % Ѱ�Ҹõ���ܶ�ֱ���
    neighbors = find(P(i,:) <= paca_param);
    if length(neighbors) < MinPts
        % ����õ��ܶȲ����Գ�Ϊ���ĵ㣬������Ϊ������
        noise(i) = true;
    else
        % ����õ��Ǻ��ĵ㣬������뵽�µĴ���
        clusterId = clusterId + 1;
        labels(i) = clusterId;
        for j = 1:length(neighbors)
            visited(neighbors(j)) = true;
            labels(neighbors(j)) = clusterId;
        end
        
        % ���ô��е������ܶȿɴ����뵽ͬһ����
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

% ��������������Ϊ-1
labels(noise) = 800;
end