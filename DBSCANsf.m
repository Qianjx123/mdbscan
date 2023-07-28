clc;clear;close all
load ('compound.mat');
epsilon=1.3; 
MinPts=3; 
DBSCAN(data,epsilon,MinPts);
drawgraph(DBSCAN(data,epsilon,MinPts),data);
