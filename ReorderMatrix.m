function [newM,clusteridx,clustercount,matidx,pos,aveabseigvec]=ReorderMatrix(Mat,clusteridx,U)
clusteridx=SortGroups(clusteridx,U);
aveabseigvec=PlotEigenvector(U,clusteridx);
[firordermat,clustercount]=GroupMatrix(Mat,clusteridx);
[newM,matidx,pos]=SecOrderMatrix(firordermat,clustercount);
end

function clusteridx=SortGroups(clusteridx,U)
% sorting groups according to the contribution of eigenvectors.
clidx=clusteridx;
numcluster=length(unique(clusteridx));
for i=1:numcluster
    U_gp=U(clusteridx==i,:);
    aveabseigvec(i,:)=mean(abs(U_gp)-mean(abs(U_gp),2),1);
end
[~,newidx]=sort(aveabseigvec,2,'descend');
clusteridx=[];
[~,sortidx]=sort(newidx,'ascend');
for i=1:length(newidx)
    clusteridx(clidx==sortidx(i),1)=i;
end
end


function aveabseigvec=PlotEigenvector(U,clusteridx)
colorbarset.nf='on';
colorbarset.ticks=-1:0.1:1;
colorbarset.ticklabels={-1:0.1:1};
numcluster=length(unique(clusteridx));
for i=1:numcluster
    % identify eigenvector contribution for each group with data matrix
    figure(3)
    subplot(4,numcluster,[i,i+numcluster,i+2*numcluster])
    U_gp=U(clusteridx==i,:);
    imagesc(abs(U_gp)-mean(abs(U_gp),2),[0 0.03])
    xticklabels([])
    if i==1
        axisformat('','components','',['(a',num2str(i),')'],0,[],{},colorbarset)
    else
        axisformat('','','',['(a',num2str(i),')'],0,[],{},colorbarset)
    end
    if i==numcluster
        colormap hot
        colorbar('FontSize',10,'TickLabelInterpreter','latex')
    end
    subplot(4,numcluster,3*numcluster+i)
    imagesc(mean(abs(U_gp)-mean(abs(U_gp),2),1),[0 0.03])
    aveabseigvec(i,:)=mean(abs(U_gp)-mean(abs(U_gp),2),1);
    yticklabels([])
    if i==1
        axisformat('eigenvectors','','',['(b',num2str(i),')'],0,[],{},colorbarset)
    else
        axisformat('','','',['(b',num2str(i),')'],0,[],{},colorbarset)
    end
end
end


function [newM,clustercount]=GroupMatrix(Mat,clusteridx)
matidx=[];
for i=1:length(unique(clusteridx))
    matidx=[matidx;find(clusteridx==i)];
    clustercount(i)=sum(clusteridx==i);
end
newM=Mat(matidx,matidx);
end


function [newmat,idx,pos]=SecOrderMatrix(mat,clustercount)
pos=[];
pos(1)=0;
for i=1:length(clustercount)
    pos(i+1)=pos(i)+clustercount(i);
end
idx=[];
for i=1:length(pos)-1
    submat{i}=mat(pos(i)+1:pos(i+1),pos(i)+1:pos(i+1));
    col=mean(submat{i},2);
    row=mean(submat{i},1);
    ave=(col'+row)/2;
    [~,ci]=sort(row,'descend');
    idx=[idx,ci+pos(i)];
    clear ci ri
end
newmat=mat(idx,:);
newmat=newmat(:,idx);
end

