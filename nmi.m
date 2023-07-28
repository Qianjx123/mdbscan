function MIhat = nmi( A, B )
%NMI Normalized mutual information
% http://en.wikipedia.org/wiki/Mutual_information
% http://nlp.stanford.edu/IR-book/html/htmledition/evaluation-of-clustering-1.html
% Author: http://www.cnblogs.com/ziqiao/   [2011/12/15]
 
if length( A ) ~= length( B)
    error('length( A ) must == length( B)');
end%����A��B���ȱ�����ͬ
if iscolumn(A)
    A=A';%��A��������������ת��Ϊ������
end
if iscolumn(B)
    B=B';%��B��������������ת��Ϊ������
end
total = length(A);%�ó�A(��B)�ĳ���
A_ids = unique(A);%Aȥ�أ���AΪ[1 2 3 3 4]��A_idsΪ[1 2 3 4]
A_class = length(A_ids);%�ó�A�в�ͬԪ��(������ָʵ�ʲ�ͬ����ĸ���)�ĸ���
B_ids = unique(B);%Bȥ��
B_class = length(B_ids);%�ó�B�в�ͬԪ��(������ָ����õ��Ĳ�ͬ�صĸ�������)�ĸ���
% Mutual information������Ϣ
idAOccur = double (repmat( A, A_class, 1) == repmat( A_ids', 1, total )); %�õ��ڵ���������N*C
%repmat( A, A_class, 1):��������A��Ϊ����ѵ�ΪA_class��1�еľ���
%��AΪ[1 1 2 3]',A_classΪ3�����ʽΪ[1 1 2 3 1 1 2 3 1 1 2 3]'
%repmat( A_ids', 1, total ):A_ids'Ϊ[1 2 3]��totalΪ4��
%��ʽΪ[1 2 3 1 2 3 1 2 3 1 2 3]
idBOccur = double (repmat( B, B_class, 1) == repmat( B_ids', 1, total ));%ͬ��
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