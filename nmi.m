function MIhat = nmi( A, B )
%NMI Normalized mutual information
% http://en.wikipedia.org/wiki/Mutual_information
% http://nlp.stanford.edu/IR-book/html/htmledition/evaluation-of-clustering-1.html
% Author: http://www.cnblogs.com/ziqiao/   [2011/12/15]
 
if length( A ) ~= length( B)
    error('length( A ) must == length( B)');
end%向量A和B长度必须相同
if iscolumn(A)
    A=A';%若A不是列向量则将其转置为列向量
end
if iscolumn(B)
    B=B';%若B不是列向量则将其转置为列向量
end
total = length(A);%得出A(或B)的长度
A_ids = unique(A);%A去重，若A为[1 2 3 3 4]则A_ids为[1 2 3 4]
A_class = length(A_ids);%得出A中不同元素(在这里指实际不同分类的个数)的个数
B_ids = unique(B);%B去重
B_class = length(B_ids);%得出B中不同元素(在这里指聚类得到的不同簇的个数个数)的个数
% Mutual information交互信息
idAOccur = double (repmat( A, A_class, 1) == repmat( A_ids', 1, total )); %得到节点社区矩阵N*C
%repmat( A, A_class, 1):将列向量A作为整体堆叠为A_class行1列的矩阵
%若A为[1 1 2 3]',A_class为3，则该式为[1 1 2 3 1 1 2 3 1 1 2 3]'
%repmat( A_ids', 1, total ):A_ids'为[1 2 3]，total为4，
%该式为[1 2 3 1 2 3 1 2 3 1 2 3]
idBOccur = double (repmat( B, B_class, 1) == repmat( B_ids', 1, total ));%同上
idABOccur = idAOccur * idBOccur';
Px = sum(idAOccur') / total;
Py = sum(idBOccur') / total;
Pxy = idABOccur / total;
MImatrix = Pxy .* log2(Pxy ./(Px' * Py)+eps);
MI = sum(MImatrix(:));
% Entropies
Hx = -sum(Px .* log2(Px + eps),2);
Hy = -sum(Py .* log2(Py + eps),2);
%Normalized Mutual information
MIhat = 2 * MI / (Hx+Hy);
 
 
% MIhat = MI / sqrt(Hx*Hy); another version of NMI
 
end