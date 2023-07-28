clc;clear;close all
load ('2circles.mat');
%% DBSCANÀ„∑®
epsilon=10; 
MinPts=37; 
IDX=DBSCAN(data,epsilon,MinPts);
Evaluation(label,IDX);