function axisformat(xlabelname,ylabelname,zlabelname,titlename,needlegend,legendvector,legendname,set)
colormap(customcolormap_preset('red-white-blue'));
if strcmp(set.nf,'off')==1
    colorbar off
elseif strcmp(set.nf,'on')==1
    c=colorbar('TickLabelInterpreter','latex','Fontsize',11); 
    c.Ticks=set.ticks;
    c.TickLabels=set.ticklabels;
end

if needlegend==1
    legend(legendvector,legendname,'interpreter','latex','fontsize',12) % 12
end
ax=gca;
ax.TickLabelInterpreter ='latex';
ax.FontSize=11;
xlabel(xlabelname,'interpreter','latex','fontsize',16);% 14
ylabel(ylabelname,'interpreter','latex','fontsize',16);% 14
zlabel(zlabelname,'interpreter','latex','fontsize',16);% 14
title(titlename,'Interpreter','latex','fontsize',16)%14
end