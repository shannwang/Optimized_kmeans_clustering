% author: Shanshan Wang
% Email: shanshan.wang@uni-due.de

clc
clear all
close all

% load the reduced-rank correlation matrix of the NRW motorway network for workdays
load('redcorr_workday.mat')
Mat=redcorr_workday;


%% plot the reduced-rank matrix correlation matrix
colorbarset.nf='on';
colorbarset.ticks=-1:0.1:1;
colorbarset.ticklabels={-1:0.1:1};
figure(1)
imagesc(Mat,[-0.4 0.4])
axisformat('sections','sections','','matrix with ungrouped sections',0,[],{},colorbarset)


%% optimized k-means clustering
% preset the number of clusters
K=4;
% give a random seed to control the random number generator
randnum=437;  %7845
% use optimized k-means clustering to obtain the cluster number, the matrix
% of eigenvectors used for clustering, and the silhouette values for all
% observations
[clusteridx,U,sil]=OKCluster(Mat,K,randnum);
figure(2)
PlotSilhouette(clusteridx, sil);


%% reorder the matrix
[reorderMat,reorderclusteridx,clustercount,matidx,pos,aveabseigvec]=ReorderMatrix(Mat,clusteridx,U);


%% plot the reduced-rank matrix correlation matrix with grouped sections
figure(4)
imagesc(reorderMat,[-0.4 0.4])
axisformat('sections','sections','','matrix with grouped sections',0,[],{},colorbarset)
grouplabel=(pos(1:end-1)+pos(2:end))/2;
hold on
for i=2:length(clustercount)
    plot(0:length(reorderclusteridx)+1,ones(1,length(reorderclusteridx)+2)*pos(i),'k-','linewidth',1)
    plot(ones(1,length(reorderclusteridx)+2)*pos(i),0:length(reorderclusteridx)+1,'k-','linewidth',1)
end
yticks(grouplabel)
yticklabels({'G1','G2','G3','G4','G5','G6'})
xticks(grouplabel)
xticklabels({'G1','G2','G3','G4','G5','G6'})


%% plot silhouette values with reodered groups
figure(5)
PlotSilhouette(orderclusteridx, sil);




