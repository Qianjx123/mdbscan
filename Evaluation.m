% output ARI, NMI, Fmeasure, Accuracy
function  [NMI,ARI]  = Evaluation(label,idx)
NMI = nmi( label, idx );%标准化互信息衡量两个数据分布的吻合程度
 [AR,RI,MI,HI]=RandIndex(label,idx);%计算两个标记（真实标记和dpc算法标记）的吻合程度
[acc,FMeasure,F1,Jaccard] = Fmeasure(label,idx);%均一性p和完整性r的几何平均数
% [f_measure,gmean]= Fm(label,idx);
%  [NewLabel]=BestMapping(label,idx);

ARI=AR;
fprintf('聚类结果评价： \n');
fprintf('NMI指标：%5.4f   \n',NMI);%
fprintf('ARI指标：%5.4f   \n',AR);

%  fprintf('RI指标：%5.4f   \n',RI);
%  fprintf('Jaccard指标：%5.4f   \n',Jaccard);
% fprintf('Fowlkes-Mallows scores(FMI)指标：%5.4f   \n',FMeasure);
% fprintf('F1指标：%5.4f   \n',F1);
% fprintf('FM指标：%5.4f   \n',f_measure);
% fprintf('FM指标：%5.4f   \n',gmean);
%  acc=ClusterAcc(label,NewLabel);
fprintf('acc指标：%5.4f   \n',acc);
% fprintf('F1指标：%5.4f   \n',F1);
end
