clc;clear;close all
load ('2circles.mat');
%% DBSCAN�㷨
epsilon=10; 
MinPts=37; 
IDX=DBSCAN(data,epsilon,MinPts);
Evaluation(label,IDX);