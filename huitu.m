k=[34,36,38,40,42,44];
title('Comparison of the Jain dataset','position',[6.5,1.1])
acc1=[0.8472,0.8253,0.8620,0.8350,0.8337,0.8276];
acc2=[0.8808,0.8255,0.8892,0.8431,0.8213,0.8129];
plot(k,acc1);
 xlim([33 45]);
 ylim([0.75 0.95]);
 hold on;
 plot(k,acc2)
 xlabel('K-value');
 ylabel('Acc indicator');