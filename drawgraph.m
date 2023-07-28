function Clust = drawgraph(Clust,data)
% figure;
 set(gca,'looseInset',[0 0 0 0]);
xx=data(:,1);
yy=data(:,2);     
 
for i=unique(Clust)'
%     if i<=10000

     scatter(xx(Clust==i),yy(Clust==i),25,'filled');    hold on;
     %scatter»æÖÆÉ¢µãÍ¼
%     end
end
% xlim([-0.05 1.05]);
% ylim([-0.05 1.05]);
%plot the noise
% scatter(x(Clust==100),y(Clust==100));
% 
% plot centers

box on;
% hold on;
% xlabel ('\itx');
%  ylabel ('\ity');
end