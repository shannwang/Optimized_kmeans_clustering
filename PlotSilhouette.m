function PlotSilhouette(IDX, s)
% U: a matrix where each column is a eigenvector used for clustering
% IDX: cluster number for all observations
% s: silhouette values for all observations

N = length(IDX);   % number of observations
NC = numel(unique(IDX));  % number of clusters
space=30;
[~,ord] = sortrows([IDX s],[1 -2]);
s_ord=s(ord);
idx_ord=IDX(ord);
uidx=unique(idx_ord);
s_nord=[];
idx_nord=[];
for i=1:NC
    s_nord=[s_nord;zeros(space,1);s_ord(idx_ord==uidx(i))];
    idx_nord=[idx_nord;ones(space,1)*i;idx_ord(idx_ord==uidx(i))];
end
indices = accumarray(idx_nord, 1:N+space*NC, [NC 1], @(x){sort(x)});
ytick = cellfun(@(ind) (min(ind)+max(ind))/2, indices);
ytickLabels = num2str((1:NC)','%d');    
h = barh(1:N+space*NC, s_nord,'hist');
set(h, 'EdgeColor',[0 0.45 0.74], 'CData',idx_nord)
ylim([1 N+space*NC+space])
set(gca, 'CLim',[1 NC], 'CLimMode','manual')
set(gca, 'YDir','reverse', 'YTick',ytick, 'YTickLabel',ytickLabels)
colorbarset.nf='off';
axisformat('Silhouette Value','Cluster','','',0,[],{},colorbarset)
end