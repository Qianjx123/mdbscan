%% DBSCAN�㷨ʵ��汾

clc;clear;close all
addpath('D:\mega\work\evaluation', 'D:\mega\work\Complicate','D:\mega\work\UCI','D:\mega\work\drawGraph','D:\mega\work\Complicate','D:\mega\work\VDPC\vdpc+�������ʵ��\�������');
% load('pathbased.mat');% load your datasets.
%load('Flame.mat');% load your datasets.
 %load('oliver.mat');% load your datasets.
  %load('flame.mat');% load your datasets.

  load('smile2.mat');% load your datasets.
% data=loadmovement_libras ('t7.10k.dat');
% data=temp;
%% Load Data
%  load('E:\MEGAFile\work\Complicate\Jain.mat');
% data=load('E:\MEGAFile\work\Complicate\t4.8k.txt');
%load('E:\MEGAFile\work\Complicate\two_circles_noise.mat');% ���Ը����Լ��������ļ���ַ����
% T=data;
% X=T;
Row = size(data,1);
Col = size(data,2);

%% Run DBSCAN Clustering Algorithm  
epsilon=60;
MinPts=3
idx=DBSCAN(data,epsilon,MinPts);
%% Plot Results
% Ex_evaluation
% PlotClusterinResult(X, idx);
% grid off;
%title(['DBSCAN Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts) ')']);
figure;
% title('������');  


% set (gcf,'Position',[0,0,500,500]);
 idx=idx+ones(length(idx),1);
   drawgraph(idx,data);
 set(gca,'looseInset',[0 0 0 0]);
  Evaluation(label,idx);

