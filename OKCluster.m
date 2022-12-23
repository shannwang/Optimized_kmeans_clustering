
function [clusteridx_optimized,U,sil]=OKCluster(Mat,K,num)
% Mat: a symmetrical square matrix
% K: the preset number of clusters
% num: a rand seed
% clusteridx_optimized: indices for optimized clusters
% U: a matrix where each column is a eigenvector used for clustering
% sil: silhouette values for all observations

[clusteridx_optimized,sil,U]=Clustering(Mat,K,num);

end

function [clusteridx_optimized,sil,U]=Clustering(Mat,K,num)
% Control random number generator with a given rand seed 
rng(num)
% find used eigenvectors for clustering
U=UsedEigVector(Mat,K);
% set random initial values for k-means clustering
st=randn(K,K-1); 
% k-means clustering
clusteridx=kmeans(U,K,'Distance','sqeuclidean','Start',st,'MaxIter',100);
% optimize the clustering
clusteridx_optimized=OptimizeCluster(U,clusteridx,K,'sqeuclidean');
% calcuate silhouette values
sil=silhouette(U,clusteridx_optimized,'sqeuclidean');
end

function U=UsedEigVector(Mat,K)
M=Mat;
M(isinf(M))=0;
M(isnan(M))=0;
[V,D]=eig(M);
% sort eigenvalue from large to small
[~,idx]=sort(diag(D),'descend'); 
% sort eigenvectors according to the order of eigenvalues
V=V(:,idx); 
% used eigenvectors for clustering
U=V(:,1:K-1); 
clear idx
end

function clusteridx=OptimizeCluster(U,clusteridx,K,distancemetric)
sil=silhouette(U,clusteridx,distancemetric);
% assign the observations with negative silhouette to an additional cluster K+1
clusteridx(sil<0)=K+1;
ii=0;
while ii<K+1
    ii=ii+1;
    negsilidx=find(clusteridx==K+1);
    for i=1:length(negsilidx)
        asil=[];
        for k=1:K+1
            % assign the observations in cluster K+1 to each cluster and calculate
            % silhouette value for each case
            clusteridx(negsilidx(i))=k;
            % calcualte silhouette values for all points
            sil0=silhouette(U,clusteridx,distancemetric);
            asil=[asil; sil0(negsilidx(i))];
            clear sil0
        end
        % find the cluster which results in the maximal silhouette value
        % for the observation with index negsilidx(i)
        [~,j]=max(asil);
        % assign the observation to the above cluster
        clusteridx(negsilidx(i))=j;
        clear j
    end
    clear sil negsilidx
    % calcualte silhouette values for all observations
    sil=silhouette(U,clusteridx,distancemetric);
    % assign the points with negative silhouette to cluster K+1
    clusteridx(sil<0)=K+1;
end
end
