% x = [1	2	3	4	5	6	7	8	9	10	11	12	13	14	15
% ];
% yNMI = [0.5543	0.6478	0.6571	0.6364	0.6595	0.6231	0.5032	0.5202	0.4967	0.4686	0.0443	0.0443	0.0443	0.0443	0.0443
% ];
% yARI = [0.5034	0.6614	0.6821	0.7298	0.7414	0.6981	0.4285	0.4272	0.4282	0.4065	0.0079	0.0079	0.0079	0.0079	0.0079
% ];
% yACC = [0.831	0.871	0.8746	0.8937	0.8951	0.876	0.705	0.7032	0.7053	0.6925	0.2971	0.2971	0.2971	0.2971	0.2971
% ];
% plot(x,yNMI,'LineWidth',2)
% ylim([0 1])
% xlim([0 16])
% hold on
% plot(x,yARI,'LineWidth',2)
% plot(x,yACC,'LineWidth',2)



% figure(1)
% bar(x,y);  %使用bar函数绘制柱状图
% xlabel('classification of the crowd');
% ylabel('percentage');
% 
% title('Proportion of participants')
% hold on
% x1 = categorical({'man' 'womean' });
% y1 = [48.4 51.6 ];
% bar(x1,y1);  %使用bar函数绘制柱状图
% xlabel('classification of the crowd');
% ylabel('percentage');
% ylim([0 100])
% title('Proportion of participants')








x = [5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24
];
yNMI = [0.9496	0.9496	0.9496	0.9496	0.9496	0.9496	0.9496	0.9496	0.9496	0.9496	0.9496	0.9496	0.9496	0.9496	0.9496	0.9496	0.9496	0.9496	0.9496	0.9496
];
yARI = [0.9775	0.9775	0.9775	0.9775	0.9775	0.9775	0.9775	0.9775	0.9775	0.9775	0.9775	0.9775	0.9775	0.9775	0.9775	0.9775	0.9775	0.9775	0.9775	0.9775
];

plot(x,yNMI,'LineWidth',2)
ylim([0.9 1.1])
xlim([4 25])
hold on
plot(x,yARI,'LineWidth',2)
