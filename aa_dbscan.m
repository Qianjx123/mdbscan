function [clusterIds, coreIdx] = aa_dbscan(X, epsilon, minPts)
% ���������
% X�����ݾ���ÿһ�д���һ�����ݵ㣬ÿһ�д���һ��������
% epsilon��DBSCAN�е�����뾶������
% minPts��DBSCAN�еĺ��ĵ�Ҫ�����С�ھ�����
% ���������
% clusterIds�����������������ȵ������ݵ���Ŀ��-1���������㣬�������ִ�����������صı�š�
% coreIdx�����ĵ��������������ȵ��ں��ĵ������

n = size(X,1); % ���ݵ���Ŀ
distMatrix = squareform(pdist(X)); % ����ŷ�Ͼ������
coreIdx = find(sum(distMatrix < epsilon, 2) >= minPts); % �ҳ����к��ĵ�
nCore = length(coreIdx); % ���ĵ���Ŀ

clusterIds = 100 * ones(n, 1); % ��ʼʱ���е�Ϊ������
clusterId = 0; % ��ʼ����ر��Ϊ0

for i = 1:nCore % ��ÿ�����ĵ㿪ʼ��չ�����
    if clusterIds(coreIdx(i)) == 100 % �������㻹û�б���Ϊ�����
        clusterId = clusterId + 1; % �½�һ�������
        neighbors = find(distMatrix(coreIdx(i),:) < epsilon); % �ҳ����������ھ�
        clusterIds(coreIdx(i)) = clusterId; % ���������Ϊ�þ����
        while ~isempty(neighbors) % ������չ�����
            nextPoint = neighbors(1); % ȡ�������е���һ����
            if clusterIds(nextPoint) == 100 % �������㻹û�б���Ϊ�����
                clusterIds(nextPoint) = clusterId; % ������Ϊ�þ����
                pointNeighbors = find(distMatrix(nextPoint,:) < epsilon); % �ҳ����������ھ�
                if length(pointNeighbors) >= minPts % ������Ǻ��ĵ�
                    neighbors = [neighbors, pointNeighbors]; % �����ھӼ������
                end
            end
            neighbors(1) = []; % �Ӷ�����ɾ���Ѿ�������ĵ�
        end
    end
end