% output ARI, NMI, Fmeasure, Accuracy
function  [acc]  = Evaluation(label,idx)
NMI = nmi( label, idx );%��׼������Ϣ�����������ݷֲ����Ǻϳ̶�
 [AR,RI,MI,HI]=RandIndex(label,idx);%����������ǣ���ʵ��Ǻ�dpc�㷨��ǣ����Ǻϳ̶�
[acc,FMeasure,F1,Jaccard] = Fmeasure(label,idx);%��һ��p��������r�ļ���ƽ����
% [f_measure,gmean]= Fm(label,idx);
%  [NewLabel]=BestMapping(label,idx);

ARI=AR;
% fprintf('���������ۣ� \n');
% fprintf('NMIָ�꣺%5.4f   \n',NMI);
%  fprintf('ARIָ�꣺%5.4f   \n',AR);
%  fprintf('RIָ�꣺%5.4f   \n',RI);
%  fprintf('Jaccardָ�꣺%5.4f   \n',Jaccard);
% fprintf('Fowlkes-Mallows scores(FMI)ָ�꣺%5.4f   \n',FMeasure);
% fprintf('F1ָ�꣺%5.4f   \n',F1);
% fprintf('FMָ�꣺%5.4f   \n',f_measure);
% fprintf('FMָ�꣺%5.4f   \n',gmean);
%  acc=ClusterAcc(label,NewLabel);
% fprintf('accָ�꣺%5.4f   \n',acc);
% fprintf('F1ָ�꣺%5.4f   \n',F1);
end