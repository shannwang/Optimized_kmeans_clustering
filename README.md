# Tutorial for using optimized k-means clustering

Shanshan Wang \
shanshan.wang@uni-due.de


Step 1: load a sysmetrical square matrix, e.g., the reduced-rank correlation matrix of the NRW motorway network for workdays

~~~
load('redcorr_workday.mat')
Mat=redcorr_workday;
~~~

Step 2: plot the matrix
~~~ 
colorbarset.nf='on';
colorbarset.ticks=-1:0.1:1;
colorbarset.ticklabels={-1:0.1:1};
figure(1)
imagesc(Mat,[-0.4 0.4])
axisformat('sections','sections','','matrix with ungrouped sections',0,[],{},colorbarset)
~~~
<img src="https://github.com/shannwang/Optimized_kmeans_clustering/raw/main/matrix_ungrouped.png?raw=true" width="600"> 


Step 3: perform optimized k-means clustering with a preset number of clusters and a random seed
~~~
K=4;
randnum=437; 
[clusteridx,U,sil]=OKCluster(Mat,K,randnum);
figure(2)
PlotSilhouette(clusteridx, sil);
~~~
<img src="https://github.com/shannwang/Optimized_kmeans_clustering/raw/main/silhouette_unordered.png?raw=true" width="600"> 


Step 4: reorder the matrix and identify the dominant eigenvector in each group according to eigenvector components
~~~
[reorderMat,reorderclusteridx,clustercount,matidx,pos,aveabseigvec]=ReorderMatrix(Mat,clusteridx,U);
~~~
<img src="https://github.com/shannwang/Optimized_kmeans_clustering/raw/main/identifyeigenvector.png?raw=true" width="900"> 



Step 5:  plot the reduced-rank matrix correlation matrix with grouped sections
~~~
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
~~~
<img src="https://github.com/shannwang/Optimized_kmeans_clustering/raw/main/matrix_grouped.png?raw=true" width="600"> 


Step 6: plot silhouette values with reodered groups
~~~
figure(5)
PlotSilhouette(orderclusteridx, sil);
~~~
<img src="https://github.com/shannwang/Optimized_kmeans_clustering/raw/main/silhouette_reordered.png?raw=true" width="600"> 




### Reference

Shanshan Wang, Michael Schreckenberg and Thomas Guhr, Identifying subdominant collective effects in a large motorway network, J. Stat. Mech. (2022) 113402
https://doi.org/10.1088/1742-5468/ac99d4
