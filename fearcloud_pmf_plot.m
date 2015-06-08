function fearcloud_pmf_plot(subject,phase)

global project_path

Log       = isn_GetData(subject,phase,'stimulation');
p = Log.p;
psi       = Log.p.psi;x         = 0:1:100;
xstimrange= psi.stimRange;
% collect number of trials per stimulus Level

minn=5;
maxn=25;
%
fig=figure('units','normalized','outerposition',[0 0 0.45 1]);
suptitle(sprintf('Fitting Subject %g, Phase %g',subject,phase));

for chain=1:size(p.psi.log.x,1)
    %dotsize gets scaled by number of trials at this x
    dotsize  = Scale(sum(~isnan(p.psi.log.xrounded(:,:,chain)),2))*(maxn-minn)+minn;
    pcorrect = nanmean(p.psi.log.xrounded(:,:,chain),2);
    error    = nanstd(p.psi.log.xrounded(:,:,chain),0,2);
    
    subplot(4,2,chain)
    plot(x,...
        PAL_CumulativeNormal([p.psi.log.alpha(chain,end) 10.^(p.psi.log.beta(chain,end)) p.psi.log.gamma(chain,end) p.psi.log.lambda(chain,end)],x),'k','linewidth',3)
    hold on;
    
    %detect the nonnan entries
    %     for i =  find(~isnan(pcorrect(:))')
    %         errorbar(xstimrange(i),pcorrect(i),error(i),'ko','Markersize',dotsize(i));
    %         hold on;
    %     end
    for i =  find(~isnan(pcorrect(:))')
        errorbar(xstimrange(i),pcorrect(i),error(i),'o','Markersize',10,'markerfacecolor',[0.3 0.3 0.3],'color',[0.3 0.3 0.3]);
        hold on;
    end
    ylabel('p(different)')
    xlabel('X (deg)')
    xlim([-10 100])
    ylim([-.4 1.4])
    if chain==1
        title('CS+')
    else
        title('CS-')
    end
    hold off
    box off;
    line([p.psi.log.alpha(end) p.psi.log.alpha(end)],[ylim],'Color','r')
    
    
    subplot(4,2,2+chain)
    for i =  find(~isnan(pcorrect(:))')
        plot(xstimrange(i),1.2,'o','color',[0.3 0.3 0.3],'Markersize',dotsize(i),'MarkerFaceColor',[0.3 0.3 0.3]);
        hold on;
    end
    xlim([-10 100]);
    title('Number of Presentations')
    box off;
    grid on;
    set(gca,'yticklabel',[],'ytick',[],'ycolor',[1 1 1],'xtick',xstimrange,'xtick',xstimrange(1:2:end));
     xlabel('X (deg)')
    text(xstimrange(1),1.9,'20%')
    
    subplot(4,2,4+chain)
    plot(1:length(p.psi.log.alpha(chain,:)),p.psi.log.alpha(chain,:),'r-')
    hold on;
    errorbar([1 length(p.psi.log.alpha(chain,:))],p.psi.log.alpha(chain,[1 end]),p.psi.log.seAlpha(chain,[1 end]),'ro')
    title(sprintf('estimated alpha=%3.3g (%3.3g)',p.psi.log.alpha(chain,end),p.psi.log.seAlpha(chain,end)))
    xlim([-5 length(p.psi.log.beta(chain,:))+5])
    box off;
     xlabel('# trials')
     ylabel('alpha (degrees)');
    
    subplot(4,2,6+chain)
    plot(1:length(p.psi.log.beta(chain,:)),(10.^-p.psi.log.beta(chain,:)),'b-')
    hold on;
    errorbar([1 length(p.psi.log.beta(chain,:))],(10.^-p.psi.log.beta(chain,[1 end])),(10.^-p.psi.log.seBeta(chain,[1 end])),'bo')
    title(sprintf('estimated beta in SD = %3.3g (%3.3g)',(10.^-p.psi.log.beta(chain,end)),(10.^-p.psi.log.seBeta(chain,end))))
    xlim([-5 length(p.psi.log.beta(chain,:))+5])
    box off;
     xlabel('# trials')
     ylabel('sd (degrees)');
end

%%%%
save_path = sprintf('%sfigures/%s.bmp',isn_GetPath(subject,phase),mfilename);
hgexport(fig,save_path);
save_path = sprintf('%sfigures/%s.eps',isn_GetPath(subject,phase),mfilename);
hgexport(fig,save_path);